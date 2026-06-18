/*
 * avx2_math.h - Fast vectorized exp() / log() approximations for AVX2 + FMA.
 *
 * Single-precision (float / __m256, 8 lanes) implementations using
 * FMA-based Horner polynomial evaluation. The polynomial coefficients and
 * range-reduction constants follow the classic Cephes minimax fits, the same
 * ones used by Julien Pommier's sse_mathfun / avx_mathfun, but every Horner
 * step and every range-reduction step is expressed with fused multiply-add
 * (_mm256_fmadd_ps / _mm256_fnmadd_ps) for both throughput and accuracy.
 *
 * Accuracy (vs. a double-precision reference, see test/test_accuracy.c):
 *   avx2_exp_ps : < 2 ULP over [-87.3, 88.7]
 *   avx2_log_ps : < 2 ULP over (0, FLT_MAX]
 *
 * Header-only: the per-vector kernels are `static inline`. Bulk array helpers
 * (declared at the bottom) are defined in src/avx2_math.c.
 *
 * Build with: -mavx2 -mfma   (e.g. -O3 -march=native)
 *
 * SPDX-License-Identifier: MIT
 */
#ifndef AVX2_MATH_H
#define AVX2_MATH_H

#include <immintrin.h>
#include <stddef.h>

#if !defined(__AVX2__) || !defined(__FMA__)
#  error "avx2_math.h requires AVX2 and FMA. Compile with -mavx2 -mfma (or -march=native)."
#endif

#ifdef __cplusplus
extern "C" {
#endif

/* ------------------------------------------------------------------------- *
 *  exp: e^x, 8 lanes at a time.
 *
 *  Range reduction:  e^x = 2^n * e^r,  n = round(x * log2(e)),
 *                    r = x - n*ln2,  |r| <= ln2/2.
 *  ln2 is split into two constants (C1 + C2) so that n*ln2 is subtracted
 *  with near-zero rounding error via two back-to-back FMAs.
 *  e^r is then a degree-6 minimax polynomial evaluated by FMA Horner.
 *  2^n is built directly into the IEEE-754 exponent field with AVX2 integer
 *  ops (no AVX1 lane-splitting needed).
 * ------------------------------------------------------------------------- */
static inline __m256 avx2_exp_ps(__m256 x)
{
    const __m256 LOG2EF = _mm256_set1_ps(1.44269504088896341f); /* log2(e) */
    const __m256 C1     = _mm256_set1_ps(0.693359375f);         /* ln2 hi  */
    const __m256 C2     = _mm256_set1_ps(-2.12194440e-4f);      /* ln2 lo  */
    const __m256 hi     = _mm256_set1_ps(88.3762626647949f);
    const __m256 lo     = _mm256_set1_ps(-88.3762626647949f);
    const __m256 one    = _mm256_set1_ps(1.0f);

    /* Cephes single-precision e^r coefficients (degree 6, P drives r^2..). */
    const __m256 p0 = _mm256_set1_ps(1.9875691500E-4f);
    const __m256 p1 = _mm256_set1_ps(1.3981999507E-3f);
    const __m256 p2 = _mm256_set1_ps(8.3334519073E-3f);
    const __m256 p3 = _mm256_set1_ps(4.1665795894E-2f);
    const __m256 p4 = _mm256_set1_ps(1.6666665459E-1f);
    const __m256 p5 = _mm256_set1_ps(5.0000001201E-1f);

    /* Clamp to the representable range of float exp(). */
    x = _mm256_min_ps(x, hi);
    x = _mm256_max_ps(x, lo);

    /* n = round(x * log2(e)) as a float. */
    __m256 fx = _mm256_mul_ps(x, LOG2EF);
    fx = _mm256_round_ps(fx, _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC);

    /* r = x - n*C1 - n*C2  (two FMAs => one effective full-precision subtract) */
    __m256 r = _mm256_fnmadd_ps(fx, C1, x);
    r = _mm256_fnmadd_ps(fx, C2, r);

    const __m256 r2 = _mm256_mul_ps(r, r);

    /* FMA Horner: y = ((((p0*r+p1)*r+p2)*r+p3)*r+p4)*r+p5 */
    __m256 y = p0;
    y = _mm256_fmadd_ps(y, r, p1);
    y = _mm256_fmadd_ps(y, r, p2);
    y = _mm256_fmadd_ps(y, r, p3);
    y = _mm256_fmadd_ps(y, r, p4);
    y = _mm256_fmadd_ps(y, r, p5);

    /* e^r ~= y*r^2 + r + 1 */
    y = _mm256_fmadd_ps(y, r2, r);
    y = _mm256_add_ps(y, one);

    /* pow2n = 2^n via the exponent field. */
    __m256i n = _mm256_cvttps_epi32(fx);
    n = _mm256_add_epi32(n, _mm256_set1_epi32(0x7f));
    n = _mm256_slli_epi32(n, 23);
    const __m256 pow2n = _mm256_castsi256_ps(n);

    return _mm256_mul_ps(y, pow2n);
}

/* ------------------------------------------------------------------------- *
 *  log: ln(x), 8 lanes at a time.
 *
 *  x = m * 2^e with m in [sqrt(1/2), sqrt(2)) after a conditional fixup, so
 *  ln(x) = e*ln2 + ln(m). ln(m) is a degree-8 minimax polynomial in (m-1),
 *  evaluated by FMA Horner. ln2 is again split (q1 + q2) for an accurate
 *  e*ln2 reconstruction. x <= 0 returns NaN; x == 0 follows libm conventions.
 * ------------------------------------------------------------------------- */
static inline __m256 avx2_log_ps(__m256 x)
{
    const __m256 one     = _mm256_set1_ps(1.0f);
    const __m256 half    = _mm256_set1_ps(0.5f);
    const __m256 SQRTHF  = _mm256_set1_ps(0.707106781186547524f);
    const __m256 min_norm =
        _mm256_castsi256_ps(_mm256_set1_epi32(0x00800000)); /* smallest normal */
    const __m256 inv_mant_mask =
        _mm256_castsi256_ps(_mm256_set1_epi32(~0x7f800000));
    const __m256 q1 = _mm256_set1_ps(-2.12194440e-4f); /* ln2 lo */
    const __m256 q2 = _mm256_set1_ps(0.693359375f);    /* ln2 hi */

    /* Cephes single-precision ln(1+x) coefficients (degree 8). */
    const __m256 p0 = _mm256_set1_ps(7.0376836292E-2f);
    const __m256 p1 = _mm256_set1_ps(-1.1514610310E-1f);
    const __m256 p2 = _mm256_set1_ps(1.1676998740E-1f);
    const __m256 p3 = _mm256_set1_ps(-1.2420140846E-1f);
    const __m256 p4 = _mm256_set1_ps(1.4249322787E-1f);
    const __m256 p5 = _mm256_set1_ps(-1.6668057665E-1f);
    const __m256 p6 = _mm256_set1_ps(2.0000714765E-1f);
    const __m256 p7 = _mm256_set1_ps(-2.4999993993E-1f);
    const __m256 p8 = _mm256_set1_ps(3.3333331174E-1f);

    /* x <= 0 -> result will be OR'd with this NaN mask at the end. */
    const __m256 invalid_mask = _mm256_cmp_ps(x, _mm256_setzero_ps(), _CMP_LE_OS);

    x = _mm256_max_ps(x, min_norm); /* flush denormals/zero to smallest normal */

    /* e = unbiased exponent; m = mantissa scaled into [0.5, 1). */
    __m256i ei = _mm256_srli_epi32(_mm256_castps_si256(x), 23);
    x = _mm256_and_ps(x, inv_mant_mask);
    x = _mm256_or_ps(x, half);
    ei = _mm256_sub_epi32(ei, _mm256_set1_epi32(0x7f));
    __m256 e = _mm256_cvtepi32_ps(ei);
    e = _mm256_add_ps(e, one);

    /* If m < sqrt(1/2), use 2m and decrement e so (m-1) stays small. */
    const __m256 mask = _mm256_cmp_ps(x, SQRTHF, _CMP_LT_OS);
    const __m256 tmp = _mm256_and_ps(x, mask);
    x = _mm256_sub_ps(x, one);
    e = _mm256_sub_ps(e, _mm256_and_ps(one, mask));
    x = _mm256_add_ps(x, tmp); /* x is now (m-1) in roughly [-0.29, 0.41] */

    const __m256 x2 = _mm256_mul_ps(x, x);

    /* FMA Horner over the degree-8 polynomial. */
    __m256 y = p0;
    y = _mm256_fmadd_ps(y, x, p1);
    y = _mm256_fmadd_ps(y, x, p2);
    y = _mm256_fmadd_ps(y, x, p3);
    y = _mm256_fmadd_ps(y, x, p4);
    y = _mm256_fmadd_ps(y, x, p5);
    y = _mm256_fmadd_ps(y, x, p6);
    y = _mm256_fmadd_ps(y, x, p7);
    y = _mm256_fmadd_ps(y, x, p8);
    y = _mm256_mul_ps(y, x);
    y = _mm256_mul_ps(y, x2); /* y = x^3 * P(x) */

    /* Reconstruct: ln(x) = (m-1) + y - 0.5*(m-1)^2 + e*ln2. */
    y = _mm256_fmadd_ps(e, q1, y);  /* y += e*q1            */
    y = _mm256_fnmadd_ps(x2, half, y); /* y -= 0.5*x^2      */
    x = _mm256_add_ps(x, y);
    x = _mm256_fmadd_ps(e, q2, x);  /* x += e*q2            */

    /* Negative inputs -> NaN. */
    x = _mm256_or_ps(x, invalid_mask);
    return x;
}

/* ------------------------------------------------------------------------- *
 *  Bulk array helpers (defined in src/avx2_math.c). Handle any length n,
 *  including a non-multiple-of-8 tail. in and out may alias element-wise.
 * ------------------------------------------------------------------------- */
void avx2_exp_f32(const float *in, float *out, size_t n);
void avx2_log_f32(const float *in, float *out, size_t n);

#ifdef __cplusplus
} /* extern "C" */
#endif

#endif /* AVX2_MATH_H */
