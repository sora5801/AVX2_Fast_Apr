# 1 — SIMD, AVX2, and the execution model

## SIMD in one sentence

**SIMD** = *Single Instruction, Multiple Data*: one instruction operates on a
whole vector of values at once. Instead of `add` on two numbers, `vaddps` adds
two vectors of eight floats — eight additions for the price of one instruction.

The values packed into a vector are called **lanes**. This library uses:

- `__m256` — a 256-bit register holding **8 lanes of `float`** (8 × 32 bit).
- `__m256d` — 256 bits holding **4 lanes of `double`** (4 × 64 bit).
- `__m256i` — 256 bits of **integer** lanes (8 × 32-bit, or 4 × 64-bit,
  depending on the instruction).

The lanes are independent: lane 3's `exp` doesn't see lane 4's. That's why every
kernel here is "branchless" — instead of `if`, we compute *all* paths and select
per lane with a mask (more on that below).

## The register file

x86-64 with AVX gives you 16 vector registers, `ymm0`–`ymm15`, each 256 bits.
Their lower 128 bits are the older SSE `xmm0`–`xmm15`. A YMM register can be
viewed as 8 floats, 4 doubles, 32 bytes, etc. — the *instruction*, not the
register, decides how the bits are grouped.

```
 ymm0  ┌──────┬──────┬──────┬──────┬──────┬──────┬──────┬──────┐  (as 8x float)
       │ lane7│ lane6│ lane5│ lane4│ lane3│ lane2│ lane1│ lane0│
       └──────┴──────┴──────┴──────┴──────┴──────┴──────┴──────┘
       └────────────── ymm (256 bits) ──────────────┘
                                   └──── xmm (low 128) ────┘
```

## AVX vs AVX2 — why this library needs AVX2 specifically

- **AVX** (2011) gave 256-bit *floating-point* math (`vaddps`, `vmulps`, …) but
  its *integer* instructions only worked on the low 128 bits.
- **AVX2** (2013) widened the **integer** instructions to a full 256 bits:
  `vpaddd`, `vpslld`, `vpsrld`, `vpmuludq`, `vpcmpeqd`, `vpermq`, …

Why that matters here: the fast path of `exp`/`log`/`exp2` builds `2^n` by doing
**integer arithmetic on the exponent field** of all 8 float lanes at once
(`(n+127)<<23`). That's `vpaddd` + `vpslld` on a 256-bit register — an AVX2-only
capability. On plain AVX you'd have to split the vector into two 128-bit halves,
do it twice, and glue back. `cbrt`'s integer `/3` (`vpmuludq`) is AVX2 for the
same reason. See note 3.

## FMA — the workhorse

**FMA** = *Fused Multiply-Add*: `vfmadd...ps` computes `a*b + c` as a **single
operation with a single rounding** — the exact product `a*b` is kept full-width
and only the final sum is rounded. Variants used here:

| intrinsic | computes |
|---|---|
| `_mm256_fmadd_ps(a,b,c)`  | `a*b + c` |
| `_mm256_fnmadd_ps(a,b,c)` | `-(a*b) + c`  = `c - a*b` |

Two reasons FMA is everywhere in this code:

1. **Speed.** A Horner polynomial step `y = y*x + c` is one FMA instead of a
   multiply *and* an add. The whole polynomial becomes a chain of FMAs.
2. **Accuracy.** No intermediate rounding between the multiply and the add. The
   `fnmadd` form makes range reductions like `x - n*ln2` lose almost no bits.

FMA is a separate CPU feature flag from AVX2 (hence `-mavx2 -mfma`), though every
real CPU that has one has the other.

## Masks and branchless selection

There are no per-lane branches. To express `result = cond ? A : B` for each lane:

1. A compare like `vcmpltps` (or `_mm256_cmp_ps`) produces a **mask**: each lane
   becomes all-ones (`0xFFFFFFFF`) where the condition holds, all-zeros where it
   doesn't.
2. `vblendvps` (`_mm256_blendv_ps(B, A, mask)`) picks `A` where the mask's top
   bit is set, `B` elsewhere.

You'll see this for every edge case (`x<0 -> NaN`, `x==0 -> +inf`, octant
selection in `sincos`, …). Compute both answers, then blend. It looks wasteful
but it keeps all 8 lanes flowing with zero misprediction cost.

## `vzeroupper` and the SSE/AVX transition

Every kernel ends with `vzeroupper`. Mixing 256-bit AVX code with legacy
128-bit SSE code causes a one-time microarchitectural stall unless the upper 128
bits of the YMM registers are known to be zero. `vzeroupper` zeroes them, so
returning into SSE code (or another library) is cheap. It's standard hygiene at
the end of an AVX function.

## How a `__m256` reaches the function

This is pure ABI (calling convention) and differs by OS:

- **Linux / System V**: vector arguments and the return value travel in
  `ymm0`, `ymm1`, … So a kernel reads `ymm0` and leaves its answer in `ymm0`.
- **Windows x64**: a 256-bit value is passed/returned *through memory*. You'll
  see `rcx` = pointer to where the result goes, `rdx` = pointer to the argument,
  a `mov rax, rcx`, and a final `vmovups [rcx], ymm0`. Windows also makes
  `xmm6`–`xmm15` **callee-saved**, so kernels that use `ymm6` spill/reload it.

None of that ABI glue is the *math*; it's bookkeeping around it. The committed
disassembly is a Windows build, so you'll see the glue — note 7 points it out.

---
Next: [02 — range reduction and polynomials](02-range-reduction-and-polynomials.md).
