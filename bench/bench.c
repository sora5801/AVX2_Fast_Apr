/*
 * bench.c - throughput comparison: avx2_math kernels vs scalar libm.
 *
 * SPDX-License-Identifier: MIT
 */
#include "avx2_math.h"

#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define N        (1u << 22)   /* 4M elements (~16 MiB per buffer) */
#define REPEATS  20

static double seconds(void)
{
    return (double)clock() / (double)CLOCKS_PER_SEC;
}

/* Keep the optimizer honest: fold every output into a running sum. */
static double sum8(const float *p, size_t n)
{
    double s = 0.0;
    for (size_t i = 0; i < n; ++i) s += (double)p[i];
    return s;
}

static void scalar_exp(const float *in, float *out, size_t n)
{
    for (size_t i = 0; i < n; ++i) out[i] = expf(in[i]);
}
static void scalar_log(const float *in, float *out, size_t n)
{
    for (size_t i = 0; i < n; ++i) out[i] = logf(in[i]);
}

int main(void)
{
    float *in  = _mm_malloc(N * sizeof(float), 32);
    float *out = _mm_malloc(N * sizeof(float), 32);
    if (!in || !out) { fprintf(stderr, "alloc failed\n"); return 1; }

    /* Deterministic spread of inputs: exp in [-10,10], log in (0, 1e4]. */
    for (unsigned i = 0; i < N; ++i) {
        double t = (double)i / (double)(N - 1);
        in[i] = (float)(-10.0 + 20.0 * t);
    }

    struct { const char *name; void (*scalar)(const float*, float*, size_t);
             void (*vec)(const float*, float*, size_t); float lo, span; } tests[] = {
        { "exp", scalar_exp, avx2_exp_f32, -10.0f, 20.0f },
        { "log", scalar_log, avx2_log_f32,  1e-3f, 1e4f  },
    };

    printf("bench: N=%u elements, %d repeats, single-threaded\n\n", N, REPEATS);
    printf("  %-5s %14s %14s %10s\n", "fn", "scalar Melem/s", "avx2 Melem/s", "speedup");

    for (int t = 0; t < 2; ++t) {
        for (unsigned i = 0; i < N; ++i) {
            double frac = (double)i / (double)(N - 1);
            in[i] = tests[t].lo + tests[t].span * (float)frac;
        }

        volatile double sink = 0.0;

        double t0 = seconds();
        for (int r = 0; r < REPEATS; ++r) { tests[t].scalar(in, out, N); sink += sum8(out, 8); }
        double ts = seconds() - t0;

        t0 = seconds();
        for (int r = 0; r < REPEATS; ++r) { tests[t].vec(in, out, N); sink += sum8(out, 8); }
        double tv = seconds() - t0;

        double total = (double)N * REPEATS;
        double s_mes = total / ts / 1e6;
        double v_mes = total / tv / 1e6;
        printf("  %-5s %14.1f %14.1f %9.2fx\n",
               tests[t].name, s_mes, v_mes, ts / tv);
        (void)sink;
    }

    _mm_free(in);
    _mm_free(out);
    return 0;
}
