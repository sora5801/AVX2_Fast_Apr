# avx2_math — fast vectorized exp / log / pow / activations for AVX2 + FMA

Header-only C library of fast transcendental functions for x86-64. Single
precision runs **8 lanes** (`__m256`) at a time, double precision **4 lanes**
(`__m256d`), and every polynomial is evaluated by **FMA-based Horner**.

```c
#include "avx2_math.h"

__m256 x = _mm256_setr_ps(-2,-1,-0.5,0, 0.5,1,2,3);
__m256 y = avx2_exp_ps(x);        // e^x, 8 lanes
__m256 s = avx2_sigmoid_ps(x);    // 1/(1+e^-x)
__m256 t = avx2_tanh_ps(x);       // tanh
__m256d d = avx2_log_pd(_mm256_set1_pd(2.0));   // ln, 4 lanes

avx2_log_f32(in, out, n);         // bulk array helper, any length
```

## Functions

| | single precision (`__m256`, 8 lanes) | double precision (`__m256d`, 4 lanes) |
|---|---|---|
| **exp family** | `exp` `exp2` `exp10` `expm1` | `exp` |
| **log family** | `log` `log2` `log10` `log1p` | `log` |
| **power / roots** | `pow` `sqrt` `rsqrt` `cbrt` | |
| **activations**| `tanh` `sigmoid` `softplus` `gelu` | |

Each has a per-vector kernel (`avx2_exp_ps`, `avx2_exp_pd`, …) and a bulk array
helper (`avx2_exp_f32`, `avx2_exp_f64`, …) that handles any length including a
ragged tail.

## Accuracy

Measured against a double-precision libm reference (`test/test_accuracy.c` is
the authoritative check; numbers below are its output):

| function | max ULP | | function | max ULP |
|---|--:|---|---|--:|
| `exp` (f32)   | **1** | | `log` (f32)   | **1** |
| `exp2` (f32)  | **1** | | `log2` (f32)  | **1** |
| `exp10` (f32) | **1** | | `log10` (f32) | **1** |
| `expm1` (f32) | **1** | | `log1p` (f32) | **2** |
| `tanh` (f32)  | **1** | | `sigmoid` (f32)| **2** |
| `exp` (f64)   | **2** | | `log` (f64)   | **2** |
| `rsqrt` (f32) | **2** | | `sqrt` (f32)  | **0** |
| `cbrt` (f32)  | **3** | | `softplus`(f32)| **3** |
| `pow` (f32)   | ~ few ULP for moderate exponents (fast variant — see below) | | | |
| `gelu` (f32)  | abs err ≤ 5e-4 vs exact erf-GELU (it *is* the tanh approximation, see below) | | | |

`expm1` and `log1p` keep full accuracy near 0 (where naïve `exp(x)-1` /
`log(1+x)` lose all significant digits to cancellation). `tanh`/`sigmoid`/
`softplus`/`gelu` are overflow-safe and saturate cleanly. `rsqrt` uses the
hardware seed plus two Newton-Raphson steps; `cbrt` uses an exponent-bit-trick
seed (integer `/3` via multiply-high) plus two Halley iterations. `pow` is the
*fast* composition `2^(y·log2 x)`: a few ULP for moderate `|y·log2 x|`,
degrading for very large products. `gelu` is the **tanh approximation** used by
GPT/BERT — it differs from the exact erf-based GELU by ~5e-4 by construction.
Use libm where you need correct rounding.

## Performance

Single-threaded, 4M elements × 20 reps, Intel Core i9-9900K, gcc 15.2
`-O3 -march=native`, vs scalar libm (`bench/bench.c`):

| function | scalar libm | avx2_math | speedup |
|---|--:|--:|--:|
| `exp` (f32)   |  214 Me/s | 1118 Me/s | **5.2×** |
| `expm1` (f32) |  191 Me/s | 1023 Me/s | **5.4×** |
| `log` (f32)   |  227 Me/s | 1234 Me/s | **5.4×** |
| `tanh` (f32)  |   76 Me/s | 1076 Me/s | **14.2×** |
| `cbrt` (f32)  |  102 Me/s | 1149 Me/s | **11.3×** |
| `exp` (f64)   |  212 Me/s |  556 Me/s | **2.6×** |
| `log` (f64)   |  219 Me/s |  493 Me/s | **2.3×** |

(Speedups vary by CPU and compiler; run `make bench` to measure your own.)

## How it works

All kernels share a three-act structure:

1. **Range reduction** maps the input into a tiny interval. For exp-like
   functions, `f(x) = 2^n · g(r)` with `n = round(...)` and `r` small; for
   log-like functions, `x = m · 2^e` with `m` near 1. The `n·ln2` (or
   `e·ln2`) term uses a **two-part split of `ln2`** (an exactly-representable
   high part plus a tiny correction) so the cancelling subtraction keeps full
   precision.
2. **Polynomial** — a Cephes minimax fit evaluated by **FMA Horner**
   (`_mm256_fmadd_ps`). FMA both halves the op count of each `a·x+b` step and
   keeps the product un-rounded, buying accuracy.
3. **Reconstruction** — the `2^n` factor is poked straight into the IEEE-754
   exponent field with integer shifts (`(n+127)<<23` for float). AVX2's 256-bit
   integer ops do this for the whole vector at once.

Notable details:
- `exp2`/`exp10` reuse the `exp` polynomial by mapping their reduced argument
  through `·ln2` / `·ln10` into the same interval the polynomial was fit on.
- `expm1` forms `e^r − 1 = r + r²·P(r)` directly and recombines with a single
  FMA `2^k·er + (2^k−1)`, so the `−1` never causes cancellation.
- `log1p` applies the Kahan/Goldberg correction `ln(u)·x/(u−1)`, `u = 1+x`.
- The **f64** kernels need an int64↔double round-trip that AVX2 lacks natively;
  they go through `cvtpd_epi32 → cvtepi32_epi64` (and back via packed dwords +
  `cvtepi32_pd`). `exp_pd` splits `2^n` into two half-steps so the 11-bit
  exponent field never overflows across the full range.

- `rsqrt` refines the `vrsqrtps` hardware seed with two Newton-Raphson steps;
  `cbrt` seeds from an exponent bit-trick (integer `/3` done with a
  multiply-high, since AVX2 has no integer divide) and refines with two
  cubically-convergent Halley iterations.

See the heavily-commented headers for the full derivations:
[`avx2_math_f32.h`](include/avx2_math_f32.h),
[`avx2_math_f64.h`](include/avx2_math_f64.h).

## Studying the generated code

The [`study/`](study/) directory contains the kernels lowered to the metal, so
you can line up *C intrinsic → assembly → machine-code bytes*:

- [`study/WALKTHROUGH.md`](study/WALKTHROUGH.md) — a hand-annotated,
  instruction-by-instruction tour of `avx2_exp_ps` (start here).
- `avx2_math.intel.s` / `avx2_math.att.s` — full assembly, both syntaxes.
- `avx2_math.disasm.txt` — disassembly with the machine-code bytes per instruction.
- `avx2_math.text.hex` — raw `.text` hex dump.

Regenerate for your platform/compiler with `make asm` or `study/gen.ps1`.

## Building

Requires a CPU with **AVX2 + FMA** (Intel Haswell / AMD Excavator or newer) and
gcc or clang. The headers `#error` out if not built with `-mavx2 -mfma`.

**POSIX / MSYS2:**
```sh
make test     # build + run the accuracy test (the gate)
make bench    # build + run the throughput benchmark
make demo     # build + run the usage tour
```

**Windows (no make needed):**
```powershell
.\build.ps1 test
.\build.ps1 bench
.\build.ps1 demo -CC clang
```

**Just the headers:** copy `include/` into your project and compile your TU with
`-mavx2 -mfma` (or `-march=native`). The per-vector kernels are `static inline`;
the bulk array helpers live in `src/avx2_math.c`.

A runtime guard `avx2_math_cpu_supported()` (CPUID-backed) is provided so a
program built for AVX2 can detect an unsupported CPU and bail gracefully instead
of faulting with SIGILL.

## Layout

```
include/avx2_math.h        umbrella header (include just this)
include/avx2_math_f32.h    single-precision kernels (exp/log/pow/roots/activations)
include/avx2_math_f64.h    double-precision kernels (exp/log)
src/avx2_math.c            bulk array wrappers
test/test_accuracy.c       ULP validation + special values vs libm
bench/bench.c              throughput benchmark vs scalar libm
examples/demo.c            usage tour
study/                     assembly + machine-code artifacts (see study/README.md)
.github/workflows/ci.yml   build + test on gcc & clang
```

## License

MIT — see [LICENSE](LICENSE).
