/*
 * study/kernels.c - thin, non-inline instantiations of every avx2_math kernel,
 * built ONLY so the compiler emits one cleanly-labeled function body per kernel
 * into the generated assembly. (The real kernels are `static inline`, so on
 * their own they leave no standalone symbol to disassemble.)
 *
 * Each wrapper just forwards to the matching kernel; with -O3 the forwarding
 * call is fully inlined, so the body you see under `avx2k_exp_ps:` in the .s is
 * exactly the exp kernel's vectorized FMA code - nothing else.
 *
 * Generate the study artifacts with:   make asm        (or study/gen.ps1)
 * See study/README.md for what each output file is and how to read it.
 *
 * SPDX-License-Identifier: MIT
 */
#include "avx2_math.h"

/* The wrappers are deliberately NOT static and NOT inline, so each survives as
 * its own symbol. __attribute__((noinline)) is belt-and-suspenders: it stops
 * the compiler from merging identical bodies (e.g. exp2/exp10 share structure)
 * so every kernel keeps a distinct label in the assembly. */
#define KW __attribute__((noinline))

/* ---- single precision (return one __m256 = 8 floats) ---- */
KW __m256 avx2k_exp_ps   (__m256 x) { return avx2_exp_ps(x); }
KW __m256 avx2k_exp2_ps  (__m256 x) { return avx2_exp2_ps(x); }
KW __m256 avx2k_exp10_ps (__m256 x) { return avx2_exp10_ps(x); }
KW __m256 avx2k_expm1_ps (__m256 x) { return avx2_expm1_ps(x); }
KW __m256 avx2k_log_ps   (__m256 x) { return avx2_log_ps(x); }
KW __m256 avx2k_log2_ps  (__m256 x) { return avx2_log2_ps(x); }
KW __m256 avx2k_log10_ps (__m256 x) { return avx2_log10_ps(x); }
KW __m256 avx2k_log1p_ps (__m256 x) { return avx2_log1p_ps(x); }
KW __m256 avx2k_tanh_ps  (__m256 x) { return avx2_tanh_ps(x); }
KW __m256 avx2k_sigmoid_ps(__m256 x){ return avx2_sigmoid_ps(x); }
KW __m256 avx2k_rsqrt_ps (__m256 x) { return avx2_rsqrt_ps(x); }
KW __m256 avx2k_sqrt_ps  (__m256 x) { return avx2_sqrt_ps(x); }
KW __m256 avx2k_cbrt_ps  (__m256 x) { return avx2_cbrt_ps(x); }
KW __m256 avx2k_softplus_ps(__m256 x){ return avx2_softplus_ps(x); }
KW __m256 avx2k_gelu_ps  (__m256 x) { return avx2_gelu_ps(x); }
KW __m256 avx2k_sin_ps   (__m256 x) { return avx2_sin_ps(x); }
KW __m256 avx2k_cos_ps   (__m256 x) { return avx2_cos_ps(x); }
/* the full dual-output sincos (writes both results to memory) */
KW void   avx2k_sincos_ps(__m256 x, __m256 *s, __m256 *c) { avx2_sincos_ps(x, s, c); }
KW __m256 avx2k_pow_ps   (__m256 a, __m256 b) { return avx2_pow_ps(a, b); }

/* ---- double precision (return one __m256d = 4 doubles) ---- */
KW __m256d avx2k_exp_pd  (__m256d x) { return avx2_exp_pd(x); }
KW __m256d avx2k_log_pd  (__m256d x) { return avx2_log_pd(x); }
