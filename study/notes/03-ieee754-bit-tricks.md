# 3 — IEEE-754 bit tricks

The reason these kernels are fast is that they treat a `float` as what it really
is: a packed integer whose fields you can poke directly. This note is the key to
reading `exp`, `log`, `cbrt`, and `rsqrt`.

## The layout of a 32-bit float

```
 bit:  31 30        23 22                     0
       ┌──┬───────────┬────────────────────────┐
       │S │  exponent  │        mantissa         │
       │1 │   8 bits   │        23 bits          │
       └──┴───────────┴────────────────────────┘

 value = (−1)^S × 1.mantissa × 2^(exponent − 127)
```

- **S** — sign bit.
- **exponent** — stored *biased* by 127 (so the field 127 means 2⁰, 128 means
  2¹, 126 means 2⁻¹, …).
- **mantissa** — the fractional bits of a number `1.m` in [1, 2).

A `double` is the same idea with an **11-bit** exponent (bias **1023**) and a
**52-bit** mantissa.

Two consequences this code leans on constantly:

- The **sign** is one isolated bit → flip/extract it with a single AND/XOR.
- Multiplying by a power of two = **adding to the exponent field**. No FP math
  needed.

## Trick A: building 2^n (the exp reconstruction)

To make the float `2^n` you don't compute anything — you place `n` into the
exponent field:

```
bits = (n + 127) << 23      // bias n, shift into bits 23..30, mantissa stays 0
2^n  = reinterpret_as_float(bits)
```

In AVX2 this is `vpaddd` (add 127 to all 8 lanes) then `vpslld …,23` (shift into
the exponent field). You can spot it at the end of `exp_ps` in
[`../WALKTHROUGH.md`](../WALKTHROUGH.md). This is a vectorized `ldexpf`.

For `double` (`exp_pd`) the shift is 52 and the bias 1023 — but AVX2 has no
64-bit-int↔double conversion, so `exp_pd` reaches the int64 lanes through a
detour and even **splits `n` into two halves** (`2^n = 2^n1 · 2^n2`) so the
11-bit field can't overflow mid-range. See `include/avx2_math_f64.h`.

## Trick B: reading m and e back out (the log reduction)

`log` does the inverse — pull the fields apart:

```
e_biased = bits >> 23           // exponent field   (vpsrld …,23)
m_bits   = (bits & 0x007FFFFF)  // keep mantissa
         | 0x3F000000           // force exponent so the value lands in [0.5,1)
e        = e_biased − 126       // unbias
```

This is a vectorized `frexpf`: split `x` into a mantissa `m` near 1 and an
integer exponent `e`. The mantissa goes into the polynomial; `e` becomes the
`e·ln2` term. `log_pd` does the same on 64-bit fields and even rescales
denormals by `2^54` first so the extraction stays in the normalized regime.

## Trick C: dividing the bit pattern by 3 (cbrt's seed)

Cube root needs `cbrt(2^e·m) = 2^(e/3)·cbrt(m)`. Dividing the *whole bit
pattern* by 3 roughly divides the exponent by 3, giving a seed within a few
percent. But AVX2 has **no integer divide**, so `/3` uses the multiply-high
identity:

```
n / 3 = (n × 0xAAAAAAAB) >> 33      // 0xAAAAAAAB ≈ 2^33 / 3
```

`vpmuludq` multiplies 32-bit lanes into 64-bit products, but only the *even*
32-bit lanes of each 64-bit group — so the code multiplies the dwords as-is
(even lanes) and again after a `>>32` (odd lanes), shifts each product right 33,
and reassembles. Then it adds a magic bias constant (`0x2a514067`) that sets the
exponent offset. The annotated listing isolates these six instructions:
[`../annotated/cbrt_ps.annotated.s`](../annotated/cbrt_ps.annotated.s).

## Trick D: materializing a constant without a load

In `exp_ps` the bias `127` is needed as an integer vector. Instead of loading it
from memory, the compiler did:

```
vpcmpeqd ymm,ymm,ymm     // compare a register to itself → all ones (0xFFFFFFFF)
vpsrld   ymm,ymm,25      // logical shift right 25 → 0x0000007F = 127
```

Two cheap ALU ops beat a constant-pool load + the cache line it lives on. A nice
reminder that the compiler reasons about *bit patterns*, not just values.

## Trick E: sign as a bit

Because the sign is bit 31:

- `|x|`  = `x AND 0x7FFFFFFF`  → `vandnps` with the `0x80000000` mask
  (`rsqrt`, `cbrt`, `sin`, `sigmoid`, `tanh`, `softplus`).
- `−x` / sign flip = `x XOR 0x80000000` (`sincos` applies the octant sign this
  way).
- Preserving the sign of zero (so `expm1(−0) = −0`, `cbrt(−0) = −0`) is just
  carrying that one bit through — note 5 explains why it matters.

## Special bit patterns worth recognizing

| pattern (float) | meaning |
|---|---|
| `0x7F800000` | `+inf` |
| `0xFF800000` | `−inf` |
| `0x7FC00000` | a quiet `NaN` |
| `0x00800000` | smallest **normal** (2⁻¹²⁶); `log` clamps to this |
| `0x80000000` | `−0.0`; doubles as the sign-bit mask |

A NaN is "unordered": `x == x` is **false** for a NaN. That's why `isnan(x)` is
implemented as the compare `vcmpunordps x, x` — you'll see it in `cbrt`,
`expm1`, `exp_pd`.

---
Next: [04 — iterative refinement](04-iterative-refinement.md).
