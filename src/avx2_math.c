/*
 * avx2_math.c - bulk array wrappers around the avx2_math.h vector kernels.
 *
 * SPDX-License-Identifier: MIT
 */
#include "avx2_math.h"

/* Process a tail of `rem` (< 8) elements through a single masked-ish pass:
 * copy into an 8-wide stack buffer, run one vector kernel, copy back. This
 * avoids reading/writing past the array bounds. */
#define AVX2M_DEFINE_ARRAY_FN(NAME, KERNEL)                              \
    void NAME(const float *in, float *out, size_t n)                    \
    {                                                                   \
        size_t i = 0;                                                   \
        for (; i + 8 <= n; i += 8) {                                    \
            __m256 v = _mm256_loadu_ps(in + i);                         \
            _mm256_storeu_ps(out + i, KERNEL(v));                       \
        }                                                               \
        if (i < n) {                                                    \
            float buf[8];                                               \
            size_t rem = n - i, k;                                      \
            for (k = 0; k < rem; ++k) buf[k] = in[i + k];               \
            for (; k < 8; ++k)        buf[k] = 1.0f; /* safe dummy */   \
            __m256 v = _mm256_loadu_ps(buf);                            \
            _mm256_storeu_ps(buf, KERNEL(v));                           \
            for (k = 0; k < rem; ++k) out[i + k] = buf[k];              \
        }                                                               \
    }

AVX2M_DEFINE_ARRAY_FN(avx2_exp_f32, avx2_exp_ps)
AVX2M_DEFINE_ARRAY_FN(avx2_log_f32, avx2_log_ps)
