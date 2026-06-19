# 6 — Instruction & intrinsic glossary

Every AVX2/FMA instruction and C intrinsic used in this library, grouped by job.
The naming pattern is worth internalizing:

- prefix **`v`** = VEX-encoded (AVX) form.
- suffix **`ps`** = *packed single* (8 floats), **`pd`** = *packed double*
  (4 doubles), **`d`/`q`** on integer ops = 32-bit dword / 64-bit qword lanes.
- intrinsic **`_mm256_`** = 256-bit; **`_ps`/`_pd`/`_epi32`/`_epi64`** mirror the
  asm suffix.

## Load / store / move

| asm | intrinsic | what it does |
|---|---|---|
| `vmovups` | `_mm256_loadu_ps` / `_storeu_ps` | load/store 8 floats, unaligned |
| `vbroadcastss` | `_mm256_set1_ps` | copy one float into all 8 lanes |
| `vpbroadcastd` | `_mm256_set1_epi32` | copy one int32 into all 8 lanes |
| `vmovaps` | (register copy) | move a vector register to another |
| `vmovd` | — | move a 32-bit GPR ↔ vector lane 0 |

## Floating-point arithmetic

| asm | intrinsic | what it does |
|---|---|---|
| `vaddps` / `vsubps` | `_mm256_add_ps` / `_sub_ps` | lanewise + / − |
| `vmulps` | `_mm256_mul_ps` | lanewise × |
| `vdivps` | `_mm256_div_ps` | lanewise ÷ (long latency; used sparingly) |
| `vsqrtps` | `_mm256_sqrt_ps` | lanewise √, correctly rounded |
| `vrsqrtps` | `_mm256_rsqrt_ps` | ~12-bit approximation of 1/√x (the seed) |
| `vminps` / `vmaxps` | `_mm256_min_ps` / `_max_ps` | lanewise min/max (NaN → returns the *other* operand) |
| `vroundps` | `_mm256_round_ps` | round to integer; imm `0x8` = nearest + suppress-exceptions |

## FMA (fused multiply-add) — the core of every polynomial

| asm | intrinsic | computes |
|---|---|---|
| `vfmadd…ps` | `_mm256_fmadd_ps(a,b,c)` | `a*b + c` |
| `vfnmadd…ps` | `_mm256_fnmadd_ps(a,b,c)` | `c − a*b` |

The `132` / `213` / `231` in the mnemonic only chooses which operand is the
addend vs. the multiplicands (the compiler picks the form that avoids a move);
the math is the same. One rounding, full-width product. See note 5 for why that
matters.

## Integer arithmetic (AVX2's 256-bit widening) — the bit tricks

| asm | intrinsic | what it does |
|---|---|---|
| `vpaddd` / `vpsubd` | `_mm256_add_epi32` / `_sub_epi32` | lanewise int32 + / − |
| `vpaddq` / `vpsubq` | `_mm256_add_epi64` / `_sub_epi64` | lanewise int64 + / − |
| `vpslld` / `vpsrld` | `_mm256_slli_epi32` / `_srli_epi32` | int32 shift left / right logical |
| `vpsllq` / `vpsrlq` | `_mm256_slli_epi64` / `_srli_epi64` | int64 shift left / right logical |
| `vpmuludq` | `_mm256_mul_epu32` | multiply the *even* 32-bit lanes → 64-bit products (the `/3` in cbrt) |
| `vpcmpeqd` | `_mm256_cmpeq_epi32` | int32 equality → mask (also the "all-ones" idiom vs itself) |

These are exactly the instructions plain AVX could not do at 256 bits — the
reason the library requires AVX2.

## Bitwise / sign

| asm | intrinsic | what it does |
|---|---|---|
| `vandps` | `_mm256_and_ps` | bitwise AND (e.g. extract the sign bit) |
| `vandnps` | `_mm256_andnot_ps` | (~a) AND b (e.g. `|x|` = clear the sign) |
| `vorps` | `_mm256_or_ps` | bitwise OR (e.g. OR a sign bit back in) |
| `vxorps` | `_mm256_xor_ps` | bitwise XOR (sign flip; xor-self = make zero) |
| `vpor` / `vpand` | `_mm256_or_si256` / `_and_si256` | integer-domain OR / AND |

## Compare & select (branchless control flow)

| asm | intrinsic | what it does |
|---|---|---|
| `vcmpps` (`vcmpeqps`, `vcmpltps`, `vcmpunordps`, …) | `_mm256_cmp_ps(a,b,IMM)` | lanewise compare → all-ones/all-zero mask. `IMM` picks the predicate: `_CMP_EQ_OQ`, `_CMP_LT_OS`, `_CMP_UNORD_Q` (isnan), … |
| `vblendvps` | `_mm256_blendv_ps(a,b,mask)` | per lane: `mask ? b : a` |

## Conversions

| asm | intrinsic | what it does |
|---|---|---|
| `vcvttps2dq` | `_mm256_cvttps_epi32` | 8 floats → 8 int32, truncating |
| `vcvtdq2ps` | `_mm256_cvtepi32_ps` | 8 int32 → 8 floats |
| `vcvttpd2dq` | `_mm256_cvtpd_epi32` | 4 doubles → 4 int32 (into an xmm) |
| `vcvtdq2pd` | `_mm256_cvtepi32_pd` | 4 int32 → 4 doubles |
| `vpmovsxdq` | `_mm256_cvtepi32_epi64` | sign-extend 4 int32 → 4 int64 |
| `vcastsi256_ps` etc. | `_mm256_castsi256_ps` / `_castps_si256` | reinterpret bits, **no** instruction (free) |

> Note the gap AVX2 leaves: there is **no** `int64 ↔ double` conversion (that
> arrived with AVX-512). The `double` kernels work around it via the
> `int32 → int64` widen above and a pack-back — see `include/avx2_math_f64.h`.

## Housekeeping

| asm | what it does |
|---|---|
| `vzeroupper` | zero the upper 128 bits of all YMM regs (avoid the AVX↔SSE stall); emitted before every `ret` |
| `sub/add rsp`, `vmovups [rsp],xmm6` | Windows-ABI stack frame + callee-saved-register spill (not present on Linux) |

---
Next: [07 — reading machine code and IR](07-reading-machine-code-and-ir.md).
