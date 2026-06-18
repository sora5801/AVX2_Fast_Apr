# avx2_math — fast AVX2 + FMA `exp` / `log`

Header-only, single-precision **`exp(x)`** and **`log(x)`** for x86-64, processing
**8 floats per call** with AVX2 and evaluating every polynomial by
**FMA-based Horner**.

The polynomial coefficients and range-reduction constants are the classic
Cephes minimax fits (as popularized by `sse_mathfun` / `avx_mathfun`), but each
Horner step and each range-reduction step is rewritten with fused
multiply-add (`_mm256_fmadd_ps` / `_mm256_fnmadd_ps`). FMA both shortens the
dependency chain and removes the intermediate rounding between the multiply and
the add, which is what buys the extra accuracy.

```c
#include "avx2_math.h"

__m256 x = _mm256_setr_ps(-2,-1,-0.5,0, 0.5,1,2,3);
__m256 y = avx2_exp_ps(x);   // 8 lanes of e^x
__m256 z = avx2_log_ps(y);   // recovers x

// arbitrary-length arrays (handles a non-multiple-of-8 tail safely):
avx2_exp_f32(in, out, n);
avx2_log_f32(in, out, n);
```

## Accuracy

Reference: the correctly-rounded float result, obtained from double-precision
libm. Both kernels stay within **1 ULP** across their full ranges
(`test/test_accuracy.c`):

| fn  | range tested            | max ULP | max rel. error |
|-----|-------------------------|--------:|---------------:|
| exp | `[-87, 88]`             |   **1** |     1.19e-07   |
| log | `[1e-30, 1e30]`         |   **1** |     1.19e-07   |

`exp` clamps its input to `[-88.376, 88.376]` (the float-`exp` range); `log`
returns `NaN` for `x < 0` and `-inf`/`NaN` at `0`, matching libm conventions.

## Performance

Single-threaded, 4M elements × 20 repeats, Intel Core i9-9900K, gcc 15.2
`-O3 -march=native`, measured by `bench/bench.c` against scalar libm `expf`/`logf`:

| fn  | scalar libm | avx2_math   | speedup    |
|-----|------------:|------------:|-----------:|
| exp |  315 Melem/s | 1613 Melem/s | **5.1×**  |
| log |  258 Melem/s | 1446 Melem/s | **5.6×**  |

(Numbers vary by CPU and compiler; re-run `make bench` to measure your own.)

## How it works

### `exp`
```
e^x = 2^n · e^r,   n = round(x·log2 e),   r = x − n·ln2,   |r| ≤ ln2/2
```
- `n` via `_mm256_round_ps` (round-to-nearest-even).
- `r` via two `fnmadd`s against a two-part split of `ln2` (`C1 + C2`), so the
  large `n·ln2` term is cancelled with effectively full precision.
- `e^r ≈ 1 + r + r²·P(r)` with a degree-6 `P` evaluated by FMA Horner.
- `2^n` is written straight into the IEEE-754 exponent field with AVX2 integer
  shifts (`(n + 127) << 23`) — no AVX1 128-bit lane splitting.

### `log`
```
x = m · 2^e,   ln(x) = e·ln2 + ln(m)
```
- `e` and `m` are extracted from the exponent/mantissa bitfields; `m` is folded
  into `[√½, √2)` so `(m−1)` stays small.
- `ln(m)` is a degree-8 minimax polynomial in `(m−1)`, FMA Horner.
- `e·ln2` is reconstructed from the same two-part `ln2` split for accuracy.

## Building

Requires a CPU with **AVX2 + FMA** (Intel Haswell / AMD Excavator or newer) and
gcc or clang.

**POSIX / MSYS2:**
```sh
make test     # build + run the accuracy test
make bench    # build + run the throughput benchmark
make demo     # build + run the usage demo
```

**Windows (no make needed):**
```powershell
.\build.ps1 test
.\build.ps1 bench
.\build.ps1 demo -CC clang
```

**Just the header:** drop `include/avx2_math.h` into your project and compile
with `-mavx2 -mfma` (or `-march=native`). The per-vector kernels
`avx2_exp_ps` / `avx2_log_ps` are `static inline`; the array helpers
`avx2_exp_f32` / `avx2_log_f32` live in `src/avx2_math.c`.

## Layout

```
include/avx2_math.h    core kernels (header-only, static inline)
src/avx2_math.c        bulk array wrappers
test/test_accuracy.c   ULP validation vs double-precision libm
bench/bench.c          throughput benchmark vs scalar libm
examples/demo.c        minimal usage example
```

## License

MIT — see [LICENSE](LICENSE).
