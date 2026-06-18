/*
 * test_accuracy.c - validate avx2_exp_ps / avx2_log_ps against a
 * double-precision reference (the correctly-rounded float result).
 *
 * Reports max absolute error, max relative error, and max ULP error, then
 * exits non-zero if any kernel exceeds its ULP threshold.
 *
 * SPDX-License-Identifier: MIT
 */
#include "avx2_math.h"

#include <math.h>
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>

/* ULP distance between two floats (assumes finite, same-signed magnitudes). */
static uint32_t ulp_diff(float a, float b)
{
    int32_t ia, ib;
    memcpy(&ia, &a, sizeof ia);
    memcpy(&ib, &b, sizeof ib);
    if (ia < 0) ia = (int32_t)(0x80000000u - (uint32_t)ia);
    if (ib < 0) ib = (int32_t)(0x80000000u - (uint32_t)ib);
    uint32_t d = (ia > ib) ? (uint32_t)(ia - ib) : (uint32_t)(ib - ia);
    return d;
}

typedef float (*ref_fn)(double);
static float ref_exp(double x) { return (float)exp(x); }
static float ref_log(double x) { return (float)log(x); }

typedef __m256 (*vec_fn)(__m256);

static int check(const char *name, vec_fn vf, ref_fn rf,
                 double lo, double hi, size_t samples, uint32_t ulp_budget)
{
    double max_abs = 0.0, max_rel = 0.0;
    uint32_t max_ulp = 0;
    float worst_in = 0.0f, worst_ref = 0.0f, worst_got = 0.0f;

    float in[8], out[8];
    const double step = (hi - lo) / (double)(samples - 1);

    for (size_t base = 0; base < samples; base += 8) {
        for (int k = 0; k < 8; ++k) {
            size_t idx = base + (size_t)k;
            if (idx >= samples) idx = samples - 1;
            in[k] = (float)(lo + step * (double)idx);
        }
        _mm256_storeu_ps(out, vf(_mm256_loadu_ps(in)));

        for (int k = 0; k < 8; ++k) {
            if (base + (size_t)k >= samples) break;
            float got = out[k];
            float refv = rf((double)in[k]);
            if (!isfinite(refv) || !isfinite(got)) continue;

            double a = fabs((double)got - (double)refv);
            if (a > max_abs) max_abs = a;

            double rel = (refv != 0.0f) ? a / fabs((double)refv) : a;
            if (rel > max_rel) max_rel = rel;

            uint32_t u = ulp_diff(got, refv);
            if (u > max_ulp) {
                max_ulp = u;
                worst_in = in[k]; worst_ref = refv; worst_got = got;
            }
        }
    }

    int pass = (max_ulp <= ulp_budget);
    printf("  %-10s [% .4g, % .4g]  %8zu pts   max_abs=%.3e  max_rel=%.3e  max_ulp=%u   %s\n",
           name, lo, hi, samples, max_abs, max_rel, max_ulp, pass ? "PASS" : "FAIL");
    if (!pass) {
        printf("      worst @ x=% .9g : got=% .9g  ref=% .9g\n",
               worst_in, worst_got, worst_ref);
    }
    return pass;
}

int main(void)
{
    int ok = 1;
    printf("avx2_math accuracy (reference: double-precision libm, budget in ULP)\n");

    /* exp over its full normal-output range. */
    ok &= check("exp", avx2_exp_ps, ref_exp, -87.0,   88.0,   2000003, 3);
    ok &= check("exp",  avx2_exp_ps, ref_exp, -1.0,     1.0,    500003, 3);
    ok &= check("exp",  avx2_exp_ps, ref_exp, -10.0,    0.0,    500003, 3);

    /* log over a very wide positive range plus a tight band near 1. */
    ok &= check("log", avx2_log_ps, ref_log, 1e-30,  1e30,   2000003, 3);
    ok &= check("log",  avx2_log_ps, ref_log, 0.5,     2.0,    500003, 3);
    ok &= check("log",  avx2_log_ps, ref_log, 0.9999,  1.0001, 500003, 4);

    printf("\n%s\n", ok ? "ALL TESTS PASSED" : "SOME TESTS FAILED");
    return ok ? 0 : 1;
}
