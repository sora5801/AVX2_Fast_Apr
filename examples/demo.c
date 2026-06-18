/*
 * demo.c - minimal usage example for avx2_math.
 *
 * SPDX-License-Identifier: MIT
 */
#include "avx2_math.h"
#include <stdio.h>

int main(void)
{
    /* One 8-lane vector through exp, then back through log. */
    float xs[8] = { -2.0f, -1.0f, -0.5f, 0.0f, 0.5f, 1.0f, 2.0f, 3.0f };

    __m256 v   = _mm256_loadu_ps(xs);
    __m256 e   = avx2_exp_ps(v);
    __m256 lne = avx2_log_ps(e);   /* should recover xs */

    float ev[8], rv[8];
    _mm256_storeu_ps(ev, e);
    _mm256_storeu_ps(rv, lne);

    printf("   x        exp(x)        log(exp(x))\n");
    for (int i = 0; i < 8; ++i)
        printf("% 5.2f  %12.6f  %12.6f\n", xs[i], ev[i], rv[i]);

    /* Bulk helper over an arbitrary (non-multiple-of-8) length. */
    float in[13], out[13];
    for (int i = 0; i < 13; ++i) in[i] = (float)(i + 1);
    avx2_log_f32(in, out, 13);
    printf("\nlog of 1..13:\n");
    for (int i = 0; i < 13; ++i) printf("log(%2d) = %.6f\n", i + 1, out[i]);

    return 0;
}
