# 4 — Iterative refinement: Newton-Raphson and Halley

`rsqrt` and `cbrt` don't use polynomials. They start from a cheap *rough* guess
and **sharpen** it with a couple of iterations that each multiply the number of
correct digits. This is the other big technique in the library.

## The idea

To solve `f(y) = 0`, take a guess `y` and step to a better one. Each method has a
**convergence order**: how the error shrinks per step.

- **Newton-Raphson** (order 2, *quadratic*): roughly **doubles** the correct
  bits each step.
- **Halley** (order 3, *cubic*): roughly **triples** the correct bits each step.

If you start with ~12 good bits, Newton gives ~24 after one step; two steps is
plenty for single precision (24 bits). Halley from a ~4-bit seed reaches full
precision in two steps too.

## rsqrt: Newton-Raphson for 1/√x

We want `y = 1/√x`, i.e. the root of `f(y) = 1/y² − x`. Plugging into Newton's
formula and simplifying gives the classic iteration:

```
y_{n+1} = y_n · (1.5 − 0.5·x·y_n²)
```

The seed is **hardware**: `vrsqrtps` returns ~12 correct bits in a single
instruction. Then two Newton steps:

```c
__m256 y = _mm256_rsqrt_ps(x);                 // ~12 bits
__m256 xhalf = _mm256_mul_ps(x, half);
__m256 t = _mm256_fnmadd_ps(_mm256_mul_ps(xhalf, y), y, three_halves); // 1.5 − xhalf·y²
y = _mm256_mul_ps(y, t);                       // ~24 bits
t = _mm256_fnmadd_ps(_mm256_mul_ps(xhalf, y), y, three_halves);
y = _mm256_mul_ps(y, t);                       // full single precision
```

Notice the `1.5 − xhalf·y²` is one `fnmadd` — the iteration is *built* for FMA.
Measured result: ≤ 2 ULP. The annotated disassembly shows the seed and the two
steps explicitly: [`../annotated/rsqrt_ps.annotated.s`](../annotated/rsqrt_ps.annotated.s).

Why bother instead of `1.0 / sqrt(x)`? `vsqrtps` + `vdivps` are both long-latency
(~14–20 cycles each, not fully pipelined). Seed + two FMAs is shorter and fully
pipelined, so for bulk work `rsqrt` wins — and you often want `1/√x` directly
(normalizing vectors, Gaussians) without ever forming `√x`.

## cbrt: Halley for the cube root

We want `y = a^{1/3}`, the root of `f(y) = y³ − a`. Halley's formula simplifies
to:

```
y_{n+1} = y_n · (y_n³ + 2a) / (2·y_n³ + a)
```

The seed here is the **bit trick** from note 3 (divide the bit pattern by 3, add
a magic bias) — about a few percent error, ~4–5 good bits. Two Halley steps
(cubic) take that to ≤ 3 ULP. Each step is two FMAs (numerator and denominator),
one divide, and a multiply:

```c
__m256 y3  = y*y*y;
__m256 num = fmadd(two, a,  y3);   // y³ + 2a
__m256 den = fmadd(two, y3, a);    // 2y³ + a
y = y * (num / den);
```

See the two iterations back-to-back in
[`../annotated/cbrt_ps.annotated.s`](../annotated/cbrt_ps.annotated.s).

## Newton vs Halley — when to use which

- Newton needs only `f` and `f'`; each step is cheaper (no divide for rsqrt,
  since the iteration is multiply-only). Great when a hardware seed already gives
  you 12 bits — one or two steps finish the job.
- Halley needs `f''` too and usually a divide per step, but its cubic order pays
  off when the seed is *poor* (only a few bits, like the cbrt bit-trick): you
  reach full precision in fewer steps.

Rule of thumb: **good seed → Newton; rough seed → Halley.**

## Why FMA matters to convergence

These iterations are self-correcting — a rounding error in step 1 is mostly
fixed by step 2 — so they don't *need* FMA to converge. But FMA keeps each step's
arithmetic to one rounding, which means you reach the ULP floor in **two** steps
instead of needing a third. Fewer steps = faster, and the code stays a clean
chain of `vmulps`/`vfmadd...ps`.

## A caution

The seed must already be in the right ballpark (correct binade). That's why both
kernels handle `0`, `±inf`, and negatives with explicit masks *after* the
iterations — feeding those through the iteration would produce `0/0` or `inf/inf`
= NaN. Compute the math path for everything, then blend the specials back in
(note 1's branchless pattern, note 5's edge-case discipline).

---
Next: [05 — accuracy and ULP](05-accuracy-and-ulp.md).
