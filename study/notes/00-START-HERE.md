# Learning path — how to study this library

These notes turn `avx2_math` into a self-contained course on how fast SIMD math
actually works, from the floating-point theory down to the machine-code bytes.
Read them in order, or jump to whatever you're curious about.

## The course

| # | file | what you'll learn |
|---|---|---|
| 1 | [01-simd-and-avx2.md](01-simd-and-avx2.md) | SIMD, YMM registers, lanes, FMA, the VEX prefix, `vzeroupper`, how a `__m256` is passed/returned |
| 2 | [02-range-reduction-and-polynomials.md](02-range-reduction-and-polynomials.md) | the universal 3-act structure: reduce → polynomial → reconstruct; minimax vs Taylor; why constants are split into hi/lo parts |
| 3 | [03-ieee754-bit-tricks.md](03-ieee754-bit-tricks.md) | the float bit layout, the `2^n` exponent-poke, `frexp`, the `cbrt` integer `/3`, materializing constants, signed zero |
| 4 | [04-iterative-refinement.md](04-iterative-refinement.md) | Newton-Raphson (`rsqrt`) and Halley (`cbrt`): why they converge, how fast, and FMA's role |
| 5 | [05-accuracy-and-ulp.md](05-accuracy-and-ulp.md) | what a ULP is, how the test measures it, why FMA buys accuracy, when ULP is the wrong metric |
| 6 | [06-instruction-and-intrinsic-glossary.md](06-instruction-and-intrinsic-glossary.md) | every AVX2/FMA instruction and intrinsic used here, what each does |
| 7 | [07-reading-machine-code-and-ir.md](07-reading-machine-code-and-ir.md) | decode a real instruction byte-by-byte; read objdump; what LLVM IR is and how it relates to "byte code" |

## The artifacts these notes refer to

In the parent [`study/`](../) directory:

- [`WALKTHROUGH.md`](../WALKTHROUGH.md) — line-by-line tour of `exp_ps`.
- [`annotated/rsqrt_ps.annotated.s`](../annotated/rsqrt_ps.annotated.s) — Newton-Raphson, annotated.
- [`annotated/cbrt_ps.annotated.s`](../annotated/cbrt_ps.annotated.s) — the bit-trick `/3` + Halley, annotated.
- `avx2_math.intel.s` / `avx2_math.att.s` — full assembly, both syntaxes.
- `avx2_math.disasm.txt` — disassembly with machine-code bytes.
- `avx2_math.text.hex` — raw `.text` hex.
- `avx2_math.ll` — LLVM IR (the typed SSA intermediate).

And the source of truth, the heavily-commented kernels themselves:
[`include/avx2_math_f32.h`](../../include/avx2_math_f32.h),
[`include/avx2_math_f64.h`](../../include/avx2_math_f64.h).

## A suggested first pass (≈30 min)

1. Skim note 1 to get the mental model of lanes + FMA.
2. Read note 2 up to the `exp` example.
3. Open [`WALKTHROUGH.md`](../WALKTHROUGH.md) and follow `exp_ps` from C to bytes.
4. Read note 3, then open [`annotated/cbrt_ps.annotated.s`](../annotated/cbrt_ps.annotated.s)
   and find the six instructions that divide an integer by 3.

That loop — *read the idea, then watch it happen in the disassembly* — is the
whole point.
