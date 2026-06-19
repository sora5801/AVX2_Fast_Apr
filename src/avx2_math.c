/*
 * avx2_math.c - bulk array wrappers around the avx2_math vector kernels.
 *
 * Each helper loops the matching per-vector kernel across an array, doing the
 * body in full-width vectors and finishing a ragged tail (length not a multiple
 * of the lane count) through a small stack buffer, so we never read or write
 * past the caller's array. `in`/`out` may be the same pointer (in place).
 *
 * SPDX-License-Identifier: MIT
 */
#include "avx2_math.h"

/* ---- single precision, one input: out[i] = KERNEL(in[i]) ---------------- *
 * Bulk loop is 8 floats per iteration; the tail (< 8) is padded to a safe
 * dummy (1.0f, in every kernel's valid domain) so the kernel never faults. */
#define AVX2M_DEFINE_F32_UNARY(NAME, KERNEL)                            \
    void NAME(const float *in, float *out, size_t n)                    \
    {                                                                   \
        size_t i = 0;                                                   \
        for (; i + 8 <= n; i += 8)                                      \
            _mm256_storeu_ps(out + i, KERNEL(_mm256_loadu_ps(in + i))); \
        if (i < n) {                                                    \
            float buf[8];                                               \
            size_t rem = n - i, k;                                      \
            for (k = 0; k < rem; ++k) buf[k] = in[i + k];               \
            for (; k < 8; ++k)        buf[k] = 1.0f;                    \
            _mm256_storeu_ps(buf, KERNEL(_mm256_loadu_ps(buf)));        \
            for (k = 0; k < rem; ++k) out[i + k] = buf[k];              \
        }                                                               \
    }

AVX2M_DEFINE_F32_UNARY(avx2_exp_f32,    avx2_exp_ps)
AVX2M_DEFINE_F32_UNARY(avx2_exp2_f32,   avx2_exp2_ps)
AVX2M_DEFINE_F32_UNARY(avx2_exp10_f32,  avx2_exp10_ps)
AVX2M_DEFINE_F32_UNARY(avx2_expm1_f32,  avx2_expm1_ps)
AVX2M_DEFINE_F32_UNARY(avx2_log_f32,    avx2_log_ps)
AVX2M_DEFINE_F32_UNARY(avx2_log2_f32,   avx2_log2_ps)
AVX2M_DEFINE_F32_UNARY(avx2_log10_f32,  avx2_log10_ps)
AVX2M_DEFINE_F32_UNARY(avx2_log1p_f32,  avx2_log1p_ps)
AVX2M_DEFINE_F32_UNARY(avx2_tanh_f32,   avx2_tanh_ps)
AVX2M_DEFINE_F32_UNARY(avx2_sigmoid_f32,avx2_sigmoid_ps)

/* ---- single precision, two inputs: out[i] = pow(base[i], exp_[i]) ------- */
void avx2_pow_f32(const float *base, const float *exp_, float *out, size_t n)
{
    size_t i = 0;
    for (; i + 8 <= n; i += 8)
        _mm256_storeu_ps(out + i,
                         avx2_pow_ps(_mm256_loadu_ps(base + i),
                                     _mm256_loadu_ps(exp_ + i)));
    if (i < n) {
        float b[8], e[8];
        size_t rem = n - i, k;
        for (k = 0; k < rem; ++k) { b[k] = base[i + k]; e[k] = exp_[i + k]; }
        for (; k < 8; ++k)        { b[k] = 1.0f;        e[k] = 1.0f; }
        _mm256_storeu_ps(b, avx2_pow_ps(_mm256_loadu_ps(b), _mm256_loadu_ps(e)));
        for (k = 0; k < rem; ++k) out[i + k] = b[k];
    }
}

/* ---- double precision, one input: out[i] = KERNEL(in[i]) ---------------- *
 * Bulk loop is 4 doubles per iteration; tail padded to 1.0. */
#define AVX2M_DEFINE_F64_UNARY(NAME, KERNEL)                            \
    void NAME(const double *in, double *out, size_t n)                  \
    {                                                                   \
        size_t i = 0;                                                   \
        for (; i + 4 <= n; i += 4)                                      \
            _mm256_storeu_pd(out + i, KERNEL(_mm256_loadu_pd(in + i))); \
        if (i < n) {                                                    \
            double buf[4];                                              \
            size_t rem = n - i, k;                                      \
            for (k = 0; k < rem; ++k) buf[k] = in[i + k];               \
            for (; k < 4; ++k)        buf[k] = 1.0;                     \
            _mm256_storeu_pd(buf, KERNEL(_mm256_loadu_pd(buf)));        \
            for (k = 0; k < rem; ++k) out[i + k] = buf[k];              \
        }                                                               \
    }

AVX2M_DEFINE_F64_UNARY(avx2_exp_f64, avx2_exp_pd)
AVX2M_DEFINE_F64_UNARY(avx2_log_f64, avx2_log_pd)
