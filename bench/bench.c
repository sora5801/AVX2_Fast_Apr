/*
 * bench.c - throughput comparison: avx2_math kernels vs scalar libm.
 *
 * Single-threaded. Each function processes an N-element array REPEATS times;
 * we report millions of elements per second for the scalar libm loop and for
 * the AVX2 kernel, plus the speedup. A running checksum is printed so the
 * optimizer cannot delete the work.
 *
 * SPDX-License-Identifier: MIT
 */
#include "avx2_math.h"

#include <math.h>
#include <stdio.h>
#include <time.h>

#define N        (1u << 22)   /* 4M elements */
#define REPEATS  20

static double seconds(void) { return (double)clock() / (double)CLOCKS_PER_SEC; }

/* ---- scalar libm reference loops ---- */
#define SCALAR_F32(NAME, FN) \
    static void NAME(const float *in, float *out, size_t n) \
    { for (size_t i = 0; i < n; ++i) out[i] = FN(in[i]); }
SCALAR_F32(s_exp,   expf)
SCALAR_F32(s_exp2,  exp2f)
SCALAR_F32(s_log,   logf)
SCALAR_F32(s_tanh,  tanhf)
SCALAR_F32(s_expm1, expm1f)

#define SCALAR_F64(NAME, FN) \
    static void NAME(const double *in, double *out, size_t n) \
    { for (size_t i = 0; i < n; ++i) out[i] = FN(in[i]); }
SCALAR_F64(s_exp_d, exp)
SCALAR_F64(s_log_d, log)

typedef void (*fn_f32)(const float *, float *, size_t);
typedef void (*fn_f64)(const double *, double *, size_t);

static double checksum_f32(const float *p, size_t n)
{ double s = 0; for (size_t i = 0; i < n; i += 4096) s += p[i]; return s; }
static double checksum_f64(const double *p, size_t n)
{ double s = 0; for (size_t i = 0; i < n; i += 4096) s += p[i]; return s; }

static void run_f32(const char *name, fn_f32 scal, fn_f32 vec,
                    const float *in, float *out, volatile double *sink)
{
    double t0 = seconds();
    for (int r = 0; r < REPEATS; ++r) { scal(in, out, N); *sink += checksum_f32(out, N); }
    double ts = seconds() - t0;
    t0 = seconds();
    for (int r = 0; r < REPEATS; ++r) { vec(in, out, N); *sink += checksum_f32(out, N); }
    double tv = seconds() - t0;
    double total = (double)N * REPEATS;
    printf("  %-10s %14.1f %14.1f %9.2fx\n", name, total/ts/1e6, total/tv/1e6, ts/tv);
}

static void run_f64(const char *name, fn_f64 scal, fn_f64 vec,
                    const double *in, double *out, volatile double *sink)
{
    double t0 = seconds();
    for (int r = 0; r < REPEATS; ++r) { scal(in, out, N); *sink += checksum_f64(out, N); }
    double ts = seconds() - t0;
    t0 = seconds();
    for (int r = 0; r < REPEATS; ++r) { vec(in, out, N); *sink += checksum_f64(out, N); }
    double tv = seconds() - t0;
    double total = (double)N * REPEATS;
    printf("  %-10s %14.1f %14.1f %9.2fx\n", name, total/ts/1e6, total/tv/1e6, ts/tv);
}

int main(void)
{
    if (!avx2_math_cpu_supported()) { printf("SKIP: CPU lacks AVX2/FMA.\n"); return 0; }

    float  *fin  = _mm_malloc(N * sizeof(float), 32);
    float  *fout = _mm_malloc(N * sizeof(float), 32);
    double *din  = _mm_malloc(N * sizeof(double), 32);
    double *dout = _mm_malloc(N * sizeof(double), 32);
    if (!fin || !fout || !din || !dout) { fprintf(stderr, "alloc failed\n"); return 1; }

    /* exp-friendly inputs in [-10, 10]; the log/tanh kernels are happy here too
     * (log gets |x| via fabs in its own domain handling for positives). */
    for (unsigned i = 0; i < N; ++i) {
        double t = -10.0 + 20.0 * ((double)i / (double)(N - 1));
        fin[i] = (float)t;
        din[i] = t;
    }

    printf("bench: N=%u, %d repeats, single-threaded, inputs in [-10,10]\n\n", N, REPEATS);
    printf("  %-10s %14s %14s %10s\n", "fn", "scalar Me/s", "avx2 Me/s", "speedup");

    volatile double sink = 0.0;
    run_f32("f32 exp",   s_exp,   avx2_exp_f32,   fin, fout, &sink);
    run_f32("f32 exp2",  s_exp2,  avx2_exp2_f32,  fin, fout, &sink);
    run_f32("f32 expm1", s_expm1, avx2_expm1_f32, fin, fout, &sink);
    run_f32("f32 tanh",  s_tanh,  avx2_tanh_f32,  fin, fout, &sink);

    /* positive inputs for log */
    for (unsigned i = 0; i < N; ++i) fin[i] = (float)(1e-3 + 1e4 * ((double)i / (double)(N - 1)));
    run_f32("f32 log",   s_log,   avx2_log_f32,   fin, fout, &sink);

    /* f64 */
    run_f64("f64 exp",   s_exp_d, avx2_exp_f64,   din, dout, &sink);
    for (unsigned i = 0; i < N; ++i) din[i] = 1e-3 + 1e4 * ((double)i / (double)(N - 1));
    run_f64("f64 log",   s_log_d, avx2_log_f64,   din, dout, &sink);

    printf("\n(checksum %.3e)\n", (double)sink);
    _mm_free(fin); _mm_free(fout); _mm_free(din); _mm_free(dout);
    return 0;
}
