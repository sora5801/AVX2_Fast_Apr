/*
 * ============================================================================
 *  avx2_math.h - Fast vectorized transcendental math for AVX2 + FMA.
 * ============================================================================
 *
 *  This is the UMBRELLA header. Include just this file:
 *
 *      #include "avx2_math.h"
 *
 *  and you get the whole library. It pulls in:
 *
 *      avx2_math_f32.h   single-precision (float, __m256, 8 lanes):
 *                          exp  exp2  exp10  expm1
 *                          log  log2  log10  log1p
 *                          pow  tanh  sigmoid
 *      avx2_math_f64.h   double-precision (double, __m256d, 4 lanes):
 *                          exp  log
 *
 *  ----------------------------------------------------------------------------
 *  DESIGN IN ONE PARAGRAPH
 *  ----------------------------------------------------------------------------
 *  Every elementary function here follows the same three-act structure:
 *
 *    1. RANGE REDUCTION. Map the (possibly huge) input into a tiny interval
 *       where a low-degree polynomial is accurate. For exp-like functions this
 *       means writing  f(x) = 2^n * g(r)  with  r  small; for log-like
 *       functions it means splitting  x = m * 2^e  and handling  e  (exact)
 *       and  m  (near 1) separately.
 *
 *    2. POLYNOMIAL APPROXIMATION via FMA-based Horner. The minimax polynomial
 *       coefficients are the classic Cephes fits (the same ones used by
 *       sse_mathfun / avx_mathfun), but every Horner step is a fused
 *       multiply-add (_mm256_fmadd_ps / _mm256_fnmadd_ps). FMA matters twice
 *       over: it halves the op count of each `a*x + b` step, AND it keeps the
 *       full-width product before rounding, so the polynomial is evaluated with
 *       less rounding error than a separate multiply+add.
 *
 *    3. RECONSTRUCTION. Re-apply the power of two. The 2^n factor is built
 *       directly in the IEEE-754 exponent field with integer shifts - no call
 *       to ldexp, no table. AVX2's 256-bit integer ops let us do this without
 *       splitting the vector into 128-bit halves (which plain AVX1 would need).
 *
 *  Why FMA + AVX2 specifically:
 *    - FMA (fused multiply-add) is the workhorse of polynomial evaluation.
 *    - AVX2 adds 256-bit *integer* instructions (_mm256_slli_epi32,
 *      _mm256_add_epi32, _mm256_cvtepi32_epi64, ...). Those are what make the
 *      "poke the bits of the exponent field" trick work on a full 8-wide
 *      (float) or 4-wide (double) vector in one shot.
 *
 *  ----------------------------------------------------------------------------
 *  ACCURACY (measured vs. a double-precision libm reference; see
 *  test/test_accuracy.c, which is the authoritative check)
 *  ----------------------------------------------------------------------------
 *    f32: exp/exp2/exp10  <= 1 ULP      log/log2/log10  <= 2 ULP
 *         expm1           <= 1 ULP      log1p           <= 2 ULP
 *         tanh            <= 1 ULP      sigmoid         <= 2 ULP
 *         pow             few ULP for moderate exponents (see avx2_math_f32.h)
 *    f64: exp             <= 2 ULP      log             <= 2 ULP
 *
 *  ----------------------------------------------------------------------------
 *  CONVENTIONS / CAVEATS shared by the whole library
 *  ----------------------------------------------------------------------------
 *    - The per-vector kernels (avx2_exp_ps, ...) are `static inline`: zero call
 *      overhead, meant to be dropped straight into hot loops.
 *    - The bulk array helpers (avx2_exp_f32, ...) are declared here and defined
 *      in src/avx2_math.c. They handle any length, including a tail that is not
 *      a multiple of the lane count, without reading or writing out of bounds.
 *    - NaN propagation: the f32 exp/log/exp2/... kernels CLAMP their inputs with
 *      _mm256_min_ps/_mm256_max_ps, whose SSE semantics return the non-NaN
 *      operand. So a NaN flowing into those kernels generally comes out as a
 *      finite number, NOT a NaN. Functions where NaN handling is explicitly
 *      built in (expm1, log1p, pow, and the f64 exp/log) document their exact
 *      behavior in their own headers.
 *    - Build with -mavx2 -mfma (or -march=native). The #error below enforces it.
 *
 *  SPDX-License-Identifier: MIT
 * ============================================================================
 */
#ifndef AVX2_MATH_H
#define AVX2_MATH_H

/* immintrin.h declares every Intel intrinsic (SSE..AVX2, FMA). stddef.h gives
 * us size_t for the array-helper signatures. */
#include <immintrin.h>
#include <stddef.h>

/* Compile-time guard. __AVX2__ and __FMA__ are defined by the compiler only
 * when the matching ISA is enabled (-mavx2 -mfma, or a -march= that implies
 * them). Without them the intrinsics below either don't exist or silently
 * compile to slow library calls, so we fail loudly instead. */
#if !defined(__AVX2__) || !defined(__FMA__)
#  error "avx2_math.h requires AVX2 and FMA. Compile with -mavx2 -mfma (or -march=native)."
#endif

#ifdef __cplusplus
extern "C" {
#endif

/* ------------------------------------------------------------------------- *
 *  Runtime CPU capability check.
 *
 *  The #error above is a *compile-time* guard: it guarantees the binary was
 *  built with AVX2+FMA. But a binary built for AVX2 can still be *run* on an
 *  older CPU that lacks it, where the first AVX2 instruction would fault with
 *  SIGILL. Call this once at startup (the test/bench/demo all do) to detect
 *  that situation and exit gracefully instead of crashing.
 *
 *  __builtin_cpu_supports is a GCC/Clang builtin backed by CPUID. Returns
 *  non-zero only if the current CPU implements both AVX2 and FMA.
 * ------------------------------------------------------------------------- */
#if defined(__GNUC__) || defined(__clang__)
static inline int avx2_math_cpu_supported(void)
{
    return __builtin_cpu_supports("avx2") && __builtin_cpu_supports("fma");
}
#else
/* No CPUID builtin available (e.g. MSVC): assume the build target is honest. */
static inline int avx2_math_cpu_supported(void) { return 1; }
#endif

/* Pull in the actual kernels. Order matters a little: the f32 header defines
 * avx2_exp_ps / avx2_log_ps, which several other f32 kernels (expm1, log1p,
 * pow, tanh, sigmoid) build on top of. */
#include "avx2_math_f32.h"
#include "avx2_math_f64.h"

/* ------------------------------------------------------------------------- *
 *  Bulk array helpers (defined in src/avx2_math.c).
 *
 *  Each applies the matching per-vector kernel across an array of length `n`,
 *  looping 8 (float) or 4 (double) lanes at a time and finishing a ragged tail
 *  through a bounded stack buffer. `in` and `out` may be the same pointer
 *  (in-place) but must not partially overlap otherwise.
 * ------------------------------------------------------------------------- */
/* single precision: out[i] = f(in[i]) */
void avx2_exp_f32   (const float *in, float *out, size_t n);
void avx2_exp2_f32  (const float *in, float *out, size_t n);
void avx2_exp10_f32 (const float *in, float *out, size_t n);
void avx2_expm1_f32 (const float *in, float *out, size_t n);
void avx2_log_f32   (const float *in, float *out, size_t n);
void avx2_log2_f32  (const float *in, float *out, size_t n);
void avx2_log10_f32 (const float *in, float *out, size_t n);
void avx2_log1p_f32 (const float *in, float *out, size_t n);
void avx2_tanh_f32  (const float *in, float *out, size_t n);
void avx2_sigmoid_f32(const float *in, float *out, size_t n);
void avx2_rsqrt_f32 (const float *in, float *out, size_t n);
void avx2_sqrt_f32  (const float *in, float *out, size_t n);
void avx2_cbrt_f32  (const float *in, float *out, size_t n);
void avx2_softplus_f32(const float *in, float *out, size_t n);
void avx2_gelu_f32  (const float *in, float *out, size_t n);

/* single precision, two inputs: out[i] = pow(base[i], exp_[i]) */
void avx2_pow_f32   (const float *base, const float *exp_, float *out, size_t n);

/* double precision: out[i] = f(in[i]) */
void avx2_exp_f64   (const double *in, double *out, size_t n);
void avx2_log_f64   (const double *in, double *out, size_t n);

#ifdef __cplusplus
} /* extern "C" */
#endif

#endif /* AVX2_MATH_H */
