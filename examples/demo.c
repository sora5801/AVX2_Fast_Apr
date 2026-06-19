/*
 * demo.c - usage tour of the avx2_math library.
 *
 * SPDX-License-Identifier: MIT
 */
#include "avx2_math.h"
#include <stdio.h>

static void show_f32(const char *label, __m256 v)
{
    float a[8];
    _mm256_storeu_ps(a, v);
    printf("%-10s", label);
    for (int i = 0; i < 8; ++i) printf(" %10.5f", a[i]);
    printf("\n");
}

static void show_f64(const char *label, __m256d v)
{
    double a[4];
    _mm256_storeu_pd(a, v);
    printf("%-10s", label);
    for (int i = 0; i < 4; ++i) printf(" %14.10f", a[i]);
    printf("\n");
}

int main(void)
{
    if (!avx2_math_cpu_supported()) { printf("CPU lacks AVX2/FMA.\n"); return 1; }

    /* ---- single precision, 8 lanes ---- */
    const float xs[8] = { -2.0f, -1.0f, -0.5f, 0.0f, 0.5f, 1.0f, 2.0f, 3.0f };
    __m256 x = _mm256_loadu_ps(xs);

    printf("single precision (8 lanes)\n");
    show_f32("x",        x);
    show_f32("exp",      avx2_exp_ps(x));
    show_f32("exp2",     avx2_exp2_ps(x));
    show_f32("expm1",    avx2_expm1_ps(x));
    show_f32("tanh",     avx2_tanh_ps(x));
    show_f32("sigmoid",  avx2_sigmoid_ps(x));

    const float ps[8] = { 0.5f, 1.0f, 2.0f, 3.0f, 8.0f, 10.0f, 100.0f, 1000.0f };
    __m256 p = _mm256_loadu_ps(ps);
    printf("\n");
    show_f32("p",        p);
    show_f32("log",      avx2_log_ps(p));
    show_f32("log2",     avx2_log2_ps(p));
    show_f32("log10",    avx2_log10_ps(p));

    /* pow: elementwise base^exp */
    const float base[8] = { 2,2,2,2, 10,10,10,10 };
    const float ex[8]   = { 0.5f,1,2,10, 0.5f,1,2,3 };
    printf("\n");
    show_f32("base",     _mm256_loadu_ps(base));
    show_f32("exp",      _mm256_loadu_ps(ex));
    show_f32("pow",      avx2_pow_ps(_mm256_loadu_ps(base), _mm256_loadu_ps(ex)));

    /* roots and more activations */
    const float rs[8] = { 0.25f, 1.0f, 2.0f, 4.0f, 8.0f, 16.0f, 27.0f, 100.0f };
    __m256 rv = _mm256_loadu_ps(rs);
    printf("\n");
    show_f32("v",        rv);
    show_f32("sqrt",     avx2_sqrt_ps(rv));
    show_f32("rsqrt",    avx2_rsqrt_ps(rv));
    show_f32("cbrt",     avx2_cbrt_ps(rv));
    printf("\n");
    show_f32("x",        x);
    show_f32("softplus", avx2_softplus_ps(x));
    show_f32("gelu",     avx2_gelu_ps(x));

    /* trigonometry: sincos computes both at once */
    const float ang[8] = { 0.0f, 0.5236f, 0.7854f, 1.0472f, 1.5708f, 2.0944f, 3.1416f, 4.7124f };
    __m256 a = _mm256_loadu_ps(ang);
    __m256 sv, cv;
    avx2_sincos_ps(a, &sv, &cv);
    printf("\n");
    show_f32("angle",    a);
    show_f32("sin",      sv);
    show_f32("cos",      cv);

    /* round-trip sanity: log(exp(x)) should recover x */
    printf("\n");
    show_f32("log(exp)", avx2_log_ps(avx2_exp_ps(x)));

    /* ---- double precision, 4 lanes ---- */
    const double ds[4] = { 0.5, 1.0, 2.0, 10.0 };
    __m256d d = _mm256_loadu_pd(ds);
    printf("\ndouble precision (4 lanes)\n");
    show_f64("d",        d);
    show_f64("exp",      avx2_exp_pd(d));
    show_f64("log",      avx2_log_pd(d));
    show_f64("log(exp)", avx2_log_pd(avx2_exp_pd(d)));

    /* ---- bulk array helper over a non-multiple-of-8 length ---- */
    float in[13], out[13];
    for (int i = 0; i < 13; ++i) in[i] = (float)(i + 1);
    avx2_log_f32(in, out, 13);
    printf("\nlog of 1..13 (array helper, length 13):\n");
    for (int i = 0; i < 13; ++i) printf("  log(%2d) = %.6f\n", i + 1, out[i]);

    return 0;
}
