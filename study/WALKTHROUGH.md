# Annotated walkthrough: `avx2_exp_ps` from C to machine code

This traces the single-precision `exp` kernel all the way down: the C/intrinsic
source, the assembly the compiler picked, and the machine-code bytes it
assembled to. It's the best single example for understanding how the whole
library maps onto the hardware — every other kernel uses the same building
blocks (broadcast a constant, FMA-Horner, poke the exponent field).

> Listing below is `gcc -O3 -mavx2 -mfma` on **Windows x64 (COFF)**. The
> Microsoft x64 ABI returns a `__m256` through a hidden pointer (`rcx` = address
> of the result, `rdx` = address of the argument). On Linux/SysV the value would
> arrive and leave in `ymm0` directly and you'd see no `mov rax,rcx` or final
> store. Regenerate for your platform with `make asm` / `study/gen.ps1`.

## The source (condensed)

```c
x  = min(x, 88.376); x = max(x, -88.376);   // clamp
fx = round(x * LOG2EF);                      // n = round(x / ln2)
r  = fnmadd(fx, C1, x);                       // r = x - n*ln2_hi
r  = fnmadd(fx, C2, r);                       //   - n*ln2_lo
r2 = r * r;
y  = P0;                                      // Horner: e^r ~= 1 + r + r^2*P(r)
y  = fmadd(y, r, P1); ... y = fmadd(y, r, P5);
y  = fmadd(y, r2, r);                         // r^2*P(r) + r
y  = y + 1;
n  = (int)fx; n = (n + 127) << 23;            // build 2^n in the exponent field
return y * as_float(n);                       // e^x = e^r * 2^n
```

## The machine code, annotated

Format of each line:  `offset:  <bytes>   mnemonic   operands   ; commentary`

```
avx2k_exp_ps:
 0: c4 e2 7d 18 0d ..   vbroadcastss ymm1,[rip+..]  ; ymm1 = hi = 88.376  (clamp ceiling)
 9: c4 e2 7d 18 15 ..   vbroadcastss ymm2,[rip+..]  ; ymm2 = C1 = ln2_hi  (0.693359375)
12: c4 e2 7d 18 1d ..   vbroadcastss ymm3,[rip+..]  ; ymm3 = P1           (first Horner addend)
                                                    ;   (one scalar const -> all 8 lanes)
1b: c5 fc 10 02         vmovups ymm0,[rdx]          ; ymm0 = x  (load the 8 input floats)
1f: c5 fc 5d c1         vminps  ymm0,ymm0,ymm1      ; x = min(x, hi)
23: c4 e2 7d 18 0d ..   vbroadcastss ymm1,[rip+..]  ; ymm1 = lo = -88.376 (clamp floor)
2c: 48 89 c8            mov     rax,rcx             ; ABI: return value = hidden result ptr
2f: c5 fc 5f c1         vmaxps  ymm0,ymm0,ymm1      ; x = max(x, lo)        -> x clamped
33: c4 e2 7d 18 0d ..   vbroadcastss ymm1,[rip+..]  ; ymm1 = LOG2EF = 1/ln2
3c: c5 fc 59 c9         vmulps  ymm1,ymm0,ymm1      ; ymm1 = x * LOG2EF
40: c4 e3 7d 08 c9 08   vroundps ymm1,ymm1,0x8      ; fx = round-to-nearest(...)   (0x8 =
                                                    ;   nearest + suppress exceptions)
46: c4 e2 75 bc c2      vfnmadd231ps ymm0,ymm1,ymm2 ; r = x - fx*C1   (231: ymm0 = -(ymm1*ymm2)+ymm0)
4b: c4 e2 7d 18 15 ..   vbroadcastss ymm2,[rip+..]  ; ymm2 = C2 = ln2_lo (-2.12e-4)
54: c4 e2 7d 9c d1      vfnmadd132ps ymm2,ymm0,ymm1 ; r = r - fx*C2   (132: ymm2 = -(ymm2*ymm1)+ymm0)
                                                    ;   now the reduced argument r lives in ymm2
59: c5 fe 5b c9         vcvttps2dq ymm1,ymm1        ; n = (int32)fx     (truncate; fx is integral)
5d: c4 e2 7d 18 05 ..   vbroadcastss ymm0,[rip+..]  ; ymm0 = P0  (Horner accumulator start)
66: c4 e2 65 98 c2      vfmadd132ps ymm0,ymm3,ymm2  ; y = P0*r + P1   (ymm2=r, ymm3=P1)
74: c4 e2 65 98 c2      vfmadd132ps ymm0,ymm3,ymm2  ; y = y*r + P2
82: c4 e2 65 98 c2      vfmadd132ps ymm0,ymm3,ymm2  ; y = y*r + P3
90: c4 e2 65 98 c2      vfmadd132ps ymm0,ymm3,ymm2  ; y = y*r + P4
9e: c4 e2 65 98 c2      vfmadd132ps ymm0,ymm3,ymm2  ; y = y*r + P5
     (each FMA is preceded by a vbroadcastss reloading ymm3 with the next P coeff)
a3: c5 ec 59 da         vmulps  ymm3,ymm2,ymm2      ; r2 = r * r
a7: c4 e2 6d 98 c3      vfmadd132ps ymm0,ymm2,ymm3  ; y = y*r2 + r     (ymm3=r2, ymm2=r)
--- now build 2^n, interleaved with the y+1 below (independent data paths) ---
ac: c5 ed 76 d2         vpcmpeqd ymm2,ymm2,ymm2     ; ymm2 = 0xFFFFFFFF (all ones) per lane
b0: c5 ed 72 d2 19      vpsrld  ymm2,ymm2,0x19      ; >> 25  => 0x7F = 127  (the exponent BIAS,
                                                    ;   materialized with NO memory load!)
b5: c5 f5 fe ca         vpaddd  ymm1,ymm1,ymm2      ; n + 127
b9: c4 e2 7d 18 15 ..   vbroadcastss ymm2,[rip+..]  ; ymm2 = 1.0
c2: c5 f5 72 f1 17      vpslld  ymm1,ymm1,0x17      ; (n+127) << 23  => the bits of 2^n
c7: c5 fc 58 c2         vaddps  ymm0,ymm0,ymm2      ; y = y + 1.0      (finish e^r)
cb: c5 fc 59 c1         vmulps  ymm0,ymm0,ymm1      ; e^x = e^r * 2^n
cf: c5 fc 11 01         vmovups [rcx],ymm0          ; store 8 results to the hidden ret ptr
d3: c5 f8 77            vzeroupper                  ; clear upper YMM (avoid AVX<->SSE penalty)
d6: c3                  ret
```

## Things worth noticing

- **One scalar constant fans out to 8 lanes.** `vbroadcastss ymm,[rip+k]` reads
  one 32-bit float from the constant pool and copies it to all eight lanes. The
  `_mm256_set1_ps(...)` in the source is exactly this instruction.

- **The three FMA operand forms.** The encoding's middle digit picks which
  operand is the addend:
  - `...231` : `dst = src2*src3 + dst`   (used for `r = x - fx*C1`)
  - `...132` : `dst = dst*src3 + src2`   (used for the Horner steps)
  - `...213` : `dst = src2*dst + src3`
  The `n` prefix (`vfnmadd`) negates the product, which is how `x - fx*C`
  becomes a single instruction. Each FMA is one rounding, not two — that is the
  accuracy win the library is built on, visible right here.

- **`vroundps ymm,ymm,0x8`** is `_mm256_round_ps(.., NEAREST | NO_EXC)`. The
  immediate `0x8` = `0b1000`: bit 3 suppresses the inexact exception, bits 0-1
  = 00 select round-to-nearest-even.

- **The bias 127 is computed, not loaded** (offsets `ac`-`b0`):
  `vpcmpeqd` of a register with itself yields all-ones (`0xFFFFFFFF`); shifting
  right logical by 25 leaves `0x7F` = 127. The compiler decided two cheap ALU
  ops beat a constant-pool load + its cache traffic. This is the
  `_mm256_set1_epi32(0x7f)` from the source.

- **The exponent trick is pure integer ops on the YMM register**:
  `vpaddd` then `vpslld ymm,ymm,0x17` is `(n + 127) << 23` — placing the biased
  exponent into bits 23..30 of each lane so the bit pattern *is* the float
  `2^n`. These 256-bit integer instructions are exactly what AVX2 added over
  AVX1 (which would have to split into two 128-bit halves here).

- **Instruction-level parallelism by interleaving.** The integer `2^n`
  construction (`ac`-`c2`) and the float `y + 1` (`c7`) touch independent
  registers, so the out-of-order core runs them down two separate pipes; the
  compiler ordered them to expose that.

- **`vzeroupper` before `ret`** zeroes the upper 128 bits of every YMM. Without
  it, later SSE (128-bit) code pays a one-time state-transition stall. Standard
  hygiene at the end of any AVX function.

## See also

- `avx2_math.intel.s` / `avx2_math.att.s` — full assembly for every kernel.
- `avx2_math.disasm.txt` — the same with machine-code bytes (what's excerpted
  above).
- `avx2_math.text.hex` — raw `.text` section bytes.
- The source with the matching comments: [`../include/avx2_math_f32.h`](../include/avx2_math_f32.h).
