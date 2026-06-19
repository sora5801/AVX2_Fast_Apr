/*
 * ============================================================================
 *  avx2_math_f64.h - double-precision (double) AVX2+FMA kernels, 4 lanes wide.
 * ============================================================================
 *
 *  Included automatically by avx2_math.h. Every function operates on __m256d
 *  (four 64-bit doubles) and is `static inline`.
 *
 *  Double precision is the more delicate target on AVX2, for one specific
 *  reason: AVX2 has no instruction to convert between 64-bit integers and
 *  doubles (that arrived only with AVX-512's vcvtqq2pd / vcvtpd2qq). The
 *  exponent-field bit tricks all need a 64-bit integer per lane, so we reach
 *  the int64 lanes through a detour:
 *
 *      doubles --(cvtpd_epi32)--> 4x int32 in a __m128i
 *              --(cvtepi32_epi64)--> 4x int64 in a __m256i   (widen)
 *      ... 64-bit add / shift in the exponent field ...
 *      int64 --(pack low dwords, cvtepi32_pd)--> back to doubles
 *
 *  Both are legal AVX2. The comments below point out each such hop.
 *
 *  Accuracy: exp <= 2 ULP, log <= 2 ULP (measured vs scalar libm on the
 *  promoted double; see test/test_accuracy.c).
 *
 *  SPDX-License-Identifier: MIT
 */
#ifndef AVX2_MATH_F64_H
#define AVX2_MATH_F64_H

#include <immintrin.h>
#include <math.h>   /* INFINITY, NAN */

/* ===========================================================================
 *  exp:  e^x   (double, 4 lanes)
 * ===========================================================================
 *
 *  Same skeleton as the f32 exp: n = round(x*log2 e); r = x - n*ln2 via a
 *  (hi,lo) double split; e^r by a Cephes RATIONAL approximation
 *
 *      e^r = 1 + 2r * P(r^2) / ( Q(r^2) - r*P(r^2) )
 *
 *  (a rational converges faster than a pure polynomial for double precision,
 *  at the cost of one divide). 2^n is built with the int32->int64 detour, and
 *  to cover the full double exponent range without overflowing the 11-bit
 *  field, n is split into two halves n1+n2 and applied as 2^n1 * 2^n2.
 *
 *  Overflow (x > 709.78) -> +inf; underflow (x < -745.13) -> 0; +inf -> +inf;
 *  -inf -> 0; NaN -> NaN. The min/max clamp does NOT preserve NaN, so the NaN
 *  (and over/underflow) masks are captured BEFORE clamping and re-applied at
 *  the end.
 *
 *  (Algorithm derived and grid-verified by the design workflow.)
 */
static inline __m256d avx2_exp_pd(__m256d x)
{
    const __m256d LOG2E  = _mm256_set1_pd(1.4426950408889634074);
    const __m256d LN2_HI = _mm256_set1_pd(6.93145751953125e-1);    /* exact in binary */
    const __m256d LN2_LO = _mm256_set1_pd(1.42860682030941723212e-6);
    const __m256d one    = _mm256_set1_pd(1.0);
    const __m256d hi     = _mm256_set1_pd(709.782712893383996843); /* overflow edge  */
    const __m256d lo     = _mm256_set1_pd(-745.13321910194110842); /* underflow edge */
    /* Cephes double-exp rational coefficients. */
    const __m256d P0 = _mm256_set1_pd(1.26177193074810590878e-4);
    const __m256d P1 = _mm256_set1_pd(3.02994407707441961300e-2);
    const __m256d P2 = _mm256_set1_pd(9.99999999999999999910e-1);
    const __m256d Q0 = _mm256_set1_pd(3.00198505138664455042e-6);
    const __m256d Q1 = _mm256_set1_pd(2.52448340349684104192e-3);
    const __m256d Q2 = _mm256_set1_pd(2.27265548208155028766e-1);
    const __m256d Q3 = _mm256_set1_pd(2.00000000000000000005e0);

    /* Capture specials FIRST: the clamp below destroys the information, and
     * min_pd/max_pd return the non-NaN operand so a NaN would survive as a
     * finite clamp bound otherwise. */
    const __m256d overflow_mask  = _mm256_cmp_pd(x, hi, _CMP_GT_OQ);
    const __m256d underflow_mask = _mm256_cmp_pd(x, lo, _CMP_LT_OQ);
    const __m256d nan_mask       = _mm256_cmp_pd(x, x, _CMP_UNORD_Q);

    x = _mm256_min_pd(x, hi);
    x = _mm256_max_pd(x, lo);

    /* n = round(x * log2 e), kept as a double. */
    const __m256d fx = _mm256_round_pd(_mm256_mul_pd(x, LOG2E),
                                       _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC);

    /* r = x - n*ln2 via two FMAs against the (hi,lo) split. */
    __m256d r = _mm256_fnmadd_pd(fx, LN2_HI, x);
    r = _mm256_fnmadd_pd(fx, LN2_LO, r);
    const __m256d r2 = _mm256_mul_pd(r, r);

    /* px = r * P(r^2). */
    __m256d px = P0;
    px = _mm256_fmadd_pd(px, r2, P1);
    px = _mm256_fmadd_pd(px, r2, P2);
    px = _mm256_mul_pd(px, r);

    /* qx = Q(r^2). */
    __m256d qx = Q0;
    qx = _mm256_fmadd_pd(qx, r2, Q1);
    qx = _mm256_fmadd_pd(qx, r2, Q2);
    qx = _mm256_fmadd_pd(qx, r2, Q3);

    /* e^r = 1 + 2*px/(qx - px). */
    const __m256d ratio = _mm256_div_pd(px, _mm256_sub_pd(qx, px));
    __m256d y = _mm256_fmadd_pd(_mm256_set1_pd(2.0), ratio, one);

    /* Build 2^n, two-step so the 11-bit exponent field never overflows.
     * ni: 4x int32 (fx is integral, so the conversion is exact). */
    const __m128i ni    = _mm256_cvtpd_epi32(fx);
    const __m128i n1_32 = _mm_srai_epi32(ni, 1);          /* n1 = n >> 1 (floor)   */
    const __m128i n2_32 = _mm_sub_epi32(ni, n1_32);       /* n2 = n - n1, so n1+n2=n */
    __m256i n1_64 = _mm256_cvtepi32_epi64(n1_32);         /* widen to 4x int64     */
    __m256i n2_64 = _mm256_cvtepi32_epi64(n2_32);
    const __m256i bias = _mm256_set1_epi64x(1023);
    /* (n_half + 1023) << 52  == the bits of 2^(n_half). */
    n1_64 = _mm256_slli_epi64(_mm256_add_epi64(n1_64, bias), 52);
    n2_64 = _mm256_slli_epi64(_mm256_add_epi64(n2_64, bias), 52);
    y = _mm256_mul_pd(y, _mm256_castsi256_pd(n1_64));     /* * 2^n1 */
    y = _mm256_mul_pd(y, _mm256_castsi256_pd(n2_64));     /* * 2^n2  -> * 2^n */

    /* Re-apply the specials captured up front (mutually exclusive). */
    y = _mm256_blendv_pd(y, _mm256_set1_pd(INFINITY), overflow_mask);
    y = _mm256_blendv_pd(y, _mm256_setzero_pd(),      underflow_mask);
    y = _mm256_blendv_pd(y, _mm256_set1_pd(NAN),      nan_mask);
    return y;
}

/* ===========================================================================
 *  log:  ln x   (double, 4 lanes)
 * ===========================================================================
 *
 *  Split  x = m * 2^e  with m in [sqrt(1/2), sqrt(2)) and
 *
 *      ln x = e*ln2 + ln(m),   ln(m) = s - s^2/2 + s^3 * P(s)/Q(s),  s = m - 1
 *
 *  using the Cephes double-log rational P/Q (degree 5 over monic degree 6).
 *  e*ln2 uses the same (hi,lo) split as exp. Tiny (denormal) inputs are scaled
 *  up by 2^54 first, with 54 subtracted back from e, so the exponent extraction
 *  stays in the normalized regime.
 *
 *  Specials: x < 0 -> NaN, x == 0 -> -inf, x == +inf -> +inf, NaN -> NaN.
 *
 *  AVX2 int64->double detour: the exponent comes out as four int64 lanes; we
 *  pack their low dwords to a __m128i and use _mm256_cvtepi32_pd.
 */
static inline __m256d avx2_log_pd(__m256d x)
{
    const __m256d one  = _mm256_set1_pd(1.0);
    const __m256d half = _mm256_set1_pd(0.5);
    const __m256d SQRTH= _mm256_set1_pd(0.70710678118654752440);
    const __m256d C1   = _mm256_set1_pd(0.693359375);                 /* ln2 hi */
    const __m256d C2   = _mm256_set1_pd(-2.121944400546905827679e-4); /* ln2 lo */
    const __m256d DBL_MIN_NORM = _mm256_set1_pd(2.2250738585072014e-308); /* smallest normal */
    const __m256d two54 = _mm256_set1_pd(18014398509481984.0);        /* 2^54 */

    /* Cephes double-log rational coefficients (P degree 5, Q monic degree 6). */
    const __m256d P0 = _mm256_set1_pd(1.01875663804580931796e-4);
    const __m256d P1 = _mm256_set1_pd(4.97494994976747001425e-1);
    const __m256d P2 = _mm256_set1_pd(4.70579119878881725854e0);
    const __m256d P3 = _mm256_set1_pd(1.44989225341610930846e1);
    const __m256d P4 = _mm256_set1_pd(1.79368678507819816313e1);
    const __m256d P5 = _mm256_set1_pd(7.70838733755885391666e0);
    const __m256d Q0 = _mm256_set1_pd(1.12873587189167450590e1);
    const __m256d Q1 = _mm256_set1_pd(4.52279145837532221105e1);
    const __m256d Q2 = _mm256_set1_pd(8.29875266912776603211e1);
    const __m256d Q3 = _mm256_set1_pd(7.11544750618563894466e1);
    const __m256d Q4 = _mm256_set1_pd(2.31251620126765340583e1);

    /* Special-input masks, captured on the ORIGINAL x. */
    const __m256d nan_mask    = _mm256_cmp_pd(x, x, _CMP_UNORD_Q);
    const __m256d neg_mask    = _mm256_cmp_pd(x, _mm256_setzero_pd(), _CMP_LT_OQ);
    const __m256d zero_mask   = _mm256_cmp_pd(x, _mm256_setzero_pd(), _CMP_EQ_OQ);
    const __m256d posinf_mask = _mm256_cmp_pd(x, _mm256_set1_pd(INFINITY), _CMP_EQ_OQ);

    /* Scale denormals into the normal range; remember to undo it in e. The mask
     * also catches x <= 0, but those lanes are overwritten by the masks above. */
    const __m256d dmask = _mm256_cmp_pd(x, DBL_MIN_NORM, _CMP_LT_OQ);
    x = _mm256_blendv_pd(x, _mm256_mul_pd(x, two54), dmask);

    /* --- extract raw exponent (int) and mantissa (-> [0.5,1)) --- */
    const __m256i bits = _mm256_castpd_si256(x);
    __m256i ei = _mm256_and_si256(_mm256_srli_epi64(bits, 52),
                                  _mm256_set1_epi64x(0x7ff));
    const __m256i mbits = _mm256_or_si256(
        _mm256_and_si256(bits, _mm256_set1_epi64x(0x000fffffffffffffLL)),
        _mm256_set1_epi64x(0x3fe0000000000000LL));        /* exponent for [0.5,1) */
    __m256d m = _mm256_castsi256_pd(mbits);

    /* int64 exponent -> double: pack the low dword of each 64-bit lane into a
     * __m128i (4x int32), then cvtepi32_pd. Values are 0..2047, so positive. */
    const __m128i elo = _mm256_castsi256_si128(ei);       /* lanes 0,1 */
    const __m128i ehi = _mm256_extracti128_si256(ei, 1);  /* lanes 2,3 */
    const __m128i epacked = _mm_castps_si128(_mm_shuffle_ps(
        _mm_castsi128_ps(elo), _mm_castsi128_ps(ehi), _MM_SHUFFLE(2, 0, 2, 0)));
    __m256d e = _mm256_cvtepi32_pd(epacked);
    e = _mm256_sub_pd(e, _mm256_set1_pd(1022.0));         /* frexp exponent convention */
    e = _mm256_sub_pd(e, _mm256_and_pd(dmask, _mm256_set1_pd(54.0))); /* undo 2^54 scale */

    /* --- fold mantissa: if m < sqrt(1/2), use 2m-1 and e-1 --- */
    const __m256d fold = _mm256_cmp_pd(m, SQRTH, _CMP_LT_OQ);
    const __m256d madd = _mm256_and_pd(fold, m);          /* extra m where folded */
    m = _mm256_sub_pd(m, one);                            /* m - 1                */
    m = _mm256_add_pd(m, madd);                           /* -> 2m-1 if folded    */
    e = _mm256_sub_pd(e, _mm256_and_pd(fold, one));       /* e - 1 if folded      */

    const __m256d z = _mm256_mul_pd(m, m);                /* s^2 */

    /* P(s) by FMA Horner (degree 5). */
    __m256d Pp = P0;
    Pp = _mm256_fmadd_pd(Pp, m, P1);
    Pp = _mm256_fmadd_pd(Pp, m, P2);
    Pp = _mm256_fmadd_pd(Pp, m, P3);
    Pp = _mm256_fmadd_pd(Pp, m, P4);
    Pp = _mm256_fmadd_pd(Pp, m, P5);

    /* Q(s) monic degree 6: leading coefficient is an implicit 1, so start with
     * (s + Q0) and FMA the rest. */
    __m256d Qq = _mm256_add_pd(m, Q0);
    Qq = _mm256_fmadd_pd(Qq, m, Q1);
    Qq = _mm256_fmadd_pd(Qq, m, Q2);
    Qq = _mm256_fmadd_pd(Qq, m, Q3);
    Qq = _mm256_fmadd_pd(Qq, m, Q4);

    /* y = s^3 * P/Q. */
    __m256d y = _mm256_mul_pd(m, _mm256_mul_pd(z, _mm256_div_pd(Pp, Qq)));

    /* Reconstruct ln x = e*ln2 + s - s^2/2 + s^3 P/Q. */
    y = _mm256_fmadd_pd(e, C2, y);                        /* += e*ln2_lo */
    y = _mm256_fnmadd_pd(z, half, y);                    /* -= s^2/2    */
    __m256d res = _mm256_add_pd(m, y);                   /* s + (...)   */
    res = _mm256_fmadd_pd(e, C1, res);                   /* += e*ln2_hi */

    /* Apply specials (mutually exclusive for any single input). */
    res = _mm256_blendv_pd(res, _mm256_set1_pd(INFINITY),  posinf_mask);
    res = _mm256_blendv_pd(res, _mm256_set1_pd(-INFINITY), zero_mask);
    res = _mm256_blendv_pd(res, _mm256_set1_pd(NAN),       neg_mask);
    res = _mm256_blendv_pd(res, _mm256_set1_pd(NAN),       nan_mask);
    return res;
}

#endif /* AVX2_MATH_F64_H */
