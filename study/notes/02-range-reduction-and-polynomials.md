# 2 — Range reduction and polynomials

Every elementary function here is built from the same three acts. Understand
this once and you understand `exp`, `log`, `exp2`, `sin`, `cos`, … all at once.

```
   1. REDUCE        map the huge input domain into a tiny interval
   2. APPROXIMATE   evaluate a short polynomial that is accurate on that interval
   3. RECONSTRUCT   undo the reduction to get the full-range answer
```

A polynomial can only be accurate over a small interval with few terms. The art
is choosing a reduction that (a) lands in that interval and (b) can be undone
cheaply and exactly.

## Why polynomials at all? Minimax, not Taylor

The naïve idea is a Taylor series (`e^x = 1 + x + x²/2 + …`). Taylor is accurate
*near one point* and gets worse toward the edges of the interval. We instead use
**minimax** polynomials: coefficients chosen (by the Remez algorithm) to
minimize the *worst-case* error across the whole interval. For the same number
of terms, minimax is dramatically more accurate at the edges. The magic-looking
constants like `1.9875691500E-4` are Cephes's minimax coefficients — not Taylor
coefficients.

## Horner's method (and why it's all FMAs)

A degree-5 polynomial `p0·x⁵ + p1·x⁴ + … + p5` is evaluated as nested
multiply-adds:

```
y = p0
y = y*x + p1
y = y*x + p2
...
y = y*x + p5
```

Each line is exactly one **FMA**. Horner is the minimum number of multiplies, and
maps perfectly onto the FMA unit. That's why the disassembly of every kernel has
a run of `vfmadd...ps` instructions — that run *is* the polynomial.

## Act 1 in detail: the three reduction styles

### exp-style (exp, exp2, exp10, expm1)
```
e^x = 2^n · e^r ,   n = round(x / ln2) ,   r = x − n·ln2 ,   |r| ≤ ln2/2 ≈ 0.347
```
`n` is an integer (cheap, exact `2^n` later); `r` is tiny (short polynomial).
`exp2` and `exp10` are the same engine with a different base for `n`.

### log-style (log, log2, log10, log1p)
```
x = m · 2^e  (read straight from the float's bits) ,   ln x = e·ln2 + ln(m)
```
`e` is the exponent field (an exact integer); `m` is the mantissa in [1,2),
folded to [√½,√2) so `ln(m)` has a tiny argument `s = m−1`. See note 3 for the
bit extraction.

### trig-style (sin, cos, sincos)
```
reduce x into [−π/4, π/4] by subtracting j·(π/4); the octant j (mod 8) selects
which polynomial (sin-shaped or cos-shaped) and which sign to use.
```

## The hi/lo constant split — the subtle, important trick

In `r = x − n·ln2`, when `x` is large, `n` is large, and `n·ln2` is a big number
very close to `x`. Subtracting two close numbers **cancels** the leading digits
and leaves only the noisy low bits — *catastrophic cancellation*.

The fix: store `ln2` as **two** floats, a high part with a short exact binary
expansion plus a tiny correction:

```
ln2 ≈ C1 + C2 ,  C1 = 0.693359375 (= 355/512, EXACT in binary) ,  C2 = −2.12e−4
```

Then reduce in two FMA steps:

```
r = fnmadd(n, C1, x)    // x − n·C1   (n·C1 is exact: C1 has few bits, n is integer)
r = fnmadd(n, C2, r)    // − n·C2     (adds back the low-order correction)
```

Because `C1` is exactly representable and `n` is a small integer, `n·C1` has no
rounding error, so the big cancellation happens cleanly; `C2` then restores the
bits `C1` was missing. The result `r` is good to nearly full precision. The same
idea appears as `ln2_hi/ln2_lo` (exp/log, single and double), `log10(2)` split
(exp10), and `π/4` split into `DP1/DP2/DP3` (sincos).

This one trick is the difference between ~1 ULP and tens of ULP.

## Act 3: reconstruction

- exp-style: multiply by `2^n`, built directly in the exponent field (note 3).
- log-style: add `e·ln2` (again via the hi/lo split). Since `e` is an exact
  integer, `log2` can add `e` with **zero** error — which is why `log2` is even a
  hair more accurate than `log`.
- trig-style: XOR the sign bit dictated by the octant, and pick sin- vs
  cos-polynomial with a `blendv`.

## Worked example: exp(10.0)

```
n = round(10 / ln2) = round(14.4269…) = 14
r = 10 − 14·ln2 = 10 − 9.70406… = 0.29593…        (|r| ≤ 0.347 ✓)
e^r via the degree-6 polynomial ≈ 1.34434…
2^n = 2^14 = 16384
e^10 ≈ 1.34434 × 16384 ≈ 22026.4…                  (libm: 22026.4658)
```

Follow these exact steps in the disassembly: [`../WALKTHROUGH.md`](../WALKTHROUGH.md).

---
Next: [03 — IEEE-754 bit tricks](03-ieee754-bit-tricks.md).
