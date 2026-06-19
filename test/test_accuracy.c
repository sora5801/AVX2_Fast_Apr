/*
 * test_accuracy.c - validate every avx2_math kernel against a double-precision
 * libm reference (the correctly-rounded result for the f32 kernels; scalar
 * libm for the f64 kernels).
 *
 * Reports max abs error, max relative error, and max ULP per function over a
 * dense sweep, then runs a battery of special-value checks (0, +-inf, NaN,
 * domain edges). Exits non-zero if any ULP budget or special-value check fails.
 *
 * SPDX-License-Identifier: MIT
 */
#include "avx2_math.h"

#include <math.h>
#include <stdio.h>
#include <stdint.h>
#include <string.h>

/* ====================== ULP helpers ====================== */

/* ULP distance between two floats via their ordered integer keys. */
static uint32_t ulp_diff_f(float a, float b)
{
    int32_t ia, ib;
    memcpy(&ia, &a, 4);
    memcpy(&ib, &b, 4);
    if (ia < 0) ia = (int32_t)(0x80000000u - (uint32_t)ia);
    if (ib < 0) ib = (int32_t)(0x80000000u - (uint32_t)ib);
    return (ia > ib) ? (uint32_t)(ia - ib) : (uint32_t)(ib - ia);
}

/* ULP distance between two doubles. */
static uint64_t ulp_diff_d(double a, double b)
{
    int64_t ia, ib;
    memcpy(&ia, &a, 8);
    memcpy(&ib, &b, 8);
    if (ia < 0) ia = (int64_t)(0x8000000000000000ull - (uint64_t)ia);
    if (ib < 0) ib = (int64_t)(0x8000000000000000ull - (uint64_t)ib);
    return (ia > ib) ? (uint64_t)(ia - ib) : (uint64_t)(ib - ia);
}

static int g_failures = 0;

/* ====================== f32 unary sweep ====================== */

typedef __m256 (*vfn_f)(__m256);
typedef double (*rfn_f)(double);   /* double reference, result cast to float */

static void check_f(const char *name, vfn_f vf, rfn_f rf,
                    double lo, double hi, size_t samples, uint32_t budget)
{
    double max_abs = 0.0, max_rel = 0.0;
    uint32_t max_ulp = 0;
    float worst_in = 0, worst_ref = 0, worst_got = 0;
    const double step = (hi - lo) / (double)(samples - 1);
    float in[8], out[8];

    for (size_t base = 0; base < samples; base += 8) {
        for (int k = 0; k < 8; ++k) {
            size_t idx = base + (size_t)k;
            if (idx >= samples) idx = samples - 1;
            in[k] = (float)(lo + step * (double)idx);
        }
        _mm256_storeu_ps(out, vf(_mm256_loadu_ps(in)));
        for (int k = 0; k < 8 && base + (size_t)k < samples; ++k) {
            float refv = (float)rf((double)in[k]);
            float got = out[k];
            if (!isfinite(refv) || !isfinite(got)) continue;
            double a = fabs((double)got - (double)refv);
            if (a > max_abs) max_abs = a;
            double rel = refv != 0.0f ? a / fabs((double)refv) : a;
            if (rel > max_rel) max_rel = rel;
            uint32_t u = ulp_diff_f(got, refv);
            if (u > max_ulp) { max_ulp = u; worst_in = in[k]; worst_ref = refv; worst_got = got; }
        }
    }
    int pass = max_ulp <= budget;
    if (!pass) g_failures++;
    printf("  %-9s [% .3g, % .3g]  abs=%.2e rel=%.2e ulp=%-3u (<=%u) %s\n",
           name, lo, hi, max_abs, max_rel, max_ulp, budget, pass ? "PASS" : "FAIL");
    if (!pass)
        printf("      worst @ %.9g: got %.9g ref %.9g\n", worst_in, worst_got, worst_ref);
}

/* ====================== f64 unary sweep ====================== */

typedef __m256d (*vfn_d)(__m256d);
typedef double  (*rfn_d)(double);

static void check_d(const char *name, vfn_d vf, rfn_d rf,
                    double lo, double hi, size_t samples, uint64_t budget)
{
    double max_abs = 0.0, max_rel = 0.0;
    uint64_t max_ulp = 0;
    double worst_in = 0, worst_ref = 0, worst_got = 0;
    const double step = (hi - lo) / (double)(samples - 1);
    double in[4], out[4];

    for (size_t base = 0; base < samples; base += 4) {
        for (int k = 0; k < 4; ++k) {
            size_t idx = base + (size_t)k;
            if (idx >= samples) idx = samples - 1;
            in[k] = lo + step * (double)idx;
        }
        _mm256_storeu_pd(out, vf(_mm256_loadu_pd(in)));
        for (int k = 0; k < 4 && base + (size_t)k < samples; ++k) {
            double refv = rf(in[k]);
            double got = out[k];
            if (!isfinite(refv) || !isfinite(got)) continue;
            double a = fabs(got - refv);
            if (a > max_abs) max_abs = a;
            double rel = refv != 0.0 ? a / fabs(refv) : a;
            if (rel > max_rel) max_rel = rel;
            uint64_t u = ulp_diff_d(got, refv);
            if (u > max_ulp) { max_ulp = u; worst_in = in[k]; worst_ref = refv; worst_got = got; }
        }
    }
    int pass = max_ulp <= budget;
    if (!pass) g_failures++;
    printf("  %-9s [% .3g, % .3g]  abs=%.2e rel=%.2e ulp=%-3llu (<=%llu) %s\n",
           name, lo, hi, max_abs, max_rel, (unsigned long long)max_ulp,
           (unsigned long long)budget, pass ? "PASS" : "FAIL");
    if (!pass)
        printf("      worst @ %.17g: got %.17g ref %.17g\n", worst_in, worst_got, worst_ref);
}

/* ====================== references libm lacks directly ====================== */
static double ref_exp10(double x)    { return pow(10.0, x); }
static double ref_sigmoid(double x)  { return 1.0 / (1.0 + exp(-x)); }
static double ref_rsqrt(double x)    { return 1.0 / sqrt(x); }
static double ref_softplus(double x) { return log1p(exp(x)); }
/* exact GELU (erf form) - avx2_gelu_ps is the tanh APPROXIMATION of this. */
static double ref_gelu_exact(double x) { return 0.5 * x * (1.0 + erf(x / sqrt(2.0))); }

/* GELU is checked by max ABSOLUTE error vs the exact erf form, because the
 * tanh approximation legitimately differs by ~5e-4 (not a bug), and because
 * ULP near gelu's zero-crossing is meaningless. */
static void check_gelu(void)
{
    double max_abs = 0.0, worst = 0;
    float in[8], out[8];
    const double lo = -10.0, hi = 10.0; const size_t samples = 2000003;
    const double step = (hi - lo) / (double)(samples - 1);
    for (size_t base = 0; base < samples; base += 8) {
        for (int k = 0; k < 8; ++k) {
            size_t idx = base + (size_t)k; if (idx >= samples) idx = samples - 1;
            in[k] = (float)(lo + step * (double)idx);
        }
        _mm256_storeu_ps(out, avx2_gelu_ps(_mm256_loadu_ps(in)));
        for (int k = 0; k < 8 && base + (size_t)k < samples; ++k) {
            double a = fabs((double)out[k] - ref_gelu_exact((double)in[k]));
            if (a > max_abs) { max_abs = a; worst = in[k]; }
        }
    }
    int pass = max_abs <= 1.5e-3;   /* tanh-approx error budget */
    if (!pass) g_failures++;
    printf("  %-9s [-10, 10]  max_abs_vs_exact=%.2e (<=1.5e-3, tanh approx) %s\n",
           "gelu", max_abs, pass ? "PASS" : "FAIL");
    if (!pass) printf("      worst @ %.6g\n", worst);
}

/* ====================== pow grid ====================== */
static void check_pow(void)
{
    double max_rel = 0.0; uint32_t max_ulp = 0;
    float wb = 0, we = 0, wg = 0, wr = 0;
    float bb[8], ee[8], oo[8];
    /* bases geometric over (1e-3, 1e3), exponents linear over [-6, 6]. */
    for (int bi = 0; bi < 600; ++bi) {
        double bexp = -3.0 + 6.0 * (bi / 599.0);       /* log10 of base */
        float baseval = (float)pow(10.0, bexp);
        for (int ei = 0; ei < 240; ei += 8) {
            for (int k = 0; k < 8; ++k) {
                double ev = -6.0 + 12.0 * ((ei + k) / 239.0);
                bb[k] = baseval; ee[k] = (float)ev;
            }
            _mm256_storeu_ps(oo, avx2_pow_ps(_mm256_loadu_ps(bb), _mm256_loadu_ps(ee)));
            for (int k = 0; k < 8; ++k) {
                float refv = (float)pow((double)bb[k], (double)ee[k]);
                if (!isfinite(refv) || !isfinite(oo[k]) || refv == 0.0f) continue;
                double rel = fabs((double)oo[k] - refv) / fabs((double)refv);
                if (rel > max_rel) max_rel = rel;
                uint32_t u = ulp_diff_f(oo[k], refv);
                if (u > max_ulp) { max_ulp = u; wb = bb[k]; we = ee[k]; wg = oo[k]; wr = refv; }
            }
        }
    }
    int pass = max_ulp <= 64;   /* fast pow: a few ULP typical, looser bound */
    if (!pass) g_failures++;
    printf("  %-9s base(1e-3,1e3) exp[-6,6]  rel=%.2e ulp=%-3u (<=64) %s\n",
           "pow", max_rel, max_ulp, pass ? "PASS" : "FAIL");
    printf("      worst pow(%.6g, %.4g): got %.9g ref %.9g\n", wb, we, wg, wr);
}

/* ====================== special-value checks ====================== */

static float  one_f(vfn_f f, float x)  { float o[8]; float in[8]; for(int i=0;i<8;i++) in[i]=x;
                                         _mm256_storeu_ps(o, f(_mm256_loadu_ps(in))); return o[0]; }
static double one_d(vfn_d f, double x) { double o[4]; double in[4]; for(int i=0;i<4;i++) in[i]=x;
                                         _mm256_storeu_pd(o, f(_mm256_loadu_pd(in))); return o[0]; }

/* compare with tolerance; handles inf/nan exactly */
static void expect(const char *what, double got, double want)
{
    int ok;
    if (isnan(want))      ok = isnan(got);
    else if (isinf(want)) ok = isinf(got) && ((got > 0) == (want > 0));
    else                  ok = fabs(got - want) <= 1e-6 * (1.0 + fabs(want));
    if (!ok) { g_failures++; printf("  SPECIAL FAIL %-22s got %.9g want %.9g\n", what, got, want); }
    else     {              printf("  special ok   %-22s = %.9g\n", what, got); }
}

int main(void)
{
    if (!avx2_math_cpu_supported()) {
        printf("SKIP: CPU lacks AVX2/FMA.\n");
        return 0;   /* green skip so CI on odd runners doesn't fault */
    }

    printf("=== f32 sweeps (reference: double libm, budget in ULP) ===\n");
    check_f("exp",   avx2_exp_ps,    exp,        -87.0,  88.0,   2000003, 2);
    check_f("exp2",  avx2_exp2_ps,   exp2,      -126.0, 127.0,   2000003, 2);
    check_f("exp10", avx2_exp10_ps,  ref_exp10,  -37.0,  38.0,   2000003, 2);
    check_f("expm1", avx2_expm1_ps,  expm1,      -30.0,  88.0,   2000003, 2);
    check_f("expm1", avx2_expm1_ps,  expm1,       -1.0,   1.0,    500003, 2);
    check_f("log",   avx2_log_ps,    log,         1e-30,  1e30,  2000003, 3);
    check_f("log2",  avx2_log2_ps,   log2,        1e-30,  1e30,  2000003, 3);
    check_f("log10", avx2_log10_ps,  log10,       1e-30,  1e30,  2000003, 3);
    check_f("log1p", avx2_log1p_ps,  log1p,       -0.9,   10.0,  2000003, 3);
    check_f("log1p", avx2_log1p_ps,  log1p,       -1e-3,  1e-3,   500003, 3);
    check_f("tanh",  avx2_tanh_ps,   tanh,        -20.0,  20.0,  2000003, 3);
    check_f("sigmoid",avx2_sigmoid_ps,ref_sigmoid,-30.0,  30.0,  2000003, 3);
    check_f("rsqrt", avx2_rsqrt_ps,  ref_rsqrt,    1e-6,  1e6,   2000003, 3);
    check_f("sqrt",  avx2_sqrt_ps,   sqrt,         0.0,   1e6,   2000003, 1);
    check_f("cbrt",  avx2_cbrt_ps,   cbrt,        -1e6,   1e6,   2000003, 4);
    check_f("softplus",avx2_softplus_ps,ref_softplus,-30.0,30.0, 2000003, 4);
    check_gelu();
    check_pow();

    printf("\n=== f64 sweeps ===\n");
    check_d("exp",   avx2_exp_pd, exp, -700.0, 700.0, 2000003, 2);
    check_d("exp",   avx2_exp_pd, exp,   -1.0,   1.0,  500003, 2);
    check_d("log",   avx2_log_pd, log,  1e-300, 1e300, 2000003, 2);
    check_d("log",   avx2_log_pd, log,    0.5,    2.0,  500003, 2);

    printf("\n=== special values ===\n");
    expect("f32 exp(0)",     one_f(avx2_exp_ps, 0.0f),            1.0);
    expect("f32 exp2(10)",   one_f(avx2_exp2_ps, 10.0f),          1024.0);
    expect("f32 exp10(3)",   one_f(avx2_exp10_ps, 3.0f),          1000.0);
    expect("f32 expm1(0)",   one_f(avx2_expm1_ps, 0.0f),          0.0);
    expect("f32 expm1(-inf)",one_f(avx2_expm1_ps, -INFINITY),     -1.0);
    expect("f32 expm1(+inf)",one_f(avx2_expm1_ps, INFINITY),      INFINITY);
    expect("f32 expm1(NaN)", one_f(avx2_expm1_ps, NAN),           NAN);
    expect("f32 log(1)",     one_f(avx2_log_ps, 1.0f),            0.0);
    expect("f32 log2(8)",    one_f(avx2_log2_ps, 8.0f),           3.0);
    expect("f32 log10(1000)",one_f(avx2_log10_ps, 1000.0f),       3.0);
    expect("f32 log1p(0)",   one_f(avx2_log1p_ps, 0.0f),          0.0);
    expect("f32 log1p(-1)",  one_f(avx2_log1p_ps, -1.0f),         -INFINITY);
    expect("f32 log1p(-2)",  one_f(avx2_log1p_ps, -2.0f),         NAN);
    expect("f32 tanh(0)",    one_f(avx2_tanh_ps, 0.0f),           0.0);
    expect("f32 tanh(+inf)", one_f(avx2_tanh_ps, INFINITY),       1.0);
    expect("f32 tanh(-inf)", one_f(avx2_tanh_ps, -INFINITY),      -1.0);
    expect("f32 sigmoid(0)", one_f(avx2_sigmoid_ps, 0.0f),        0.5);
    expect("f32 sigmoid(+inf)",one_f(avx2_sigmoid_ps, INFINITY),  1.0);
    expect("f32 sigmoid(-inf)",one_f(avx2_sigmoid_ps, -INFINITY), 0.0);
    expect("f32 rsqrt(4)",   one_f(avx2_rsqrt_ps, 4.0f),          0.5);
    expect("f32 rsqrt(0)",   one_f(avx2_rsqrt_ps, 0.0f),          INFINITY);
    expect("f32 rsqrt(-1)",  one_f(avx2_rsqrt_ps, -1.0f),         NAN);
    expect("f32 sqrt(16)",   one_f(avx2_sqrt_ps, 16.0f),          4.0);
    expect("f32 sqrt(-1)",   one_f(avx2_sqrt_ps, -1.0f),          NAN);
    expect("f32 cbrt(27)",   one_f(avx2_cbrt_ps, 27.0f),          3.0);
    expect("f32 cbrt(-27)",  one_f(avx2_cbrt_ps, -27.0f),         -3.0);
    expect("f32 cbrt(0)",    one_f(avx2_cbrt_ps, 0.0f),           0.0);
    expect("f32 cbrt(+inf)", one_f(avx2_cbrt_ps, INFINITY),       INFINITY);
    expect("f32 softplus(0)",one_f(avx2_softplus_ps, 0.0f),       0.6931472);
    expect("f32 softplus(-inf)",one_f(avx2_softplus_ps, -INFINITY),0.0);
    expect("f32 gelu(0)",    one_f(avx2_gelu_ps, 0.0f),           0.0);
    expect("f32 gelu(10)",   one_f(avx2_gelu_ps, 10.0f),          10.0);   /* saturates to x */
    expect("f32 gelu(-10)",  one_f(avx2_gelu_ps, -10.0f),         0.0);    /* saturates to 0 */

    {   /* pow specials */
        float o[8], b[8], e[8];
        struct { float b, e, want; } cs[] = {
            { 2.0f, 10.0f, 1024.0f }, { 9.0f, 0.5f, 3.0f }, { 5.0f, 0.0f, 1.0f },
            { 1.0f, 1e9f, 1.0f }, { -2.0f, 2.0f, NAN }, { 0.0f, 2.0f, 0.0f },
            { 0.0f, -2.0f, INFINITY }, { 0.0f, 0.0f, 1.0f }, { NAN, 0.0f, 1.0f },
            { 1.0f, NAN, 1.0f }, { 2.0f, NAN, NAN },
        };
        for (int i = 0; i < (int)(sizeof cs / sizeof cs[0]); ++i) {
            for (int k = 0; k < 8; ++k) { b[k] = cs[i].b; e[k] = cs[i].e; }
            _mm256_storeu_ps(o, avx2_pow_ps(_mm256_loadu_ps(b), _mm256_loadu_ps(e)));
            char buf[40]; snprintf(buf, sizeof buf, "f32 pow(%.3g,%.3g)", cs[i].b, cs[i].e);
            expect(buf, o[0], cs[i].want);
        }
    }

    const double E = 2.718281828459045235;
    expect("f64 exp(0)",     one_d(avx2_exp_pd, 0.0),    1.0);
    expect("f64 exp(1)",     one_d(avx2_exp_pd, 1.0),    E);
    expect("f64 exp(710)",   one_d(avx2_exp_pd, 710.0),  INFINITY);
    expect("f64 exp(-inf)",  one_d(avx2_exp_pd, -INFINITY), 0.0);
    expect("f64 exp(NaN)",   one_d(avx2_exp_pd, NAN),    NAN);
    expect("f64 log(1)",     one_d(avx2_log_pd, 1.0),    0.0);
    expect("f64 log(e)",     one_d(avx2_log_pd, E),      1.0);
    expect("f64 log(0)",     one_d(avx2_log_pd, 0.0),    -INFINITY);
    expect("f64 log(-1)",    one_d(avx2_log_pd, -1.0),   NAN);
    expect("f64 log(+inf)",  one_d(avx2_log_pd, INFINITY), INFINITY);

    printf("\n%s (%d failure%s)\n", g_failures ? "SOME TESTS FAILED" : "ALL TESTS PASSED",
           g_failures, g_failures == 1 ? "" : "s");
    return g_failures ? 1 : 0;
}
