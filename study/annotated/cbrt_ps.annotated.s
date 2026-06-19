; ============================================================================
;  avx2_cbrt_ps  -  cube root of 8 floats  -  ANNOTATED DISASSEMBLY
; ============================================================================
;
;  Source: include/avx2_math_f32.h  (avx2_cbrt_ps)
;  Build:  gcc -O3 -mavx2 -mfma, Windows x64. Intel syntax (dst first).
;
;  Two ideas on display:
;    1. INITIAL GUESS by bit surgery. Treat |x|'s 32 bits as an integer ix,
;       divide by 3, add a magic bias -> a float within ~a few % of cbrt(|x|).
;       AVX2 has no integer divide, so /3 is done with the multiply-high trick
;       n/3 = (n * 0xAAAAAAAB) >> 33, using vpmuludq (32x32 -> 64-bit).
;    2. REFINEMENT by Halley's method (cubic convergence):
;         y <- y * (y^3 + 2a) / (2*y^3 + a),  a = |x|.
;       Two iterations take the ~few-% seed to <= 3 ULP.
;
;  Windows x64 ABI: rcx = result ptr, rdx = &x, xmm6 callee-saved (spilled).
; ----------------------------------------------------------------------------

avx2k_cbrt_ps:
  d90:  48 83 ec 18           sub    rsp,0x18          ; stack frame for the xmm6 spill
  d94:  c5 f8 11 34 24        vmovups [rsp],xmm6       ; save callee-saved xmm6

  d99:  c4 e2 7d 18 0d ..     vbroadcastss ymm1,[rip+..] ; ymm1 = -0.0  = 0x80000000 = the SIGN-BIT mask
  da2:  c5 fc 10 1a           vmovups ymm3,[rdx]       ; ymm3 = x  (keep the original for sign/NaN)
  da6:  ba ab aa aa aa        mov    edx,0xaaaaaaab    ; the /3 multiply-high magic (~2^33 / 3)
  dab:  c5 f9 6e ea           vmovd  xmm5,edx          ; move it into a vector lane...
  daf:  ba 67 40 51 2a        mov    edx,0x2a514067    ; ...and stage the cbrt bias magic in edx
  db4:  c5 e4 54 e1           vandps ymm4,ymm3,ymm1    ; ymm4 = x & signbit          = SIGN of x
  db8:  c5 f4 55 cb           vandnps ymm1,ymm1,ymm3   ; ymm1 = ~signbit & x = |x|   = a  (its bits = ix)
  dbc:  c4 e2 7d 58 ed        vpbroadcastd ymm5,xmm5   ; ymm5 = 0xAAAAAAAB in all 8 lanes

  ; ---- integer ix / 3  via  (ix * 0xAAAAAAAB) >> 33, done in two halves ----
  dc1:  c5 ed 73 d1 20        vpsrlq ymm2,ymm1,0x20    ; ymm2 = ix >> 32  (bring ODD dwords into even slots)
  dc6:  c5 f5 f4 c5           vpmuludq ymm0,ymm1,ymm5  ; ymm0 = EVEN dwords(ix) * magic -> 64-bit products
  dca:  c5 ed f4 d5           vpmuludq ymm2,ymm2,ymm5  ; ymm2 = ODD  dwords(ix) * magic -> 64-bit products
  dce:  48 89 c8              mov    rax,rcx           ; ABI: return value = result ptr
  dd1:  c4 e2 7d 18 2d ..     vbroadcastss ymm5,[rip+..] ; ymm5 = 2.0   (Halley constant)
  dda:  c5 fd 73 d0 21        vpsrlq ymm0,ymm0,0x21    ; ymm0 >>= 33  -> floor(ix/3) for even dwords
  ddf:  c5 ed 73 d2 21        vpsrlq ymm2,ymm2,0x21    ; ymm2 >>= 33  -> floor(ix/3) for odd dwords
  de4:  c5 ed 73 f2 20        vpsllq ymm2,ymm2,0x20    ; ymm2 <<= 32  -> put odd quotients back in odd slots
  de9:  c5 fd eb c2           vpor   ymm0,ymm0,ymm2    ; ymm0 = q = floor(ix/3) for ALL 8 dwords
  ded:  c5 f9 6e d2           vmovd  xmm2,edx          ; bring the bias magic into a lane
  df1:  c4 e2 7d 58 d2        vpbroadcastd ymm2,xmm2   ; ymm2 = 0x2a514067 broadcast
  df6:  c5 fd fe c2           vpaddd ymm0,ymm0,ymm2    ; ymm0 = q + bias  = SEED bit pattern (now read as float y0)

  ; ---- Halley iteration 1:  y1 = y0 * (y0^3 + 2a) / (2*y0^3 + a) ----
  dfa:  c5 fc 28 d5           vmovaps ymm2,ymm5        ; ymm2 = 2.0 (working copy)
  dfe:  c5 fc 59 f0           vmulps ymm6,ymm0,ymm0    ; ymm6 = y0^2
  e02:  c5 cc 59 f0           vmulps ymm6,ymm6,ymm0    ; ymm6 = y0^3
  e06:  c4 e2 4d 98 d1        vfmadd132ps ymm2,ymm6,ymm1 ; ymm2 = 2.0*a + y0^3 = y0^3 + 2a   (numerator)
  e0b:  c4 e2 75 98 f5        vfmadd132ps ymm6,ymm1,ymm5 ; ymm6 = y0^3*2.0 + a = 2*y0^3 + a   (denominator)
  e10:  c5 ec 5e d6           vdivps ymm2,ymm2,ymm6    ; ymm2 = num / den
  e14:  c5 ec 59 d0           vmulps ymm2,ymm2,ymm0    ; ymm2 = y1 = y0 * num/den

  ; ---- Halley iteration 2 (same shape, y1 -> y2) ----
  e18:  c5 fc 28 c5           vmovaps ymm0,ymm5        ; ymm0 = 2.0 (working copy)
  e1c:  c5 ec 59 f2           vmulps ymm6,ymm2,ymm2    ; ymm6 = y1^2
  e20:  c5 cc 59 f2           vmulps ymm6,ymm6,ymm2    ; ymm6 = y1^3
  e24:  c4 e2 75 98 ee        vfmadd132ps ymm5,ymm1,ymm6 ; ymm5 = 2.0*y1^3 + a = 2*y1^3 + a (denominator)
  e29:  c4 e2 4d 98 c1        vfmadd132ps ymm0,ymm6,ymm1 ; ymm0 = 2.0*a + y1^3 = y1^3 + 2a  (numerator)
  e2e:  c5 e4 c2 f3 03        vcmpunordps ymm6,ymm3,ymm3 ; ymm6 = isnan(x) mask (imm 03 = UNORD)
  e33:  c5 fc 5e c5           vdivps ymm0,ymm0,ymm5    ; ymm0 = num / den
  e37:  c5 d0 57 ed           vxorps xmm5,xmm5,xmm5    ; ymm5 = 0.0
  e3b:  c5 f4 c2 ed 00        vcmpeqps ymm5,ymm1,ymm5  ; ymm5 = (a == 0) mask
  e40:  c5 fc 59 c2           vmulps ymm0,ymm0,ymm2    ; ymm0 = y2 = y1 * num/den   (FINAL magnitude)

  ; ---- reapply sign and mask the specials ----
  e44:  c4 e2 7d 18 15 ..     vbroadcastss ymm2,[rip+..] ; ymm2 = +inf
  e4d:  c5 f4 c2 ca 00        vcmpeqps ymm1,ymm1,ymm2  ; ymm1 = (a == +inf) mask
  e52:  c5 ec 56 d4           vorps  ymm2,ymm2,ymm4    ; ymm2 = +inf | sign = SIGNED inf
  e56:  c5 fc 56 c4           vorps  ymm0,ymm0,ymm4    ; ymm0 = y2  | sign = reapply x's sign (cbrt is odd)
  e5a:  c4 e3 7d 4a c4 50     vblendvps ymm0,ymm0,ymm4,ymm5 ; a==0   -> sign  (i.e. signed zero)
  e60:  c4 e3 7d 4a c2 10     vblendvps ymm0,ymm0,ymm2,ymm1 ; a==inf -> signed inf
  e66:  c4 e3 7d 4a c3 60     vblendvps ymm0,ymm0,ymm3,ymm6 ; NaN    -> x (propagate the input NaN)

  e6c:  c5 fc 11 01           vmovups [rcx],ymm0       ; store 8 results
  e70:  c5 f8 77              vzeroupper
  e73:  c5 f8 10 34 24        vmovups xmm6,[rsp]       ; restore xmm6
  e78:  48 83 c4 18           add    rsp,0x18
  e7c:  c3                    ret

; ----------------------------------------------------------------------------
;  THINGS TO NOTICE
;  - The whole "divide ix by 3" is six integer instructions and NO divide:
;       vpsrlq (split odd dwords) , two vpmuludq (32x32->64 multiplies) ,
;       two vpsrlq (>>33) , vpsllq + vpor (reassemble). vpmuludq only multiplies
;       the EVEN 32-bit lanes of each 64-bit group, which is exactly why the
;       input is processed as "even dwords" and "ix>>32 = odd dwords" separately.
;  - vandnps does (~signbit & x) = |x| in one op; vandps does (signbit & x) =
;    the sign. Stripping/restoring the sign is just two boolean ops because
;    IEEE-754 keeps the sign in a single top bit.
;  - Each Halley step is two vfmadd132ps (numerator & denominator built with one
;    rounding each), one vdivps, and a couple of vmulps. Cubic convergence means
;    two of these are plenty.
;  - vfmadd132ps vs ...231: the compiler picks the operand-order form that avoids
;    an extra move given which register already holds what. Watch ymm2/ymm5/ymm6
;    get reused as scratch between the numerator and denominator.
;  - vcmpunordps x,x is the standard "is x NaN?" test (a NaN is unordered with
;    itself). The three blendvps at the end layer the special cases in priority
;    order: signed-zero, then signed-inf, then NaN wins last.
; ============================================================================
