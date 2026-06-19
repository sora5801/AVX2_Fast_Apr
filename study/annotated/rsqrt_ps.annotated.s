; ============================================================================
;  avx2_rsqrt_ps  -  1/sqrt(x) for 8 floats  -  ANNOTATED DISASSEMBLY
; ============================================================================
;
;  Source: include/avx2_math_f32.h  (avx2_rsqrt_ps)
;  Build:  gcc -O3 -mavx2 -mfma, Windows x64 (COFF). Disassembly is Intel syntax
;          (dst first). Columns: offset, machine-code bytes, instruction, ; note.
;
;  This is the textbook "hardware seed + Newton-Raphson" pattern. The algorithm:
;      y0 = vrsqrtps(x)                  ; ~12 correct bits, one instruction
;      y1 = y0*(1.5 - 0.5*x*y0*y0)       ; Newton step -> ~24 bits
;      y2 = y1*(1.5 - 0.5*x*y1*y1)       ; Newton step -> full single precision
;  then fix up x==0 (+inf), x==+inf (0), x<0 (NaN).
;
;  ABI NOTE (Windows x64): a __m256 argument and return value travel through
;  memory. rcx = address to write the 8-float result, rdx = address of the input
;  vector. ALSO: on Windows, xmm6..xmm15 are CALLEE-SAVED (nonvolatile) - so the
;  function spills/reloads xmm6 around its use of ymm6. (On Linux/SysV none of
;  that glue exists: the value would arrive/return in ymm0.)
; ----------------------------------------------------------------------------

avx2k_rsqrt_ps:
  cf0:  48 83 ec 18           sub    rsp,0x18          ; reserve 24B stack (xmm6 spill slot + align)
  cf4:  c5 f8 11 34 24        vmovups [rsp],xmm6       ; save callee-saved xmm6 (Windows ABI)

  cf9:  c4 e2 7d 18 0d ..     vbroadcastss ymm1,[rip+..] ; ymm1 = 0.5  -> the "0.5*x" factor
  d02:  c4 e2 7d 18 25 ..     vbroadcastss ymm4,[rip+..] ; ymm4 = 1.5  (three_halves constant)
  d0b:  c5 fc 10 12           vmovups ymm2,[rdx]       ; ymm2 = x   (load the 8 input floats)
  d0f:  c5 ec 59 c9           vmulps  ymm1,ymm2,ymm1   ; ymm1 = 0.5*x  = "xhalf"
  d13:  c5 fc 52 c2           vrsqrtps ymm0,ymm2       ; ymm0 = y0 ~= 1/sqrt(x)  (12-bit SEED)
  d17:  48 89 c8              mov    rax,rcx           ; ABI: return value = the hidden result ptr

  ; ---- Newton-Raphson step 1:  y1 = y0 * (1.5 - xhalf*y0^2) ----
  d1a:  c5 fc 59 d9           vmulps  ymm3,ymm0,ymm1   ; ymm3 = y0 * xhalf
  d1e:  c4 e2 5d 9c d8        vfnmadd132ps ymm3,ymm4,ymm0 ; ymm3 = 1.5 - (y0*xhalf)*y0 = 1.5 - xhalf*y0^2
  d23:  c5 fc 59 c3           vmulps  ymm0,ymm0,ymm3   ; ymm0 = y1 = y0 * (1.5 - xhalf*y0^2)

  ; ---- edge mask: x == 0  (computed early; the OoO core overlaps it with NR) ----
  d27:  c5 e0 57 db           vxorps  xmm3,xmm3,xmm3   ; ymm3 = 0.0  (xor-self; VEX zeroes all 256b)
  d2b:  c5 ec c2 f3 00        vcmpeqps ymm6,ymm2,ymm3  ; ymm6 = (x == 0) ? all-ones : 0

  ; ---- Newton-Raphson step 2:  y2 = y1 * (1.5 - xhalf*y1^2) ----
  d30:  c5 f4 59 c8           vmulps  ymm1,ymm1,ymm0   ; ymm1 = xhalf * y1
  d34:  c4 e2 5d 9c c8        vfnmadd132ps ymm1,ymm4,ymm0 ; ymm1 = 1.5 - (xhalf*y1)*y1 = 1.5 - xhalf*y1^2

  ; ---- more edge masks ----
  d39:  c4 e2 7d 18 25 ..     vbroadcastss ymm4,[rip+..] ; ymm4 = +inf   (reuse ymm4; was 1.5)
  d42:  c5 ec c2 ec 00        vcmpeqps ymm5,ymm2,ymm4  ; ymm5 = (x == +inf) mask
  d47:  c5 ec c2 d3 01        vcmpltps ymm2,ymm2,ymm3  ; ymm2 = (x < 0) mask  (imm 01 = LT)

  d4c:  c5 fc 59 c1           vmulps  ymm0,ymm0,ymm1   ; ymm0 = y2  = refined 1/sqrt(x)  (FINAL math)
  d50:  c4 e2 7d 18 0d ..     vbroadcastss ymm1,[rip+..] ; ymm1 = NaN   (for the x<0 result)

  ; ---- apply edges (each blendv overrides the prior where its mask is set) ----
  d59:  c4 e3 7d 4a c4 60     vblendvps ymm0,ymm0,ymm4,ymm6 ; x==0   -> +inf  (ymm4=+inf, mask ymm6)
  d5f:  c4 e3 7d 4a c3 50     vblendvps ymm0,ymm0,ymm3,ymm5 ; x==inf -> 0     (ymm3=0,    mask ymm5)
  d65:  c4 e3 7d 4a c1 20     vblendvps ymm0,ymm0,ymm1,ymm2 ; x<0    -> NaN   (ymm1=NaN,  mask ymm2)

  d6b:  c5 fc 11 01           vmovups [rcx],ymm0       ; store the 8 results to the result ptr
  d6f:  c5 f8 77              vzeroupper               ; clear upper YMM (avoid AVX<->SSE stall)
  d72:  c5 f8 10 34 24        vmovups xmm6,[rsp]       ; restore callee-saved xmm6
  d77:  48 83 c4 18           add    rsp,0x18          ; pop the stack frame
  d7b:  c3                    ret

; ----------------------------------------------------------------------------
;  THINGS TO NOTICE
;  - vrsqrtps is the whole "approximation" - one instruction, ~12 bits. Newton
;    doubles the bits each pass, so two passes (12 -> 24) reach single precision.
;  - vfnmadd132ps does "1.5 - product" in ONE rounding. Each NR step is just
;    mul, fnmadd, mul. That is why this is so much faster than a real sqrt+div.
;  - The compiler hoisted the mask computations (vcmpeqps/vcmpltps) up between
;    the NR steps: they don't depend on the refined value, so the out-of-order
;    engine runs them on the integer/compare ports while the FMAs run on the
;    FMA ports. Reordering for parallelism, for free.
;  - vxorps of a register with itself is the idiomatic "make a zero". Because it
;    is a VEX-encoded 128-bit op writing xmm3, it zeroes the entire ymm3.
;  - The Windows xmm6 save/reload (sub rsp / vmovups / ... / add rsp) is pure ABI
;    glue; it would vanish on Linux. The actual math is only ~15 instructions.
; ============================================================================
