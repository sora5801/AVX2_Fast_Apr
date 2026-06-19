# 5 — Accuracy and ULP

How do we know these kernels are *correct*? We measure their error against a
trusted reference and bound it in **ULP**. This note explains the metric, how
the test harness uses it, and where it lies to you.

## What is a ULP?

**ULP** = *Unit in the Last Place*: the gap between two adjacent representable
floating-point numbers near a given value. Near 1.0 a float's ULP is about
`1.2e−7`; near 1000.0 it's about `6e−5`; the ULP scales with the magnitude
because floats are *relative*-precision.

"This function is ≤ 1 ULP" means: for every input, the returned float is at most
one representable step away from the exact answer. 0 ULP = correctly rounded (the
best possible float). 1 ULP is excellent for a fast approximation; libm is
typically ≤ 0.5–1 ULP.

## How we compute it (the bit-distance trick)

Adjacent floats have adjacent *integer* bit patterns. So the ULP distance between
two floats is just the absolute difference of their bit patterns reinterpreted as
integers — after a twist to make negatives order correctly:

```c
int32_t ia = bits(a), ib = bits(b);
if (ia < 0) ia = 0x80000000 - ia;   // map the sign-magnitude layout to a
if (ib < 0) ib = 0x80000000 - ib;   //   monotonic ordering
ulp = |ia − ib|;
```

This is exactly what `ulp_diff_f` / `ulp_diff_d` in
[`../../test/test_accuracy.c`](../../test/test_accuracy.c) do.

## The reference

The single-precision kernels are checked against the **double-precision** libm
result rounded to float — i.e. the correctly-rounded float answer. The
double-precision kernels are checked against scalar libm `exp`/`log`. The test
sweeps ~2 million points per function across the whole valid range, tracks the
worst ULP seen, and fails if it exceeds the per-function budget. It also checks a
battery of special values (`0`, `±inf`, `NaN`, domain edges).

## Why FMA buys accuracy (concretely)

Evaluate `a*x + b` two ways:

- **mul then add**: `t = round(a*x); r = round(t + b)` — *two* roundings; the
  product's low bits are gone before the add.
- **fma**: `r = round(a*x + b)` — *one* rounding; the full-width product reaches
  the add.

In a Horner chain of N steps, that's N rounding errors versus 2N. Across a
degree-8 `log` polynomial it's the difference between ~2 ULP and visibly worse.
The hi/lo constant split (note 2) is the same principle applied to range
reduction. FMA is *why* these kernels hit 1 ULP with such short polynomials.

## When ULP is the wrong metric

ULP is a *relative* measure, so it explodes where the true answer passes through
**zero** while the absolute error stays tiny:

- `sin(x)` near `x = π`: the true value is ~`1e−7`, our value is off by ~`6e−8`
  *absolute* — totally fine — but that's ~6 ULP *of the tiny value*.
- `gelu` near its zero crossing: same story.

For these **bounded** functions the honest metric is **absolute error**, so the
test checks `sin`, `cos`, and `gelu` with an abs-error budget instead of ULP (see
`check_abs` / `check_gelu`). Reporting ULP there would be alarming and
meaningless. Picking the right error metric is part of doing this correctly.

## Signed zero, infinities, NaN — the discipline

Correctness isn't only the average case. The kernels go out of their way to:

- preserve **−0.0**: `expm1(−0) = −0`, `cbrt(−0) = −0`, `sin(−0) = −0`. A sign
  bit carried (or not) through the math; fixed with an explicit blend where the
  arithmetic would drop it.
- get `±inf` and `NaN` right per IEEE/C: `log(0) = −inf`, `log(−1) = NaN`,
  `expm1(−inf) = −1`, `pow(x,0) = 1` even for `x = NaN`. The min/max *clamps*
  used for overflow do **not** propagate NaN (SSE min/max return the non-NaN
  operand), so kernels that care capture an `isnan` mask *before* clamping and
  blend the NaN back at the end (`exp_pd`, `expm1`).

Every one of these is a line item in the test's "special values" section.

## Reading the budgets

In [`../../test/test_accuracy.c`](../../test/test_accuracy.c) each call ends with
a number — the ULP (or abs-error) budget. They're set just above the measured
worst case, tight enough to catch a regression but not so tight they flake at a
range edge. If you change a coefficient or an iteration count and the budget
trips, you broke something.

---
Next: [06 — instruction & intrinsic glossary](06-instruction-and-intrinsic-glossary.md).
