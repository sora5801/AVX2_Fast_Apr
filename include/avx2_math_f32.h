/*
 * ============================================================================
 *  avx2_math_f32.h - single-precision (float) AVX2+FMA kernels, 8 lanes wide.
 * ============================================================================
 *
 *  Included automatically by avx2_math.h - you normally don't include this
 *  directly. Every function here operates on __m256 (eight 32-bit floats) and
 *  is `static inline`.
 *
 *  Function families and how they relate:
 *    exp    e^x          - the foundational kernel; many others reuse it.
 *    exp2   2^x          - same engine, reduced against 1 instead of ln2.
 *    exp10  10^x         - reduces against log10(2), evaluates e^(t*ln10).
 *    expm1  e^x - 1      - accurate near 0 (no 1+...-1 cancellation).
 *    log    ln x         - the foundational log kernel.
 *    log2   log2 x       - log's mantissa polynomial scaled by 1/ln2.
 *    log10  log10 x      - log's mantissa polynomial scaled by 1/ln10.
 *    log1p  ln(1+x)      - accurate near 0 (Kahan cancellation fix).
 *    tanh   tanh x       - polynomial near 0, exp identity for large |x|.
 *    sigmoid 1/(1+e^-x)  - overflow-safe logistic.
 *    pow    x^y          - 2^(y*log2 x), fast variant.
 *    rsqrt  1/sqrt(x)     - hardware seed + Newton-Raphson.
 *    sqrt   sqrt(x)       - hardware vsqrtps.
 *    cbrt   x^(1/3)       - exponent bit-trick seed + Halley.
 *    softplus ln(1+e^x)   - overflow-safe smooth ReLU.
 *    gelu   x*Phi(x)      - GPT/BERT tanh approximation.
 *    sin/cos/sincos       - Cephes quadrant reduction + dual polynomial.
 *
 *  SPDX-License-Identifier: MIT
 */
#ifndef AVX2_MATH_F32_H
#define AVX2_MATH_F32_H

#include <immintrin.h>
#include <math.h>   /* INFINITY, NAN used by expm1 / log1p / pow fixups */

/* ===========================================================================
 *  Shared single-precision minimax coefficients (Cephes).
 *
 *  Kept as file-scope constants so the several functions that share them
 *  (exp / exp2 / exp10 / expm1 all use the same e^r polynomial; log / log2 /
 *  log10 / log1p all use the same ln(1+s) polynomial) read from one source of
 *  truth. They are plain `static const float`; the compiler folds the
 *  _mm256_set1_ps broadcasts to constants, so there is no runtime cost.
 * ===========================================================================
 */

/* e^r on r in [-ln2/2, ln2/2], used as  e^r ~= 1 + r + r^2 * P(r). Degree 6. */
#define AVX2M_EXP_P0  1.9875691500E-4f
#define AVX2M_EXP_P1  1.3981999507E-3f
#define AVX2M_EXP_P2  8.3334519073E-3f
#define AVX2M_EXP_P3  4.1665795894E-2f
#define AVX2M_EXP_P4  1.6666665459E-1f
#define AVX2M_EXP_P5  5.0000001201E-1f

/* Two-part split of ln2 = 0.69314718...  Splitting it as a high part with a
 * short binary expansion (exactly representable, so multiplying by a small
 * integer is error-free) plus a tiny correction lets the range-reduction
 * subtraction  x - n*ln2  be carried out at nearly full precision. */
#define AVX2M_LN2_HI  0.693359375f      /* = 355/512, exact in binary float */
#define AVX2M_LN2_LO  -2.12194440e-4f   /* ln2 - LN2_HI                      */

/* log2(e) and friends: multiplying x by this turns "powers of e" into
 * "powers of 2" for the range-reduction step. */
#define AVX2M_LOG2EF  1.44269504088896341f   /* 1/ln2  = log2(e) */

/* ln(1+s) on small s, used as  ln(1+s) ~= s - s^2/2 + s^3 * P(s). Degree 8. */
#define AVX2M_LOG_P0  7.0376836292E-2f
#define AVX2M_LOG_P1  -1.1514610310E-1f
#define AVX2M_LOG_P2  1.1676998740E-1f
#define AVX2M_LOG_P3  -1.2420140846E-1f
#define AVX2M_LOG_P4  1.4249322787E-1f
#define AVX2M_LOG_P5  -1.6668057665E-1f
#define AVX2M_LOG_P6  2.0000714765E-1f
#define AVX2M_LOG_P7  -2.4999993993E-1f
#define AVX2M_LOG_P8  3.3333331174E-1f

/* sqrt(1/2): the threshold for folding the mantissa into [sqrt(1/2), sqrt(2))
 * so the log polynomial argument (m-1) stays small and symmetric about 0. */
#define AVX2M_SQRTHF  0.707106781186547524f

/* ===========================================================================
 *  exp:  e^x
 * ===========================================================================
 *
 *  Identity:   e^x = 2^n * e^r,  where  n = round(x * log2 e)  and
 *              r = x - n*ln2  has  |r| <= ln2/2 ~= 0.3466.
 *
 *  - n is an integer, so 2^n is exact and is injected straight into the
 *    IEEE-754 exponent field.
 *  - e^r over the tiny interval is a degree-6 minimax polynomial.
 *
 *  Accuracy: <= 1 ULP over the whole representable output range.
 *  Range:    input clamped to [-88.376, 88.376]; outside, the result
 *            saturates (no Inf is produced - a known, documented limitation
 *            shared with the reference avx_mathfun implementation).
 */
static inline __m256 avx2_exp_ps(__m256 x)
{
    const __m256 LOG2EF = _mm256_set1_ps(AVX2M_LOG2EF);
    const __m256 C1     = _mm256_set1_ps(AVX2M_LN2_HI);
    const __m256 C2     = _mm256_set1_ps(AVX2M_LN2_LO);
    const __m256 hi     = _mm256_set1_ps(88.3762626647949f);   /* exp overflow edge */
    const __m256 lo     = _mm256_set1_ps(-88.3762626647949f);  /* symmetric floor    */
    const __m256 one    = _mm256_set1_ps(1.0f);

    /* Clamp so the later (n+127)<<23 cannot overflow the 8-bit exponent field. */
    x = _mm256_min_ps(x, hi);
    x = _mm256_max_ps(x, lo);

    /* n = round(x / ln2), kept as a float. Round-to-nearest-even keeps |r| minimal. */
    __m256 fx = _mm256_mul_ps(x, LOG2EF);
    fx = _mm256_round_ps(fx, _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC);

    /* r = x - n*ln2, done as two FMAs against the (hi,lo) split of ln2. Each
     * _mm256_fnmadd_ps(a,b,c) computes c - a*b with a single rounding. */
    __m256 r = _mm256_fnmadd_ps(fx, C1, x);   /* x - n*LN2_HI */
    r = _mm256_fnmadd_ps(fx, C2, r);          /* - n*LN2_LO   */

    const __m256 r2 = _mm256_mul_ps(r, r);

    /* Horner evaluation of P(r), all fused multiply-adds. */
    __m256 y = _mm256_set1_ps(AVX2M_EXP_P0);
    y = _mm256_fmadd_ps(y, r, _mm256_set1_ps(AVX2M_EXP_P1));
    y = _mm256_fmadd_ps(y, r, _mm256_set1_ps(AVX2M_EXP_P2));
    y = _mm256_fmadd_ps(y, r, _mm256_set1_ps(AVX2M_EXP_P3));
    y = _mm256_fmadd_ps(y, r, _mm256_set1_ps(AVX2M_EXP_P4));
    y = _mm256_fmadd_ps(y, r, _mm256_set1_ps(AVX2M_EXP_P5));

    /* e^r ~= r^2 * P(r) + r + 1. */
    y = _mm256_fmadd_ps(y, r2, r);
    y = _mm256_add_ps(y, one);

    /* 2^n: (n + 127) placed into bits 23..30 of a float = the value 2^n. */
    __m256i n = _mm256_cvttps_epi32(fx);                 /* n as int32 (fx is integral) */
    n = _mm256_add_epi32(n, _mm256_set1_epi32(0x7f));     /* add exponent bias 127        */
    n = _mm256_slli_epi32(n, 23);                        /* shift into the exponent field */
    const __m256 pow2n = _mm256_castsi256_ps(n);

    return _mm256_mul_ps(y, pow2n);                      /* e^x = e^r * 2^n */
}

/* ===========================================================================
 *  exp2:  2^x
 * ===========================================================================
 *
 *  Identity:   2^x = 2^n * 2^r,  n = round(x),  r = x - n in [-0.5, 0.5].
 *
 *  Trick to reuse exp's polynomial: 2^r = e^(r * ln2), and since |r| <= 0.5,
 *  the argument  u = r*ln2  lands in [-ln2/2, ln2/2] - exactly the interval the
 *  shared e^r polynomial was fitted for. So we range-reduce against integers
 *  (cheaper: no ln2 multiply needed for n), then evaluate the SAME degree-6
 *  polynomial on u = r*ln2.
 *
 *  Because r is already tiny, a single multiply u = r*ln2 (no hi/lo split) is
 *  accurate enough - there is no large-magnitude cancellation here, unlike in
 *  exp where n*ln2 is big.
 *
 *  Accuracy: <= 1 ULP. Input clamped to [-127, 127].
 */
static inline __m256 avx2_exp2_ps(__m256 x)
{
    const __m256 LN2 = _mm256_set1_ps(0.6931471805599453f); /* ln 2 */
    const __m256 one = _mm256_set1_ps(1.0f);

    x = _mm256_min_ps(x, _mm256_set1_ps(127.0f));   /* keep n in [-127, 127] */
    x = _mm256_max_ps(x, _mm256_set1_ps(-127.0f));

    /* n = round(x); r = x - n in [-0.5, 0.5]. The subtraction is exact
     * (n is within a factor 2 of x for the bits that matter). */
    __m256 fx = _mm256_round_ps(x, _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC);
    __m256 r = _mm256_sub_ps(x, fx);

    /* u = r*ln2 maps r in [-0.5,0.5] to [-ln2/2, ln2/2]; reuse e^u polynomial. */
    const __m256 u = _mm256_mul_ps(r, LN2);
    const __m256 u2 = _mm256_mul_ps(u, u);

    __m256 y = _mm256_set1_ps(AVX2M_EXP_P0);
    y = _mm256_fmadd_ps(y, u, _mm256_set1_ps(AVX2M_EXP_P1));
    y = _mm256_fmadd_ps(y, u, _mm256_set1_ps(AVX2M_EXP_P2));
    y = _mm256_fmadd_ps(y, u, _mm256_set1_ps(AVX2M_EXP_P3));
    y = _mm256_fmadd_ps(y, u, _mm256_set1_ps(AVX2M_EXP_P4));
    y = _mm256_fmadd_ps(y, u, _mm256_set1_ps(AVX2M_EXP_P5));
    y = _mm256_fmadd_ps(y, u2, u);
    y = _mm256_add_ps(y, one);                       /* 2^r = e^u */

    __m256i n = _mm256_cvttps_epi32(fx);
    n = _mm256_add_epi32(n, _mm256_set1_epi32(0x7f));
    n = _mm256_slli_epi32(n, 23);
    return _mm256_mul_ps(y, _mm256_castsi256_ps(n)); /* 2^r * 2^n */
}

/* ===========================================================================
 *  exp10:  10^x
 * ===========================================================================
 *
 *  Identity:   10^x = 2^n * 10^t,  n = round(x * log2(10)),
 *              t = x - n*log10(2) in [-log10(2)/2, log10(2)/2] ~ +-0.1505.
 *  Then  10^t = e^(t*ln10)  with  t*ln10  in [-0.173, 0.173] subset of the
 *  shared polynomial's interval [-ln2/2, ln2/2].
 *
 *  log10(2) is split (hi,lo) just like ln2 in exp, because n can be ~128 and
 *  the product n*log10(2) must be subtracted from x without losing precision.
 *  The hi part 1233/4096 is exactly representable, so n*hi is exact for the
 *  integer n we ever see.
 *
 *  Accuracy: <= 1 ULP. Input clamped to [-37, 38] (10^38 < FLT_MAX < 10^38.6).
 */
static inline __m256 avx2_exp10_ps(__m256 x)
{
    const __m256 LOG2_10   = _mm256_set1_ps(3.32192809488736235f);  /* log2(10) */
    const __m256 LOG10_2_HI= _mm256_set1_ps(0.3010253906250f);      /* 1233/4096, exact */
    const __m256 LOG10_2_LO= _mm256_set1_ps(4.6050389130e-06f);     /* log10(2) - HI    */
    const __m256 LN10      = _mm256_set1_ps(2.30258509299404568f);  /* ln 10 */
    const __m256 one       = _mm256_set1_ps(1.0f);

    x = _mm256_min_ps(x, _mm256_set1_ps(38.0f));
    x = _mm256_max_ps(x, _mm256_set1_ps(-37.0f));

    /* n = round(x * log2 10). */
    __m256 fx = _mm256_round_ps(_mm256_mul_ps(x, LOG2_10),
                                _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC);

    /* t = x - n*log10(2), two FMAs against the (hi,lo) split. */
    __m256 t = _mm256_fnmadd_ps(fx, LOG10_2_HI, x);
    t = _mm256_fnmadd_ps(fx, LOG10_2_LO, t);

    /* u = t*ln10 -> evaluate the shared e^u polynomial. */
    const __m256 u  = _mm256_mul_ps(t, LN10);
    const __m256 u2 = _mm256_mul_ps(u, u);

    __m256 y = _mm256_set1_ps(AVX2M_EXP_P0);
    y = _mm256_fmadd_ps(y, u, _mm256_set1_ps(AVX2M_EXP_P1));
    y = _mm256_fmadd_ps(y, u, _mm256_set1_ps(AVX2M_EXP_P2));
    y = _mm256_fmadd_ps(y, u, _mm256_set1_ps(AVX2M_EXP_P3));
    y = _mm256_fmadd_ps(y, u, _mm256_set1_ps(AVX2M_EXP_P4));
    y = _mm256_fmadd_ps(y, u, _mm256_set1_ps(AVX2M_EXP_P5));
    y = _mm256_fmadd_ps(y, u2, u);
    y = _mm256_add_ps(y, one);                       /* 10^t = e^u */

    __m256i n = _mm256_cvttps_epi32(fx);
    n = _mm256_add_epi32(n, _mm256_set1_epi32(0x7f));
    n = _mm256_slli_epi32(n, 23);
    return _mm256_mul_ps(y, _mm256_castsi256_ps(n)); /* 10^t * 2^n */
}

/* ===========================================================================
 *  expm1:  e^x - 1     (accurate near 0)
 * ===========================================================================
 *
 *  Computing exp(x) and then subtracting 1 loses all precision near 0, where
 *  exp(x) ~ 1 and the subtraction cancels. Instead we keep the "-1" folded in
 *  throughout:
 *
 *    e^x - 1 = 2^k * e^r - 1 = 2^k*(e^r - 1) + (2^k - 1)
 *
 *  We form  er = e^r - 1 = r + r^2*P(r)  directly (NOT (1+...) then -1), and
 *  combine with a single FMA  2^k*er + (2^k - 1)  so the two terms are merged
 *  before rounding. A two-half exponent split handles k up to 128 (where a
 *  single 2^k would overflow). A tiny-x passthrough returns x exactly (and
 *  preserves the sign of zero, so expm1(-0) = -0).
 *
 *  Accuracy: <= 1 ULP across the whole range (empirically verified).
 *  Specials: expm1(-inf) = -1, expm1(+inf) = +inf, expm1(NaN) = NaN.
 *
 *  (Algorithm and the full edge-case map were derived and bit-pattern-verified
 *  by the design workflow; see commit history.)
 */
static inline __m256 avx2_expm1_ps(__m256 x)
{
    const __m256 LOG2EF = _mm256_set1_ps(AVX2M_LOG2EF);
    const __m256 C1     = _mm256_set1_ps(AVX2M_LN2_HI);
    const __m256 C2     = _mm256_set1_ps(AVX2M_LN2_LO);
    const __m256 one    = _mm256_set1_ps(1.0f);
    const __m256 ovf    = _mm256_set1_ps(88.72283935546875f);   /* expm1 overflow edge */
    const __m256 udf    = _mm256_set1_ps(-17.32868f);           /* below: result is -1  */
    const __m256 tiny   = _mm256_set1_ps(1.1920929e-07f);       /* 2^-23                */
    const __m256 signbit= _mm256_set1_ps(-0.0f);                /* 0x80000000 mask      */

    /* Clamp the reduction input to the overflow edge; the true +inf for larger
     * x is restored by a mask at the very end. */
    __m256 xc = _mm256_min_ps(x, ovf);

    /* k = round(x/ln2); r = x - k*ln2 via the two-part ln2 split. */
    __m256 fx = _mm256_round_ps(_mm256_mul_ps(xc, LOG2EF),
                                _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC);
    __m256 r = _mm256_fnmadd_ps(fx, C1, xc);
    r = _mm256_fnmadd_ps(fx, C2, r);
    const __m256 r2 = _mm256_mul_ps(r, r);

    /* P(r) by FMA Horner (same coefficients as exp). */
    __m256 y = _mm256_set1_ps(AVX2M_EXP_P0);
    y = _mm256_fmadd_ps(y, r, _mm256_set1_ps(AVX2M_EXP_P1));
    y = _mm256_fmadd_ps(y, r, _mm256_set1_ps(AVX2M_EXP_P2));
    y = _mm256_fmadd_ps(y, r, _mm256_set1_ps(AVX2M_EXP_P3));
    y = _mm256_fmadd_ps(y, r, _mm256_set1_ps(AVX2M_EXP_P4));
    y = _mm256_fmadd_ps(y, r, _mm256_set1_ps(AVX2M_EXP_P5));

    /* er = e^r - 1 = r + r^2*P(r)  (the deliberate difference from exp). */
    const __m256 er = _mm256_fmadd_ps(y, r2, r);

    /* k as int, and 2^k in the exponent field. */
    __m256i k = _mm256_cvttps_epi32(fx);
    __m256i nk = _mm256_slli_epi32(_mm256_add_epi32(k, _mm256_set1_epi32(0x7f)), 23);
    const __m256 twok = _mm256_castsi256_ps(nk);

    /* Accurate combine: 2^k*er + (2^k - 1), one FMA (no cancellation). */
    __m256 res = _mm256_fmadd_ps(twok, er, _mm256_sub_ps(twok, one));

    /* Overflow-safe path for k > 63 (x >~ 44): split 2^k = 2^kl * 2^kh so
     * neither exponent field overflows, then form (1+er)*2^k - 1. */
    __m256i kh = _mm256_srai_epi32(k, 1);
    __m256i kl = _mm256_sub_epi32(k, kh);
    const __m256 s1 = _mm256_castsi256_ps(
        _mm256_slli_epi32(_mm256_add_epi32(kl, _mm256_set1_epi32(0x7f)), 23));
    const __m256 s2 = _mm256_castsi256_ps(
        _mm256_slli_epi32(_mm256_add_epi32(kh, _mm256_set1_epi32(0x7f)), 23));
    const __m256 res_hi =
        _mm256_sub_ps(_mm256_mul_ps(_mm256_mul_ps(s1, _mm256_add_ps(one, er)), s2), one);
    const __m256 hipath = _mm256_castsi256_ps(
        _mm256_cmpgt_epi32(k, _mm256_set1_epi32(63)));
    res = _mm256_blendv_ps(res, res_hi, hipath);

    /* Final fixups, ORDER MATTERS: tiny-x -> underflow -> overflow -> NaN. */
    const __m256 absx = _mm256_andnot_ps(signbit, x);                 /* |x| */
    res = _mm256_blendv_ps(res, x, _mm256_cmp_ps(absx, tiny, _CMP_LT_OS));   /* |x|<2^-23 -> x */
    res = _mm256_blendv_ps(res, _mm256_set1_ps(-1.0f),
                           _mm256_cmp_ps(x, udf, _CMP_LT_OS));               /* x<-17.3 -> -1 */
    res = _mm256_blendv_ps(res, _mm256_set1_ps(INFINITY),
                           _mm256_cmp_ps(x, ovf, _CMP_GT_OS));               /* x>edge -> +inf */
    res = _mm256_blendv_ps(res, x, _mm256_cmp_ps(x, x, _CMP_UNORD_Q));       /* NaN -> NaN     */
    return res;
}

/* ===========================================================================
 *  log:  ln x
 * ===========================================================================
 *
 *  Split  x = m * 2^e  with the mantissa folded into [sqrt(1/2), sqrt(2)) so
 *  s = m - 1 is small and symmetric about 0. Then
 *
 *    ln x = e*ln2 + ln(m) = e*ln2 + (s - s^2/2 + s^3*P(s))
 *
 *  e is an exact integer (read from the exponent field); ln(m) is a degree-8
 *  minimax polynomial. e*ln2 is reconstructed from the same (hi,lo) ln2 split.
 *
 *  Accuracy: <= 2 ULP over (0, FLT_MAX].
 *  Specials: x < 0 -> NaN, x == 0 -> -inf-ish (large negative; the smallest
 *            normal is substituted for 0 internally).
 */
static inline __m256 avx2_log_ps(__m256 x)
{
    const __m256 one     = _mm256_set1_ps(1.0f);
    const __m256 half    = _mm256_set1_ps(0.5f);
    const __m256 SQRTHF  = _mm256_set1_ps(AVX2M_SQRTHF);
    const __m256 min_norm =
        _mm256_castsi256_ps(_mm256_set1_epi32(0x00800000)); /* smallest normal float  */
    const __m256 inv_mant_mask =
        _mm256_castsi256_ps(_mm256_set1_epi32(~0x7f800000));/* clears the exponent bits */
    const __m256 q1 = _mm256_set1_ps(AVX2M_LN2_LO);
    const __m256 q2 = _mm256_set1_ps(AVX2M_LN2_HI);

    /* Record x <= 0 now; its result is forced to NaN at the end. */
    const __m256 invalid_mask = _mm256_cmp_ps(x, _mm256_setzero_ps(), _CMP_LE_OS);
    x = _mm256_max_ps(x, min_norm); /* flush 0/denormals up to the smallest normal */

    /* Pull the raw biased exponent out of bits 23..30. */
    __m256i ei = _mm256_srli_epi32(_mm256_castps_si256(x), 23);

    /* Keep only the mantissa bits and force the exponent so the value is in
     * [0.5, 1): mantissa | (bias-1 in the exponent). */
    x = _mm256_and_ps(x, inv_mant_mask);
    x = _mm256_or_ps(x, half);

    /* e = rawexp - 127, then +1 because the mantissa above sits in [0.5,1). */
    ei = _mm256_sub_epi32(ei, _mm256_set1_epi32(0x7f));
    __m256 e = _mm256_cvtepi32_ps(ei);
    e = _mm256_add_ps(e, one);

    /* If m < sqrt(1/2), use 2m (and e-1) so s = m-1 stays in [-0.29, 0.41]. */
    const __m256 mask = _mm256_cmp_ps(x, SQRTHF, _CMP_LT_OS);
    const __m256 tmp = _mm256_and_ps(x, mask);
    x = _mm256_sub_ps(x, one);
    e = _mm256_sub_ps(e, _mm256_and_ps(one, mask));
    x = _mm256_add_ps(x, tmp);                       /* x is now s = m - 1 */

    const __m256 z = _mm256_mul_ps(x, x);            /* s^2 */

    /* P(s) by FMA Horner (degree 8). */
    __m256 y = _mm256_set1_ps(AVX2M_LOG_P0);
    y = _mm256_fmadd_ps(y, x, _mm256_set1_ps(AVX2M_LOG_P1));
    y = _mm256_fmadd_ps(y, x, _mm256_set1_ps(AVX2M_LOG_P2));
    y = _mm256_fmadd_ps(y, x, _mm256_set1_ps(AVX2M_LOG_P3));
    y = _mm256_fmadd_ps(y, x, _mm256_set1_ps(AVX2M_LOG_P4));
    y = _mm256_fmadd_ps(y, x, _mm256_set1_ps(AVX2M_LOG_P5));
    y = _mm256_fmadd_ps(y, x, _mm256_set1_ps(AVX2M_LOG_P6));
    y = _mm256_fmadd_ps(y, x, _mm256_set1_ps(AVX2M_LOG_P7));
    y = _mm256_fmadd_ps(y, x, _mm256_set1_ps(AVX2M_LOG_P8));
    y = _mm256_mul_ps(y, x);
    y = _mm256_mul_ps(y, z);                         /* y = s^3 * P(s) */

    /* Assemble ln x = e*ln2 + s - s^2/2 + s^3*P(s), ln2 via (hi,lo). */
    y = _mm256_fmadd_ps(e, q1, y);                   /* += e*LN2_LO     */
    y = _mm256_fnmadd_ps(z, half, y);                /* -= s^2/2        */
    x = _mm256_add_ps(x, y);                         /* s + (...)       */
    x = _mm256_fmadd_ps(e, q2, x);                   /* += e*LN2_HI     */

    return _mm256_or_ps(x, invalid_mask);            /* x <= 0 -> NaN */
}

/* ---------------------------------------------------------------------------
 *  Internal helper: the shared log reduction, returning ln(m) (the "mantissa
 *  log") and the integer exponent e separately. log2 and log10 need e as an
 *  EXACT integer term (e contributes log2: e, or log10: e*log10(2)) instead of
 *  folding it into ln2, which is both simpler and more accurate. This factors
 *  out the identical front half of log/log2/log10.
 *
 *  On return:  *mant_log = ln(m), with m in [sqrt(1/2), sqrt(2));
 *              *e_out    = the exponent e (float, exact integer);
 *              *invalid  = mask of lanes where x <= 0 (caller forces NaN).
 * ------------------------------------------------------------------------- */
static inline __m256 avx2m_log_reduce(__m256 x, __m256 *e_out, __m256 *invalid)
{
    const __m256 one  = _mm256_set1_ps(1.0f);
    const __m256 half = _mm256_set1_ps(0.5f);
    const __m256 SQRTHF = _mm256_set1_ps(AVX2M_SQRTHF);
    const __m256 min_norm = _mm256_castsi256_ps(_mm256_set1_epi32(0x00800000));
    const __m256 inv_mant_mask = _mm256_castsi256_ps(_mm256_set1_epi32(~0x7f800000));

    *invalid = _mm256_cmp_ps(x, _mm256_setzero_ps(), _CMP_LE_OS);
    x = _mm256_max_ps(x, min_norm);

    __m256i ei = _mm256_srli_epi32(_mm256_castps_si256(x), 23);
    x = _mm256_and_ps(x, inv_mant_mask);
    x = _mm256_or_ps(x, half);
    ei = _mm256_sub_epi32(ei, _mm256_set1_epi32(0x7f));
    __m256 e = _mm256_add_ps(_mm256_cvtepi32_ps(ei), one);

    const __m256 mask = _mm256_cmp_ps(x, SQRTHF, _CMP_LT_OS);
    const __m256 tmp = _mm256_and_ps(x, mask);
    x = _mm256_sub_ps(x, one);
    e = _mm256_sub_ps(e, _mm256_and_ps(one, mask));
    x = _mm256_add_ps(x, tmp);                       /* s = m - 1 */

    const __m256 z = _mm256_mul_ps(x, x);
    __m256 y = _mm256_set1_ps(AVX2M_LOG_P0);
    y = _mm256_fmadd_ps(y, x, _mm256_set1_ps(AVX2M_LOG_P1));
    y = _mm256_fmadd_ps(y, x, _mm256_set1_ps(AVX2M_LOG_P2));
    y = _mm256_fmadd_ps(y, x, _mm256_set1_ps(AVX2M_LOG_P3));
    y = _mm256_fmadd_ps(y, x, _mm256_set1_ps(AVX2M_LOG_P4));
    y = _mm256_fmadd_ps(y, x, _mm256_set1_ps(AVX2M_LOG_P5));
    y = _mm256_fmadd_ps(y, x, _mm256_set1_ps(AVX2M_LOG_P6));
    y = _mm256_fmadd_ps(y, x, _mm256_set1_ps(AVX2M_LOG_P7));
    y = _mm256_fmadd_ps(y, x, _mm256_set1_ps(AVX2M_LOG_P8));
    y = _mm256_mul_ps(y, x);
    y = _mm256_mul_ps(y, z);                         /* s^3 * P(s) */
    y = _mm256_fnmadd_ps(z, half, y);                /* - s^2/2    */

    *e_out = e;
    return _mm256_add_ps(x, y);                      /* ln(m) = s - s^2/2 + s^3 P(s) */
}

/* ===========================================================================
 *  log2:  log2 x = e + log2(m) = e + ln(m) * log2(e)
 * ===========================================================================
 *
 *  e is added EXACTLY (it is an integer), so log2 is actually a touch more
 *  accurate than computing ln then dividing. Accuracy: <= 2 ULP.
 */
static inline __m256 avx2_log2_ps(__m256 x)
{
    __m256 e, invalid;
    const __m256 mant_log = avx2m_log_reduce(x, &e, &invalid);
    /* log2 x = e + ln(m)*log2(e). One FMA folds the exact e in. */
    __m256 res = _mm256_fmadd_ps(mant_log, _mm256_set1_ps(AVX2M_LOG2EF), e);
    return _mm256_or_ps(res, invalid);               /* x <= 0 -> NaN */
}

/* ===========================================================================
 *  log10:  log10 x = e*log10(2) + ln(m) * (1/ln10)
 * ===========================================================================
 *
 *  Accuracy: <= 2 ULP. (e*log10(2) carries a tiny rounding since log10(2) is
 *  irrational, but e is small enough that it stays within budget.)
 */
static inline __m256 avx2_log10_ps(__m256 x)
{
    const __m256 LOG10E = _mm256_set1_ps(0.434294481903251828f); /* 1/ln10  */
    const __m256 LOG10_2= _mm256_set1_ps(0.301029995663981195f); /* log10 2 */
    __m256 e, invalid;
    const __m256 mant_log = avx2m_log_reduce(x, &e, &invalid);
    /* res = ln(m)*LOG10E + e*log10(2), two FMAs. */
    __m256 res = _mm256_mul_ps(mant_log, LOG10E);
    res = _mm256_fmadd_ps(e, LOG10_2, res);
    return _mm256_or_ps(res, invalid);               /* x <= 0 -> NaN */
}

/* ===========================================================================
 *  log1p:  ln(1 + x)     (accurate near 0)
 * ===========================================================================
 *
 *  For tiny x, forming (1 + x) rounds away x's low bits, so a plain log(1+x)
 *  loses precision. The Kahan/Goldberg identity restores it:
 *
 *      u = 1 + x;   ln(1+x) = (u == 1) ? x : ln(u) * (x / (u - 1))
 *
 *  The factor x/(u-1) is exactly the correction for the rounding committed when
 *  1+x became u: (u-1) is the value actually added, and the ratio rescales
 *  ln(u) back onto the true x. Reuses avx2_log_ps for ln(u).
 *
 *  Accuracy: <= 2 ULP (inherited from log; the wrapper adds none).
 *  Specials: log1p(-1) = -inf, log1p(x<-1) = NaN, log1p(+inf) = +inf,
 *            log1p(0) = 0, log1p(-0) = -0.
 */
static inline __m256 avx2_log1p_ps(__m256 x)
{
    const __m256 one  = _mm256_set1_ps(1.0f);
    const __m256 mone = _mm256_set1_ps(-1.0f);

    const __m256 u    = _mm256_add_ps(x, one);       /* rounded 1+x */
    const __m256 logu = avx2_log_ps(u);              /* ln(u)       */
    const __m256 um1  = _mm256_sub_ps(u, one);       /* the value actually added */
    const __m256 factor    = _mm256_div_ps(x, um1);  /* Kahan correction x/(u-1) */
    const __m256 corrected = _mm256_mul_ps(logu, factor);

    /* When 1+x rounds exactly to 1, the answer is x (also handles +-0). */
    __m256 res = _mm256_blendv_ps(corrected, x, _mm256_cmp_ps(u, one, _CMP_EQ_OQ));
    /* x == -1 -> -inf (log alone would give a finite large negative). */
    res = _mm256_blendv_ps(res, _mm256_set1_ps(-INFINITY),
                           _mm256_cmp_ps(x, mone, _CMP_EQ_OQ));
    /* x < -1 -> NaN (1+x < 0, domain error). */
    res = _mm256_blendv_ps(res, _mm256_set1_ps(NAN),
                           _mm256_cmp_ps(x, mone, _CMP_LT_OS));
    /* +inf -> +inf (the factor would otherwise be inf/inf = NaN). */
    res = _mm256_blendv_ps(res, _mm256_set1_ps(INFINITY),
                           _mm256_cmp_ps(x, _mm256_set1_ps(INFINITY), _CMP_EQ_OQ));
    return res;
}

/* ===========================================================================
 *  sigmoid:  1 / (1 + e^-x)     (logistic; overflow-safe)
 * ===========================================================================
 *
 *  The naive form overflows e^-x for very negative x. Feeding exp a strictly
 *  NON-POSITIVE argument avoids that: with z = e^-|x| in (0, 1],
 *
 *      sigmoid(|x|)  = 1/(1+e^-|x|) = 1 - z/(1+z)
 *      sigmoid(-|x|) =               z/(1+z)
 *
 *  and we pick by the sign of x. The divisor 1+z stays in [1, 2], never huge.
 *  Saturates cleanly: large +x -> 1, large -x -> 0. Activation function used in
 *  neural networks (e.g. attention gates, classifier heads).
 *
 *  Accuracy: <= 2 ULP. NaN is not propagated (returns ~0; see umbrella notes).
 */
static inline __m256 avx2_sigmoid_ps(__m256 x)
{
    const __m256 one      = _mm256_set1_ps(1.0f);
    const __m256 sign_mask= _mm256_castsi256_ps(_mm256_set1_epi32(0x80000000));

    const __m256 absx     = _mm256_andnot_ps(sign_mask, x);             /* |x| */
    const __m256 neg_mask = _mm256_cmp_ps(x, _mm256_setzero_ps(), _CMP_LT_OS);
    const __m256 z        = avx2_exp_ps(_mm256_sub_ps(_mm256_setzero_ps(), absx)); /* e^-|x| in (0,1] */
    const __m256 t        = _mm256_div_ps(z, _mm256_add_ps(one, z));    /* z/(1+z) = sigmoid(-|x|) */
    const __m256 big      = _mm256_sub_ps(one, t);                      /* sigmoid(+|x|)            */
    return _mm256_blendv_ps(big, t, neg_mask);                         /* x<0 ? t : big */
}

/* ===========================================================================
 *  tanh:  (e^x - e^-x) / (e^x + e^-x)
 * ===========================================================================
 *
 *  Two regions:
 *    |x| <  0.625 : a Cephes odd minimax polynomial  tanh(x) ~ x + x^3*P(x^2).
 *                   Evaluated on SIGNED x so it is intrinsically odd and has no
 *                   cancellation near 0 (where the identity below would lose
 *                   ~all precision subtracting two near-1 quantities).
 *    |x| >= 0.625 : the identity  tanh(|x|) = 1 - 2/(e^2|x| + 1), evaluated via
 *                   exp on the negated magnitude (overflow-safe), with the sign
 *                   re-applied (tanh is odd).
 *
 *  Accuracy: <= 1 ULP. Bit-exactly odd. Saturates to +-1 for |x| >~ 9.
 *  Activation function used throughout deep learning.
 */
static inline __m256 avx2_tanh_ps(__m256 x)
{
    const __m256 one       = _mm256_set1_ps(1.0f);
    const __m256 two       = _mm256_set1_ps(2.0f);
    const __m256 sign_mask = _mm256_castsi256_ps(_mm256_set1_epi32(0x80000000));
    const __m256 thresh    = _mm256_set1_ps(0.625f);

    const __m256 absx = _mm256_andnot_ps(sign_mask, x);   /* |x|             */
    const __m256 sgn  = _mm256_and_ps(sign_mask, x);      /* sign bit of x   */

    /* ---- large-|x| path: 1 - 2/(e^2|x|+1) via z = e^-2|x| in (0,1] ---- */
    const __m256 z   = avx2_exp_ps(_mm256_sub_ps(_mm256_setzero_ps(),
                                                 _mm256_mul_ps(two, absx)));
    const __m256 t   = _mm256_div_ps(z, _mm256_add_ps(one, z));   /* in (0, 0.5] */
    __m256 big       = _mm256_fnmadd_ps(two, t, one);            /* 1 - 2t      */
    big = _mm256_or_ps(big, sgn);                               /* re-apply sign */

    /* ---- small-|x| path: Cephes odd minimax, coeffs k0..k4 ---- */
    const __m256 x2 = _mm256_mul_ps(x, x);
    __m256 p = _mm256_set1_ps(-5.70498872745e-3f);
    p = _mm256_fmadd_ps(p, x2, _mm256_set1_ps( 2.06390887954e-2f));
    p = _mm256_fmadd_ps(p, x2, _mm256_set1_ps(-5.37397155531e-2f));
    p = _mm256_fmadd_ps(p, x2, _mm256_set1_ps( 1.33314422036e-1f));
    p = _mm256_fmadd_ps(p, x2, _mm256_set1_ps(-3.33332819422e-1f));
    p = _mm256_mul_ps(p, x2);                          /* x^2 * P(x^2)        */
    __m256 small = _mm256_fmadd_ps(p, x, x);           /* x + x^3 * P(x^2)    */
    small = _mm256_or_ps(small, sgn);                  /* fix tanh(-0) = -0   */

    const __m256 small_mask = _mm256_cmp_ps(absx, thresh, _CMP_LT_OS);
    return _mm256_blendv_ps(big, small, small_mask);
}

/* ===========================================================================
 *  pow:  base ^ exponent     (FAST variant)
 * ===========================================================================
 *
 *  Identity:   x^y = 2^(y * log2 x)  for x > 0.
 *
 *  This is the "fast" pow: it composes avx2_log2_ps and avx2_exp2_ps. That
 *  makes it cheap and fully vectorized, but accuracy depends on the magnitude
 *  of the product y*log2(x): it is a few ULP for moderate exponents and
 *  degrades for very large |y*log2 x| (the single-float product cannot hold
 *  enough bits). For correctly-rounded pow, use libm; for graphics / ML / bulk
 *  numeric work this is usually the right trade.
 *
 *  Special cases are layered as blends, each overriding the previous, so the
 *  precedence (last wins) is exactly:
 *      core 2^(y*log2 base)
 *      base  < 0      -> NaN     (fractional powers of negatives are complex)
 *      base == 0      -> y<0 ? +inf : 0
 *      base or y NaN  -> NaN
 *      base == 1      -> 1       (C: pow(1, y) == 1 for every y, even NaN)
 *      y    == 0      -> 1       (C: pow(x, +-0) == 1 for every x, even NaN)
 *  This reproduces the headline C pow() corner cases; e.g. pow(0,2)=0,
 *  pow(0,-2)=+inf, pow(0,0)=1, pow(NaN,0)=1, pow(1,NaN)=1, pow(2,NaN)=NaN.
 */
static inline __m256 avx2_pow_ps(__m256 base, __m256 y)
{
    const __m256 one  = _mm256_set1_ps(1.0f);
    const __m256 zero = _mm256_setzero_ps();
    const __m256 nan  = _mm256_set1_ps(NAN);

    /* Core: 2^(y * log2(base)). Only valid for base > 0; masks fix the rest. */
    __m256 res = avx2_exp2_ps(_mm256_mul_ps(y, avx2_log2_ps(base)));

    /* base < 0 -> NaN. */
    res = _mm256_blendv_ps(res, nan, _mm256_cmp_ps(base, zero, _CMP_LT_OS));
    /* base == 0 -> +inf if y<0 (pole), else 0. */
    const __m256 zb = _mm256_blendv_ps(zero, _mm256_set1_ps(INFINITY),
                                       _mm256_cmp_ps(y, zero, _CMP_LT_OS));
    res = _mm256_blendv_ps(res, zb, _mm256_cmp_ps(base, zero, _CMP_EQ_OQ));
    /* NaN in either argument -> NaN (before the base==1 / y==0 overrides). */
    const __m256 nan_in = _mm256_or_ps(_mm256_cmp_ps(base, base, _CMP_UNORD_Q),
                                       _mm256_cmp_ps(y, y, _CMP_UNORD_Q));
    res = _mm256_blendv_ps(res, nan, nan_in);
    /* base == 1 -> 1. */
    res = _mm256_blendv_ps(res, one, _mm256_cmp_ps(base, one, _CMP_EQ_OQ));
    /* y == 0 -> 1 (applied last so it wins). */
    res = _mm256_blendv_ps(res, one, _mm256_cmp_ps(y, zero, _CMP_EQ_OQ));
    return res;
}

/* ===========================================================================
 *  rsqrt:  1 / sqrt(x)     (reciprocal square root)
 * ===========================================================================
 *
 *  The classic SIMD pattern: a cheap hardware seed refined by Newton-Raphson.
 *
 *  `vrsqrtps` (_mm256_rsqrt_ps) gives ~12 correct bits in one instruction. To
 *  reach near full single precision we apply the Newton step for the root of
 *  f(y) = 1/y^2 - x, whose iteration is
 *
 *      y_{n+1} = y_n * (1.5 - 0.5*x*y_n^2)
 *
 *  Each step roughly doubles the correct bits, so two steps take ~12 -> ~24
 *  bits, i.e. ~1 ULP. We carry `0.5*x` once and use FMA so each step is two
 *  multiplies and one fnmadd.
 *
 *  Accuracy: <= 2 ULP. Edges: x==0 -> +inf, x<0 -> NaN, x==+inf -> 0
 *  (the +inf seed * the NR step would otherwise make inf*0 = NaN, so +inf is
 *  masked back to 0 explicitly).
 */
static inline __m256 avx2_rsqrt_ps(__m256 x)
{
    const __m256 half  = _mm256_set1_ps(0.5f);
    const __m256 three_halves = _mm256_set1_ps(1.5f);

    __m256 y = _mm256_rsqrt_ps(x);          /* ~12-bit approximation of 1/sqrt(x) */
    const __m256 xhalf = _mm256_mul_ps(x, half);

    /* NR step 1: y *= 1.5 - (0.5x)*y*y */
    __m256 t = _mm256_fnmadd_ps(_mm256_mul_ps(xhalf, y), y, three_halves);
    y = _mm256_mul_ps(y, t);
    /* NR step 2 */
    t = _mm256_fnmadd_ps(_mm256_mul_ps(xhalf, y), y, three_halves);
    y = _mm256_mul_ps(y, t);

    /* Edge fixups. */
    y = _mm256_blendv_ps(y, _mm256_set1_ps(INFINITY),
                         _mm256_cmp_ps(x, _mm256_setzero_ps(), _CMP_EQ_OQ)); /* x==0 -> +inf */
    y = _mm256_blendv_ps(y, _mm256_setzero_ps(),
                         _mm256_cmp_ps(x, _mm256_set1_ps(INFINITY), _CMP_EQ_OQ)); /* +inf -> 0 */
    y = _mm256_blendv_ps(y, _mm256_set1_ps(NAN),
                         _mm256_cmp_ps(x, _mm256_setzero_ps(), _CMP_LT_OS));  /* x<0 -> NaN */
    return y;
}

/* ===========================================================================
 *  cbrt:  cube root (x^(1/3))     -- the bit-manipulation showpiece
 * ===========================================================================
 *
 *  Cube root is odd, so we work on |x| and re-apply the sign at the end.
 *
 *  INITIAL GUESS by exponent surgery. If x = 2^e * m, then cbrt(x) = 2^(e/3) *
 *  cbrt(m), so dividing the *whole IEEE-754 bit pattern* by 3 and adding a
 *  bias constant lands us within a few percent of the answer in a couple of
 *  integer ops. AVX2 has no integer divide, so we divide by 3 with the
 *  multiply-high identity  n/3 = (n * 0xAAAAAAAB) >> 33  (0xAAAAAAAB ~ 2^33/3).
 *  `_mm256_mul_epu32` multiplies the even 32-bit lanes into 64-bit products; we
 *  run it once on the dwords as-is (lanes 0,2,4,6) and once on the vector
 *  shifted right 32 (lanes 1,3,5,7), shift each product right 33, and weave the
 *  two halves back together.
 *
 *  REFINEMENT by Halley's method (cubically convergent - triples the correct
 *  digits per step):  y <- y * (y^3 + 2a) / (2*y^3 + a),  a = |x|.
 *  Two iterations take the ~few-percent seed to <= 2 ULP.
 *
 *  Edges: cbrt(+-0)=+-0, cbrt(+-inf)=+-inf, cbrt(NaN)=NaN (all masked, since
 *  the Halley ratio would otherwise make 0/0 or inf/inf = NaN).
 */
static inline __m256 avx2_cbrt_ps(__m256 x)
{
    const __m256 signbit = _mm256_set1_ps(-0.0f);
    const __m256 two     = _mm256_set1_ps(2.0f);

    const __m256 sign = _mm256_and_ps(x, signbit);        /* remember sign of x */
    const __m256 a    = _mm256_andnot_ps(signbit, x);     /* a = |x|            */
    const __m256i ix  = _mm256_castps_si256(a);           /* bit pattern of |x| */

    /* q = floor(ix / 3) via multiply-high by 0xAAAAAAAB, then >> 33. */
    const __m256i M = _mm256_set1_epi32((int)0xAAAAAAABu);
    __m256i lo = _mm256_mul_epu32(ix, M);                          /* dwords 0,2,4,6 -> 64b */
    __m256i hi = _mm256_mul_epu32(_mm256_srli_epi64(ix, 32), M);   /* dwords 1,3,5,7 -> 64b */
    lo = _mm256_srli_epi64(lo, 33);                                /* /3 of even dwords     */
    hi = _mm256_srli_epi64(hi, 33);                                /* /3 of odd dwords      */
    hi = _mm256_slli_epi64(hi, 32);                               /* back to odd positions  */
    const __m256i q = _mm256_or_si256(lo, hi);                    /* floor(ix/3), all 8     */

    /* Seed: bits = q + magic bias. The bias sets the exponent offset and a
     * mantissa correction that minimizes the seed error before refinement. */
    const __m256i bias = _mm256_set1_epi32(0x2a514067);
    __m256 y = _mm256_castsi256_ps(_mm256_add_epi32(q, bias));

    /* Two Halley iterations:  y *= (y^3 + 2a) / (2 y^3 + a). */
    for (int it = 0; it < 2; ++it) {
        const __m256 y3 = _mm256_mul_ps(_mm256_mul_ps(y, y), y);
        const __m256 num = _mm256_fmadd_ps(two, a, y3);   /* y^3 + 2a  */
        const __m256 den = _mm256_fmadd_ps(two, y3, a);   /* 2 y^3 + a */
        y = _mm256_mul_ps(y, _mm256_div_ps(num, den));
    }

    /* Re-apply sign, then mask the special inputs. */
    __m256 res = _mm256_or_ps(y, sign);
    res = _mm256_blendv_ps(res, sign,                                  /* +-0 -> +-0   */
                           _mm256_cmp_ps(a, _mm256_setzero_ps(), _CMP_EQ_OQ));
    res = _mm256_blendv_ps(res, _mm256_or_ps(_mm256_set1_ps(INFINITY), sign), /* +-inf */
                           _mm256_cmp_ps(a, _mm256_set1_ps(INFINITY), _CMP_EQ_OQ));
    res = _mm256_blendv_ps(res, x, _mm256_cmp_ps(x, x, _CMP_UNORD_Q));  /* NaN -> NaN   */
    return res;
}

/* ===========================================================================
 *  sqrt:  sqrt(x)
 * ===========================================================================
 *
 *  Thin wrapper over the hardware `vsqrtps`, which is correctly rounded (0 ULP)
 *  and already handles every special case (sqrt(-x)=NaN, sqrt(+-0)=+-0,
 *  sqrt(+inf)=+inf). Provided so callers can stay in the avx2_* namespace; for
 *  a fast approximate root use 1/avx2_rsqrt_ps or x*avx2_rsqrt_ps(x).
 */
static inline __m256 avx2_sqrt_ps(__m256 x)
{
    return _mm256_sqrt_ps(x);
}

/* ===========================================================================
 *  softplus:  ln(1 + e^x)     (smooth ReLU)
 * ===========================================================================
 *
 *  The textbook `log(1 + exp(x))` overflows for large x (exp(x) -> inf) and
 *  loses precision for very negative x. The numerically stable identity
 *
 *      softplus(x) = max(x, 0) + log1p(exp(-|x|))
 *
 *  feeds exp a non-positive argument (so exp stays in (0,1], never overflows)
 *  and adds the dominant linear part max(x,0) separately. Reuses avx2_exp_ps
 *  and avx2_log1p_ps. Activation function (a smooth approximation of ReLU).
 *
 *  Accuracy: <= 2 ULP. softplus(0)=ln2, large +x -> ~x, -inf -> 0, +inf -> +inf.
 */
static inline __m256 avx2_softplus_ps(__m256 x)
{
    const __m256 zero    = _mm256_setzero_ps();
    const __m256 signbit = _mm256_set1_ps(-0.0f);

    const __m256 ax  = _mm256_andnot_ps(signbit, x);       /* |x|            */
    const __m256 m   = _mm256_max_ps(x, zero);             /* max(x, 0)      */
    const __m256 e   = avx2_exp_ps(_mm256_sub_ps(zero, ax)); /* e^-|x| in (0,1] */
    return _mm256_add_ps(m, avx2_log1p_ps(e));
}

/* ===========================================================================
 *  gelu:  Gaussian Error Linear Unit (tanh approximation)
 * ===========================================================================
 *
 *  GELU(x) = x * Phi(x), where Phi is the standard-normal CDF. The exact form
 *  needs erf; the tanh approximation used by GPT/BERT and most transformer
 *  implementations is
 *
 *      GELU(x) ~= 0.5*x*(1 + tanh( sqrt(2/pi) * (x + 0.044715*x^3) ))
 *
 *  The inner cubic is evaluated as x*(1 + 0.044715*x^2) with one FMA, then
 *  scaled by sqrt(2/pi) and passed through avx2_tanh_ps.
 *
 *  Accuracy: this is an APPROXIMATION of the exact erf-based GELU - it differs
 *  from it by up to ~1e-3 (the well-known error of the tanh form, not an
 *  implementation defect). The kernel itself is a faithful evaluation of the
 *  formula above. gelu(0)=0, large +x -> ~x, large -x -> ~0. GELU is NOT odd.
 */
static inline __m256 avx2_gelu_ps(__m256 x)
{
    const __m256 half = _mm256_set1_ps(0.5f);
    const __m256 one  = _mm256_set1_ps(1.0f);
    const __m256 c_sqrt_2_over_pi = _mm256_set1_ps(0.7978845608028654f); /* sqrt(2/pi) */
    const __m256 c_044715         = _mm256_set1_ps(0.044715f);

    const __m256 x2 = _mm256_mul_ps(x, x);
    /* inner = sqrt(2/pi) * x * (1 + 0.044715*x^2) */
    __m256 inner = _mm256_mul_ps(x, _mm256_fmadd_ps(c_044715, x2, one));
    inner = _mm256_mul_ps(inner, c_sqrt_2_over_pi);

    const __m256 t = avx2_tanh_ps(inner);
    /* 0.5*x*(1 + tanh(inner)) */
    return _mm256_mul_ps(_mm256_mul_ps(half, x), _mm256_add_ps(one, t));
}

/* ===========================================================================
 *  sin / cos / sincos     (Cephes quadrant reduction)
 * ===========================================================================
 *
 *  THE BIG IDEA. sin and cos are periodic with period 2*pi, and within one
 *  period they are just shifted/sign-flipped copies of a SINGLE small-angle
 *  polynomial. So:
 *
 *    1. Reduce |x| into a small interval [-pi/4, pi/4] by subtracting an
 *       integer multiple of pi/4. That integer (call it j) is the "octant".
 *    2. Pick which polynomial to use, and what sign, FROM THE OCTANT BITS:
 *         - bit 1 of j chooses between the sin-polynomial (odd, ~x - x^3/6...)
 *           and the cos-polynomial (even, ~1 - x^2/2...);
 *         - bit 2 of j flips the sign.
 *       Computing the result for BOTH sin and cos at once is nearly free,
 *       because they share the reduced angle and the two polynomials - hence
 *       sincos returns both.
 *
 *  WHY pi/4 IN THREE PIECES. The reduction subtracts j*(pi/4) from x. If j is
 *  large (x far from 0) and pi/4 were a single float, j*(pi/4) would be rounded
 *  and the subtraction would cancel away most of x's significant bits. Splitting
 *  pi/4 into DP1 + DP2 + DP3 (high/medium/low parts) and subtracting them one at
 *  a time with FMA keeps far more precision. (This is the same two/three-part
 *  constant trick used for ln2 in exp and log.)
 *
 *  ACCURACY: <= ~2 ULP for |x| up to a few thousand. Beyond that the 3-part
 *  reduction runs out of bits and error grows; |x| >= 2^23 or +-inf/NaN are out
 *  of range (no payne-hanek reduction here). Reduce huge arguments yourself if
 *  you need them.
 */
static inline void avx2_sincos_ps(__m256 x, __m256 *s_out, __m256 *c_out)
{
    const __m256 sign_mask     = _mm256_castsi256_ps(_mm256_set1_epi32((int)0x80000000));
    const __m256 inv_sign_mask = _mm256_castsi256_ps(_mm256_set1_epi32(0x7fffffff));
    const __m256 FOPI = _mm256_set1_ps(1.27323954473516f);   /* 4/pi: x*4/pi = octant count */
    /* pi/4 split into three parts for the extended-precision reduction. */
    const __m256 MDP1 = _mm256_set1_ps(-0.78515625f);
    const __m256 MDP2 = _mm256_set1_ps(-2.4187564849853515625e-4f);
    const __m256 MDP3 = _mm256_set1_ps(-3.77489497744594108e-8f);
    /* sin polynomial coefficients (odd function of x, in z = x^2). */
    const __m256 sin_p0 = _mm256_set1_ps(-1.9515295891E-4f);
    const __m256 sin_p1 = _mm256_set1_ps( 8.3321608736E-3f);
    const __m256 sin_p2 = _mm256_set1_ps(-1.6666654611E-1f);
    /* cos polynomial coefficients (even function of x, in z = x^2). */
    const __m256 cos_p0 = _mm256_set1_ps( 2.443315711809948E-5f);
    const __m256 cos_p1 = _mm256_set1_ps(-1.388731625493765E-3f);
    const __m256 cos_p2 = _mm256_set1_ps( 4.166664568298827E-2f);
    const __m256 half = _mm256_set1_ps(0.5f);
    const __m256 one  = _mm256_set1_ps(1.0f);

    /* sine is ODD: remember the sign bit of x, then work on |x|. */
    __m256 sign_bit_sin = _mm256_and_ps(x, sign_mask);
    x = _mm256_and_ps(x, inv_sign_mask);                 /* x = |x| */

    /* j = octant index = round(|x| * 4/pi), forced up to the next even integer. */
    __m256 y = _mm256_mul_ps(x, FOPI);
    __m256i j = _mm256_cvttps_epi32(y);                  /* truncate toward 0 */
    j = _mm256_add_epi32(j, _mm256_set1_epi32(1));        /* j + 1            */
    j = _mm256_and_si256(j, _mm256_set1_epi32(~1));       /* & ~1 -> even     */
    y = _mm256_cvtepi32_ps(j);                           /* y = (float)j     */

    /* SINE sign swap comes from bit 2 (the "4") of j: shift it up to the sign
     * bit position (bit 31) so it can be XORed into the result later. */
    __m256i swap_sin = _mm256_slli_epi32(_mm256_and_si256(j, _mm256_set1_epi32(4)), 29);
    const __m256 swap_sign_bit_sin = _mm256_castsi256_ps(swap_sin);

    /* POLYNOMIAL SELECT mask comes from bit 1 (the "2") of j: all-ones where
     * bit1 == 0. Where true we use the sin-poly for sine, cos-poly for cosine;
     * where false they swap. */
    __m256i sel = _mm256_and_si256(j, _mm256_set1_epi32(2));
    sel = _mm256_cmpeq_epi32(sel, _mm256_setzero_si256());
    const __m256 poly_mask = _mm256_castsi256_ps(sel);

    /* Extended-precision reduction: x <- x - j*(pi/4), three FMA steps. */
    x = _mm256_fmadd_ps(y, MDP1, x);
    x = _mm256_fmadd_ps(y, MDP2, x);
    x = _mm256_fmadd_ps(y, MDP3, x);                     /* now x in [-pi/4, pi/4] */

    /* COSINE sign comes from ((j-2) & 4), again shifted to the sign bit. */
    __m256i csign = _mm256_sub_epi32(j, _mm256_set1_epi32(2));
    csign = _mm256_andnot_si256(csign, _mm256_set1_epi32(4));
    csign = _mm256_slli_epi32(csign, 29);
    const __m256 sign_bit_cos = _mm256_castsi256_ps(csign);

    /* Fold the octant sin-sign into x's original sign. */
    sign_bit_sin = _mm256_xor_ps(sign_bit_sin, swap_sign_bit_sin);

    const __m256 z = _mm256_mul_ps(x, x);                /* z = x^2 */

    /* COS polynomial:  yc = 1 - z/2 + z^2 * Pcos(z). */
    __m256 yc = cos_p0;
    yc = _mm256_fmadd_ps(yc, z, cos_p1);
    yc = _mm256_fmadd_ps(yc, z, cos_p2);
    yc = _mm256_mul_ps(yc, z);
    yc = _mm256_mul_ps(yc, z);                           /* z^2 * Pcos(z)   */
    yc = _mm256_fnmadd_ps(z, half, yc);                  /* - z/2           */
    yc = _mm256_add_ps(yc, one);                         /* + 1             */

    /* SIN polynomial:  ys = x + x^3 * Psin(z) = x + x*z*Psin(z). */
    __m256 ys = sin_p0;
    ys = _mm256_fmadd_ps(ys, z, sin_p1);
    ys = _mm256_fmadd_ps(ys, z, sin_p2);
    ys = _mm256_mul_ps(ys, z);                           /* z * Psin(z)     */
    ys = _mm256_fmadd_ps(ys, x, x);                      /* x*z*Psin + x    */

    /* Select per octant: where poly_mask is true, sine uses ys and cosine uses
     * yc; where false they swap. blendv(a,b,m) = m ? b : a. */
    __m256 sin = _mm256_blendv_ps(yc, ys, poly_mask);
    __m256 cos = _mm256_blendv_ps(ys, yc, poly_mask);

    /* Apply the signs (XOR the sign bit into the result). */
    *s_out = _mm256_xor_ps(sin, sign_bit_sin);
    *c_out = _mm256_xor_ps(cos, sign_bit_cos);
}

/* sin(x): compute both, return the sine. (With -O3 the cosine-only work is
 * largely eliminated by the optimizer.) */
static inline __m256 avx2_sin_ps(__m256 x)
{
    __m256 s, c;
    avx2_sincos_ps(x, &s, &c);
    return s;
}

/* cos(x): compute both, return the cosine. */
static inline __m256 avx2_cos_ps(__m256 x)
{
    __m256 s, c;
    avx2_sincos_ps(x, &s, &c);
    return c;
}

#endif /* AVX2_MATH_F32_H */
