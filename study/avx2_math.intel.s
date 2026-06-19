	.file	"kernels.c"
	.intel_syntax noprefix
 # GNU C23 (Rev8, Built by MSYS2 project) version 15.2.0 (x86_64-w64-mingw32)
 #	compiled by GNU C version 15.2.0, GMP version 6.3.0, MPFR version 4.2.2, MPC version 1.3.1, isl version isl-0.27-GMP

 # GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
 # options passed: -mavx2 -mfma -masm=intel -mtune=generic -march=nocona -O3
	.text
	.p2align 4
	.globl	avx2k_exp_ps
	.def	avx2k_exp_ps;	.scl	2;	.type	32;	.endef
	.seh_proc	avx2k_exp_ps
avx2k_exp_ps:
	.seh_endprologue
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:292:   return (__m256) __builtin_ia32_minps256 ((__v8sf)__A, (__v8sf)__B);
	vbroadcastss	ymm1, DWORD PTR .LC1[rip]	 # tmp125,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:161:   return (__m256)__builtin_ia32_vfnmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vbroadcastss	ymm2, DWORD PTR .LC7[rip]	 # tmp144,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vbroadcastss	ymm3, DWORD PTR .LC13[rip]	 # tmp152,
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:25: KW __m256 avx2k_exp_ps   (__m256 x) { return avx2_exp_ps(x); }
	vmovups	ymm0, YMMWORD PTR [rdx]	 # x, x
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:292:   return (__m256) __builtin_ia32_minps256 ((__v8sf)__A, (__v8sf)__B);
	vminps	ymm0, ymm0, ymm1	 # _6, x, tmp125
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:280:   return (__m256) __builtin_ia32_maxps256 ((__v8sf)__A, (__v8sf)__B);
	vbroadcastss	ymm1, DWORD PTR .LC3[rip]	 # tmp132,
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:25: KW __m256 avx2k_exp_ps   (__m256 x) { return avx2_exp_ps(x); }
	mov	rax, rcx	 # .result_ptr, .result_ptr
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:280:   return (__m256) __builtin_ia32_maxps256 ((__v8sf)__A, (__v8sf)__B);
	vmaxps	ymm0, ymm0, ymm1	 # _8, _6, tmp132
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vbroadcastss	ymm1, DWORD PTR .LC5[rip]	 # tmp141,
	vmulps	ymm1, ymm0, ymm1	 # _9, _8, tmp141
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:1010:   return (__m256) __builtin_ia32_roundps256 ((__v8sf)__V, __M);
	vroundps	ymm1, ymm1, 8	 # tmp138, _9,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:161:   return (__m256)__builtin_ia32_vfnmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vfnmadd231ps	ymm0, ymm1, ymm2	 # tmp142, tmp138, tmp144
	vbroadcastss	ymm2, DWORD PTR .LC9[rip]	 # tmp147,
	vfnmadd132ps	ymm2, ymm0, ymm1	 # tmp145, tmp142, tmp138
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:443:   return (__m256i)__builtin_ia32_cvttps2dq256 ((__v8sf) __A);
	vcvttps2dq	ymm1, ymm1	 # tmp167, tmp138
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vbroadcastss	ymm0, DWORD PTR .LC11[rip]	 # tmp150,
	vfmadd132ps	ymm0, ymm3, ymm2	 # tmp148, tmp152, tmp145
	vbroadcastss	ymm3, DWORD PTR .LC15[rip]	 # tmp155,
	vfmadd132ps	ymm0, ymm3, ymm2	 # tmp153, tmp155, tmp145
	vbroadcastss	ymm3, DWORD PTR .LC17[rip]	 # tmp158,
	vfmadd132ps	ymm0, ymm3, ymm2	 # tmp156, tmp158, tmp145
	vbroadcastss	ymm3, DWORD PTR .LC19[rip]	 # tmp161,
	vfmadd132ps	ymm0, ymm3, ymm2	 # tmp159, tmp161, tmp145
	vbroadcastss	ymm3, DWORD PTR .LC21[rip]	 # tmp164,
	vfmadd132ps	ymm0, ymm3, ymm2	 # tmp162, tmp164, tmp145
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vmulps	ymm3, ymm2, ymm2	 # _13, tmp145, tmp145
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vfmadd132ps	ymm0, ymm2, ymm3	 # tmp165, tmp145, _13
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:121:   return (__m256i) ((__v8su)__A + (__v8su)__B);
	vpcmpeqd	ymm2, ymm2, ymm2	 # tmp172
	vpsrld	ymm2, ymm2, 25	 # tmp171, tmp172,
	vpaddd	ymm1, ymm1, ymm2	 # _23, tmp167, tmp171
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:133:   return (__m256) ((__v8sf)__A + (__v8sf)__B);
	vbroadcastss	ymm2, DWORD PTR .LC24[rip]	 # tmp175,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:684:   return (__m256i)__builtin_ia32_pslldi256 ((__v8si)__A, __B);
	vpslld	ymm1, ymm1, 23	 # tmp168, _23,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:133:   return (__m256) ((__v8sf)__A + (__v8sf)__B);
	vaddps	ymm0, ymm0, ymm2	 # _20, tmp165, tmp175
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vmulps	ymm0, ymm0, ymm1	 # _27, _20, tmp168
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:25: KW __m256 avx2k_exp_ps   (__m256 x) { return avx2_exp_ps(x); }
	vmovups	YMMWORD PTR [rcx], ymm0	 # <retval>, _27
	vzeroupper
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:25: KW __m256 avx2k_exp_ps   (__m256 x) { return avx2_exp_ps(x); }
	ret	
	.seh_endproc
	.p2align 4
	.globl	avx2k_exp2_ps
	.def	avx2k_exp2_ps;	.scl	2;	.type	32;	.endef
	.seh_proc	avx2k_exp2_ps
avx2k_exp2_ps:
	.seh_endprologue
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:292:   return (__m256) __builtin_ia32_minps256 ((__v8sf)__A, (__v8sf)__B);
	vbroadcastss	ymm0, DWORD PTR .LC26[rip]	 # tmp124,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vbroadcastss	ymm3, DWORD PTR .LC13[rip]	 # tmp145,
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:26: KW __m256 avx2k_exp2_ps  (__m256 x) { return avx2_exp2_ps(x); }
	vmovups	ymm1, YMMWORD PTR [rdx]	 # x, x
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:292:   return (__m256) __builtin_ia32_minps256 ((__v8sf)__A, (__v8sf)__B);
	vminps	ymm1, ymm1, ymm0	 # _6, x, tmp124
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:280:   return (__m256) __builtin_ia32_maxps256 ((__v8sf)__A, (__v8sf)__B);
	vbroadcastss	ymm0, DWORD PTR .LC28[rip]	 # tmp131,
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:26: KW __m256 avx2k_exp2_ps  (__m256 x) { return avx2_exp2_ps(x); }
	mov	rax, rcx	 # .result_ptr, .result_ptr
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:280:   return (__m256) __builtin_ia32_maxps256 ((__v8sf)__A, (__v8sf)__B);
	vmaxps	ymm1, ymm1, ymm0	 # _8, _6, tmp131
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vbroadcastss	ymm0, DWORD PTR .LC30[rip]	 # tmp140,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:1010:   return (__m256) __builtin_ia32_roundps256 ((__v8sf)__V, __M);
	vroundps	ymm2, ymm1, 8	 # tmp137, _8,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:352:   return (__m256) ((__v8sf)__A - (__v8sf)__B);
	vsubps	ymm1, ymm1, ymm2	 # _10, _8, tmp137
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:443:   return (__m256i)__builtin_ia32_cvttps2dq256 ((__v8sf) __A);
	vcvttps2dq	ymm2, ymm2	 # tmp160, tmp137
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vmulps	ymm1, ymm1, ymm0	 # _11, _10, tmp140
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vbroadcastss	ymm0, DWORD PTR .LC11[rip]	 # tmp143,
	vfmadd132ps	ymm0, ymm3, ymm1	 # tmp141, tmp145, _11
	vbroadcastss	ymm3, DWORD PTR .LC15[rip]	 # tmp148,
	vfmadd132ps	ymm0, ymm3, ymm1	 # tmp146, tmp148, _11
	vbroadcastss	ymm3, DWORD PTR .LC17[rip]	 # tmp151,
	vfmadd132ps	ymm0, ymm3, ymm1	 # tmp149, tmp151, _11
	vbroadcastss	ymm3, DWORD PTR .LC19[rip]	 # tmp154,
	vfmadd132ps	ymm0, ymm3, ymm1	 # tmp152, tmp154, _11
	vbroadcastss	ymm3, DWORD PTR .LC21[rip]	 # tmp157,
	vfmadd132ps	ymm0, ymm3, ymm1	 # tmp155, tmp157, _11
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vmulps	ymm3, ymm1, ymm1	 # _12, _11, _11
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vfmadd132ps	ymm0, ymm1, ymm3	 # tmp158, _11, _12
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:121:   return (__m256i) ((__v8su)__A + (__v8su)__B);
	vpcmpeqd	ymm1, ymm1, ymm1	 # tmp165
	vpsrld	ymm1, ymm1, 25	 # tmp164, tmp165,
	vpaddd	ymm2, ymm2, ymm1	 # _22, tmp160, tmp164
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:133:   return (__m256) ((__v8sf)__A + (__v8sf)__B);
	vbroadcastss	ymm1, DWORD PTR .LC24[rip]	 # tmp168,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:684:   return (__m256i)__builtin_ia32_pslldi256 ((__v8si)__A, __B);
	vpslld	ymm2, ymm2, 23	 # tmp161, _22,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:133:   return (__m256) ((__v8sf)__A + (__v8sf)__B);
	vaddps	ymm0, ymm0, ymm1	 # _19, tmp158, tmp168
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vmulps	ymm0, ymm0, ymm2	 # _26, _19, tmp161
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:26: KW __m256 avx2k_exp2_ps  (__m256 x) { return avx2_exp2_ps(x); }
	vmovups	YMMWORD PTR [rcx], ymm0	 # <retval>, _26
	vzeroupper
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:26: KW __m256 avx2k_exp2_ps  (__m256 x) { return avx2_exp2_ps(x); }
	ret	
	.seh_endproc
	.p2align 4
	.globl	avx2k_exp10_ps
	.def	avx2k_exp10_ps;	.scl	2;	.type	32;	.endef
	.seh_proc	avx2k_exp10_ps
avx2k_exp10_ps:
	.seh_endprologue
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:292:   return (__m256) __builtin_ia32_minps256 ((__v8sf)__A, (__v8sf)__B);
	vbroadcastss	ymm1, DWORD PTR .LC32[rip]	 # tmp126,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:161:   return (__m256)__builtin_ia32_vfnmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vbroadcastss	ymm2, DWORD PTR .LC38[rip]	 # tmp145,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vbroadcastss	ymm3, DWORD PTR .LC13[rip]	 # tmp155,
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:27: KW __m256 avx2k_exp10_ps (__m256 x) { return avx2_exp10_ps(x); }
	vmovups	ymm0, YMMWORD PTR [rdx]	 # x, x
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:292:   return (__m256) __builtin_ia32_minps256 ((__v8sf)__A, (__v8sf)__B);
	vminps	ymm0, ymm0, ymm1	 # _6, x, tmp126
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:280:   return (__m256) __builtin_ia32_maxps256 ((__v8sf)__A, (__v8sf)__B);
	vbroadcastss	ymm1, DWORD PTR .LC34[rip]	 # tmp133,
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:27: KW __m256 avx2k_exp10_ps (__m256 x) { return avx2_exp10_ps(x); }
	mov	rax, rcx	 # .result_ptr, .result_ptr
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:280:   return (__m256) __builtin_ia32_maxps256 ((__v8sf)__A, (__v8sf)__B);
	vmaxps	ymm0, ymm0, ymm1	 # _8, _6, tmp133
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vbroadcastss	ymm1, DWORD PTR .LC36[rip]	 # tmp142,
	vmulps	ymm1, ymm0, ymm1	 # _9, _8, tmp142
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:1010:   return (__m256) __builtin_ia32_roundps256 ((__v8sf)__V, __M);
	vroundps	ymm1, ymm1, 8	 # tmp139, _9,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:161:   return (__m256)__builtin_ia32_vfnmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vfnmadd231ps	ymm0, ymm1, ymm2	 # tmp143, tmp139, tmp145
	vbroadcastss	ymm2, DWORD PTR .LC40[rip]	 # tmp148,
	vfnmadd132ps	ymm2, ymm0, ymm1	 # tmp146, tmp143, tmp139
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:443:   return (__m256i)__builtin_ia32_cvttps2dq256 ((__v8sf) __A);
	vcvttps2dq	ymm1, ymm1	 # tmp170, tmp139
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vbroadcastss	ymm0, DWORD PTR .LC42[rip]	 # tmp150,
	vmulps	ymm2, ymm2, ymm0	 # _13, tmp146, tmp150
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vbroadcastss	ymm0, DWORD PTR .LC11[rip]	 # tmp153,
	vfmadd132ps	ymm0, ymm3, ymm2	 # tmp151, tmp155, _13
	vbroadcastss	ymm3, DWORD PTR .LC15[rip]	 # tmp158,
	vfmadd132ps	ymm0, ymm3, ymm2	 # tmp156, tmp158, _13
	vbroadcastss	ymm3, DWORD PTR .LC17[rip]	 # tmp161,
	vfmadd132ps	ymm0, ymm3, ymm2	 # tmp159, tmp161, _13
	vbroadcastss	ymm3, DWORD PTR .LC19[rip]	 # tmp164,
	vfmadd132ps	ymm0, ymm3, ymm2	 # tmp162, tmp164, _13
	vbroadcastss	ymm3, DWORD PTR .LC21[rip]	 # tmp167,
	vfmadd132ps	ymm0, ymm3, ymm2	 # tmp165, tmp167, _13
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vmulps	ymm3, ymm2, ymm2	 # _14, _13, _13
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vfmadd132ps	ymm0, ymm2, ymm3	 # tmp168, _13, _14
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:121:   return (__m256i) ((__v8su)__A + (__v8su)__B);
	vpcmpeqd	ymm2, ymm2, ymm2	 # tmp175
	vpsrld	ymm2, ymm2, 25	 # tmp174, tmp175,
	vpaddd	ymm1, ymm1, ymm2	 # _24, tmp170, tmp174
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:133:   return (__m256) ((__v8sf)__A + (__v8sf)__B);
	vbroadcastss	ymm2, DWORD PTR .LC24[rip]	 # tmp178,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:684:   return (__m256i)__builtin_ia32_pslldi256 ((__v8si)__A, __B);
	vpslld	ymm1, ymm1, 23	 # tmp171, _24,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:133:   return (__m256) ((__v8sf)__A + (__v8sf)__B);
	vaddps	ymm0, ymm0, ymm2	 # _21, tmp168, tmp178
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vmulps	ymm0, ymm0, ymm1	 # _28, _21, tmp171
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:27: KW __m256 avx2k_exp10_ps (__m256 x) { return avx2_exp10_ps(x); }
	vmovups	YMMWORD PTR [rcx], ymm0	 # <retval>, _28
	vzeroupper
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:27: KW __m256 avx2k_exp10_ps (__m256 x) { return avx2_exp10_ps(x); }
	ret	
	.seh_endproc
	.p2align 4
	.globl	avx2k_expm1_ps
	.def	avx2k_expm1_ps;	.scl	2;	.type	32;	.endef
	.seh_proc	avx2k_expm1_ps
avx2k_expm1_ps:
	sub	rsp, 104	 #,
	.seh_stackalloc	104
	vmovups	XMMWORD PTR [rsp], xmm6	 #,
	.seh_savexmm	xmm6, 0
	vmovups	XMMWORD PTR 16[rsp], xmm7	 #,
	.seh_savexmm	xmm7, 16
	vmovups	XMMWORD PTR 32[rsp], xmm8	 #,
	.seh_savexmm	xmm8, 32
	vmovups	XMMWORD PTR 48[rsp], xmm9	 #,
	.seh_savexmm	xmm9, 48
	vmovups	XMMWORD PTR 64[rsp], xmm10	 #,
	.seh_savexmm	xmm10, 64
	vmovups	XMMWORD PTR 80[rsp], xmm11	 #,
	.seh_savexmm	xmm11, 80
	.seh_endprologue
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:292:   return (__m256) __builtin_ia32_minps256 ((__v8sf)__A, (__v8sf)__B);
	vbroadcastss	ymm7, DWORD PTR .LC44[rip]	 # tmp155,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vbroadcastss	ymm1, DWORD PTR .LC5[rip]	 # tmp164,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:161:   return (__m256)__builtin_ia32_vfnmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vbroadcastss	ymm0, DWORD PTR .LC7[rip]	 # tmp167,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vbroadcastss	ymm4, DWORD PTR .LC13[rip]	 # tmp175,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:352:   return (__m256) ((__v8sf)__A - (__v8sf)__B);
	vbroadcastss	ymm8, DWORD PTR .LC46[rip]	 # tmp198,
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:28: KW __m256 avx2k_expm1_ps (__m256 x) { return avx2_expm1_ps(x); }
	vmovups	ymm3, YMMWORD PTR [rdx]	 # x, x
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:170:   return (__m256) __builtin_ia32_andnps256 ((__v8sf)__A, (__v8sf)__B);
	vbroadcastss	ymm11, DWORD PTR .LC48[rip]	 # tmp209,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:292:   return (__m256) __builtin_ia32_minps256 ((__v8sf)__A, (__v8sf)__B);
	vminps	ymm2, ymm3, ymm7	 # _6, x, tmp155
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vcmpps	ymm10, ymm3, ymm7, 14	 # tmp216, x, tmp155,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:170:   return (__m256) __builtin_ia32_andnps256 ((__v8sf)__A, (__v8sf)__B);
	vandnps	ymm11, ymm11, ymm3	 # tmp207, tmp209, x
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vcmpps	ymm7, ymm3, ymm3, 3	 # tmp219, x, x,
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:28: KW __m256 avx2k_expm1_ps (__m256 x) { return avx2_expm1_ps(x); }
	mov	rax, rcx	 # .result_ptr, .result_ptr
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vmulps	ymm1, ymm2, ymm1	 # _7, _6, tmp164
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:1010:   return (__m256) __builtin_ia32_roundps256 ((__v8sf)__V, __M);
	vroundps	ymm1, ymm1, 8	 # tmp161, _7,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:161:   return (__m256)__builtin_ia32_vfnmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vfnmadd132ps	ymm0, ymm2, ymm1	 # tmp165, _6, tmp161
	vbroadcastss	ymm2, DWORD PTR .LC9[rip]	 # tmp170,
	vfnmadd132ps	ymm2, ymm0, ymm1	 # tmp168, tmp165, tmp161
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:443:   return (__m256i)__builtin_ia32_cvttps2dq256 ((__v8sf) __A);
	vcvttps2dq	ymm1, ymm1	 # tmp190, tmp161
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vbroadcastss	ymm0, DWORD PTR .LC11[rip]	 # tmp173,
	vfmadd132ps	ymm0, ymm4, ymm2	 # tmp171, tmp175, tmp168
	vbroadcastss	ymm4, DWORD PTR .LC15[rip]	 # tmp178,
	vfmadd132ps	ymm0, ymm4, ymm2	 # tmp176, tmp178, tmp168
	vbroadcastss	ymm4, DWORD PTR .LC17[rip]	 # tmp181,
	vfmadd132ps	ymm0, ymm4, ymm2	 # tmp179, tmp181, tmp168
	vbroadcastss	ymm4, DWORD PTR .LC19[rip]	 # tmp184,
	vfmadd132ps	ymm0, ymm4, ymm2	 # tmp182, tmp184, tmp168
	vbroadcastss	ymm4, DWORD PTR .LC21[rip]	 # tmp187,
	vfmadd132ps	ymm0, ymm4, ymm2	 # tmp185, tmp187, tmp168
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vmulps	ymm4, ymm2, ymm2	 # _11, tmp168, tmp168
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vfmadd132ps	ymm0, ymm2, ymm4	 # tmp188, tmp168, _11
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:121:   return (__m256i) ((__v8su)__A + (__v8su)__B);
	vpcmpeqd	ymm2, ymm2, ymm2	 # tmp193
	vpsrld	ymm9, ymm2, 25	 # tmp192, tmp193,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:275:   return (__m256i) ((__v8si)__A > (__v8si)__B);
	vpsrld	ymm2, ymm2, 26	 # tmp239, tmp193,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:121:   return (__m256i) ((__v8su)__A + (__v8su)__B);
	vpaddd	ymm6, ymm1, ymm9	 # _20, tmp190, tmp192
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:684:   return (__m256i)__builtin_ia32_pslldi256 ((__v8si)__A, __B);
	vpslld	ymm4, ymm6, 23	 # tmp194, _20,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:352:   return (__m256) ((__v8sf)__A - (__v8sf)__B);
	vaddps	ymm5, ymm8, ymm4	 # _24, tmp198, tmp194
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vfmadd132ps	ymm4, ymm5, ymm0	 # tmp195, _24, tmp188
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:726:   return (__m256i)__builtin_ia32_psradi256 ((__v8si)__A, __B);
	vpsrad	ymm5, ymm1, 1	 # tmp199, tmp190,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:275:   return (__m256i) ((__v8si)__A > (__v8si)__B);
	vpcmpgtd	ymm1, ymm1, ymm2	 # tmp241, tmp190, tmp239
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:121:   return (__m256i) ((__v8su)__A + (__v8su)__B);
	vpsubd	ymm6, ymm6, ymm5	 # _29, _20, tmp199
	vpaddd	ymm5, ymm5, ymm9	 # _33, tmp199, tmp192
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:133:   return (__m256) ((__v8sf)__A + (__v8sf)__B);
	vbroadcastss	ymm2, DWORD PTR .LC24[rip]	 # tmp245,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:684:   return (__m256i)__builtin_ia32_pslldi256 ((__v8si)__A, __B);
	vpslld	ymm6, ymm6, 23	 # tmp200, _29,
	vpslld	ymm5, ymm5, 23	 # tmp202, _33,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vbroadcastss	ymm9, DWORD PTR .LC50[rip]	 # tmp212,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:133:   return (__m256) ((__v8sf)__A + (__v8sf)__B);
	vaddps	ymm2, ymm0, ymm2	 # _37, tmp188, tmp245
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vcmpps	ymm11, ymm11, ymm9, 1	 # tmp210, tmp207, tmp212,
	vbroadcastss	ymm9, DWORD PTR .LC52[rip]	 # tmp215,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vmulps	ymm2, ymm2, ymm6	 # _38, _37, tmp200
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vcmpps	ymm9, ymm3, ymm9, 1	 # tmp213, x, tmp215,
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:28: KW __m256 avx2k_expm1_ps (__m256 x) { return avx2_expm1_ps(x); }
	vfmadd132ps	ymm5, ymm8, ymm2	 # tmp242, tmp198, _38
	vblendvps	ymm0, ymm4, ymm5, ymm1	 # tmp236, tmp195, tmp242, tmp241
	vbroadcastss	ymm1, DWORD PTR .LC55[rip]	 # tmp252,
	vblendvps	ymm0, ymm0, ymm3, ymm11	 # tmp232, tmp236, x, tmp210
	vblendvps	ymm0, ymm0, ymm8, ymm9	 # tmp228, tmp232, tmp198, tmp213
	vblendvps	ymm0, ymm0, ymm1, ymm10	 # tmp224, tmp228, tmp252, tmp216
	vblendvps	ymm0, ymm0, ymm3, ymm7	 # tmp220, tmp224, x, tmp219
	vmovups	YMMWORD PTR [rcx], ymm0	 # <retval>, tmp220
	vzeroupper
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:28: KW __m256 avx2k_expm1_ps (__m256 x) { return avx2_expm1_ps(x); }
	vmovups	xmm6, XMMWORD PTR [rsp]	 #,
	vmovups	xmm7, XMMWORD PTR 16[rsp]	 #,
	vmovups	xmm8, XMMWORD PTR 32[rsp]	 #,
	vmovups	xmm9, XMMWORD PTR 48[rsp]	 #,
	vmovups	xmm10, XMMWORD PTR 64[rsp]	 #,
	vmovups	xmm11, XMMWORD PTR 80[rsp]	 #,
	add	rsp, 104	 #,
	ret	
	.seh_endproc
	.p2align 4
	.globl	avx2k_log_ps
	.def	avx2k_log_ps;	.scl	2;	.type	32;	.endef
	.seh_proc	avx2k_log_ps
avx2k_log_ps:
	sub	rsp, 24	 #,
	.seh_stackalloc	24
	vmovups	XMMWORD PTR [rsp], xmm6	 #,
	.seh_savexmm	xmm6, 0
	.seh_endprologue
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vxorps	xmm2, xmm2, xmm2	 # tmp136
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:280:   return (__m256) __builtin_ia32_maxps256 ((__v8sf)__A, (__v8sf)__B);
	vbroadcastss	ymm1, DWORD PTR .LC57[rip]	 # tmp138,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:316:   return (__m256) __builtin_ia32_orps256 ((__v8sf)__A, (__v8sf)__B);
	vbroadcastss	ymm4, DWORD PTR .LC21[rip]	 # tmp150,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:158:   return (__m256) __builtin_ia32_andps256 ((__v8sf)__A, (__v8sf)__B);
	vbroadcastss	ymm5, DWORD PTR .LC24[rip]	 # tmp162,
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:29: KW __m256 avx2k_log_ps   (__m256 x) { return avx2_log_ps(x); }
	vmovups	ymm0, YMMWORD PTR [rdx]	 # x, x
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:817:   return (__m256i) ((__v8su)__A - (__v8su)__B);
	mov	edx, -127	 # tmp155,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vcmpps	ymm2, ymm0, ymm2, 2	 # tmp135, x, tmp136,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:280:   return (__m256) __builtin_ia32_maxps256 ((__v8sf)__A, (__v8sf)__B);
	vmaxps	ymm0, ymm0, ymm1	 # _7, x, tmp138
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:158:   return (__m256) __builtin_ia32_andps256 ((__v8sf)__A, (__v8sf)__B);
	vbroadcastss	ymm1, DWORD PTR .LC59[rip]	 # tmp147,
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:29: KW __m256 avx2k_log_ps   (__m256 x) { return avx2_log_ps(x); }
	mov	rax, rcx	 # .result_ptr, .result_ptr
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:775:   return (__m256i)__builtin_ia32_psrldi256 ((__v8si)__A, __B);
	vpsrld	ymm3, ymm0, 23	 # tmp144, _7,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:158:   return (__m256) __builtin_ia32_andps256 ((__v8sf)__A, (__v8sf)__B);
	vandps	ymm0, ymm0, ymm1	 # tmp145, _7, tmp147
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:817:   return (__m256i) ((__v8su)__A - (__v8su)__B);
	vmovd	xmm1, edx	 # tmp154, tmp155
	vpbroadcastd	ymm1, xmm1	 # tmp154, tmp154
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:316:   return (__m256) __builtin_ia32_orps256 ((__v8sf)__A, (__v8sf)__B);
	vorps	ymm0, ymm0, ymm4	 # tmp148, tmp145, tmp150
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:817:   return (__m256i) ((__v8su)__A - (__v8su)__B);
	vpaddd	ymm3, ymm3, ymm1	 # _13, tmp144, tmp154
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vbroadcastss	ymm1, DWORD PTR .LC62[rip]	 # tmp158,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:407:   return (__m256)__builtin_ia32_cvtdq2ps256 ((__v8si) __A);
	vcvtdq2ps	ymm3, ymm3	 # tmp151, _13
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:133:   return (__m256) ((__v8sf)__A + (__v8sf)__B);
	vaddps	ymm3, ymm3, ymm5	 # _16, tmp151, tmp162
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vcmpps	ymm1, ymm0, ymm1, 1	 # tmp156, tmp148, tmp158,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:158:   return (__m256) __builtin_ia32_andps256 ((__v8sf)__A, (__v8sf)__B);
	vandps	ymm6, ymm0, ymm1	 # tmp159, tmp148, tmp156
	vandps	ymm1, ymm5, ymm1	 # tmp160, tmp162, tmp156
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:352:   return (__m256) ((__v8sf)__A - (__v8sf)__B);
	vsubps	ymm3, ymm3, ymm1	 # _21, _16, tmp160
	vbroadcastss	ymm1, DWORD PTR .LC46[rip]	 # tmp168,
	vaddps	ymm0, ymm0, ymm1	 # _19, tmp148, tmp168
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vbroadcastss	ymm1, DWORD PTR .LC64[rip]	 # tmp171,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:133:   return (__m256) ((__v8sf)__A + (__v8sf)__B);
	vaddps	ymm0, ymm0, ymm6	 # _22, _19, tmp159
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vbroadcastss	ymm6, DWORD PTR .LC66[rip]	 # tmp173,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vmulps	ymm5, ymm0, ymm0	 # _23, _22, _22
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vfmadd132ps	ymm1, ymm6, ymm0	 # tmp169, tmp173, _22
	vbroadcastss	ymm6, DWORD PTR .LC68[rip]	 # tmp176,
	vfmadd132ps	ymm1, ymm6, ymm0	 # tmp174, tmp176, _22
	vbroadcastss	ymm6, DWORD PTR .LC70[rip]	 # tmp179,
	vfmadd132ps	ymm1, ymm6, ymm0	 # tmp177, tmp179, _22
	vbroadcastss	ymm6, DWORD PTR .LC72[rip]	 # tmp182,
	vfmadd132ps	ymm1, ymm6, ymm0	 # tmp180, tmp182, _22
	vbroadcastss	ymm6, DWORD PTR .LC74[rip]	 # tmp185,
	vfmadd132ps	ymm1, ymm6, ymm0	 # tmp183, tmp185, _22
	vbroadcastss	ymm6, DWORD PTR .LC76[rip]	 # tmp188,
	vfmadd132ps	ymm1, ymm6, ymm0	 # tmp186, tmp188, _22
	vbroadcastss	ymm6, DWORD PTR .LC78[rip]	 # tmp191,
	vfmadd132ps	ymm1, ymm6, ymm0	 # tmp189, tmp191, _22
	vbroadcastss	ymm6, DWORD PTR .LC80[rip]	 # tmp194,
	vfmadd132ps	ymm1, ymm6, ymm0	 # tmp192, tmp194, _22
	vbroadcastss	ymm6, DWORD PTR .LC9[rip]	 # tmp197,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vmulps	ymm1, ymm0, ymm1	 # _32, _22, tmp192
	vmulps	ymm1, ymm1, ymm5	 # _33, _32, _23
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vfmadd231ps	ymm1, ymm3, ymm6	 # tmp195, _21, tmp197
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:161:   return (__m256)__builtin_ia32_vfnmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vfnmadd132ps	ymm5, ymm1, ymm4	 # tmp200, tmp195, tmp150
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vbroadcastss	ymm1, DWORD PTR .LC7[rip]	 # tmp205,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:133:   return (__m256) ((__v8sf)__A + (__v8sf)__B);
	vaddps	ymm0, ymm0, ymm5	 # _36, _22, tmp200
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vfmadd132ps	ymm3, ymm0, ymm1	 # tmp203, _36, tmp205
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:316:   return (__m256) __builtin_ia32_orps256 ((__v8sf)__A, (__v8sf)__B);
	vorps	ymm3, ymm3, ymm2	 # tmp207, tmp203, tmp135
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:29: KW __m256 avx2k_log_ps   (__m256 x) { return avx2_log_ps(x); }
	vmovups	YMMWORD PTR [rcx], ymm3	 # <retval>, tmp207
	vzeroupper
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:29: KW __m256 avx2k_log_ps   (__m256 x) { return avx2_log_ps(x); }
	vmovups	xmm6, XMMWORD PTR [rsp]	 #,
	add	rsp, 24	 #,
	ret	
	.seh_endproc
	.p2align 4
	.globl	avx2k_log2_ps
	.def	avx2k_log2_ps;	.scl	2;	.type	32;	.endef
	.seh_proc	avx2k_log2_ps
avx2k_log2_ps:
	sub	rsp, 56	 #,
	.seh_stackalloc	56
	vmovups	XMMWORD PTR [rsp], xmm6	 #,
	.seh_savexmm	xmm6, 0
	vmovups	XMMWORD PTR 16[rsp], xmm7	 #,
	.seh_savexmm	xmm7, 16
	vmovups	XMMWORD PTR 32[rsp], xmm8	 #,
	.seh_savexmm	xmm8, 32
	.seh_endprologue
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vxorps	xmm5, xmm5, xmm5	 # tmp135
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:280:   return (__m256) __builtin_ia32_maxps256 ((__v8sf)__A, (__v8sf)__B);
	vbroadcastss	ymm1, DWORD PTR .LC57[rip]	 # tmp137,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:316:   return (__m256) __builtin_ia32_orps256 ((__v8sf)__A, (__v8sf)__B);
	vbroadcastss	ymm7, DWORD PTR .LC21[rip]	 # tmp149,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vbroadcastss	ymm3, DWORD PTR .LC62[rip]	 # tmp157,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:352:   return (__m256) ((__v8sf)__A - (__v8sf)__B);
	vbroadcastss	ymm4, DWORD PTR .LC46[rip]	 # tmp164,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vbroadcastss	ymm8, DWORD PTR .LC66[rip]	 # tmp169,
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:30: KW __m256 avx2k_log2_ps  (__m256 x) { return avx2_log2_ps(x); }
	vmovups	ymm0, YMMWORD PTR [rdx]	 # x, x
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:817:   return (__m256i) ((__v8su)__A - (__v8su)__B);
	mov	edx, -127	 # tmp154,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:158:   return (__m256) __builtin_ia32_andps256 ((__v8sf)__A, (__v8sf)__B);
	vbroadcastss	ymm6, DWORD PTR .LC24[rip]	 # tmp161,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vcmpps	ymm5, ymm0, ymm5, 2	 # tmp134, x, tmp135,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:280:   return (__m256) __builtin_ia32_maxps256 ((__v8sf)__A, (__v8sf)__B);
	vmaxps	ymm0, ymm0, ymm1	 # _14, x, tmp137
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:158:   return (__m256) __builtin_ia32_andps256 ((__v8sf)__A, (__v8sf)__B);
	vbroadcastss	ymm1, DWORD PTR .LC59[rip]	 # tmp146,
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:30: KW __m256 avx2k_log2_ps  (__m256 x) { return avx2_log2_ps(x); }
	mov	rax, rcx	 # .result_ptr, .result_ptr
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:775:   return (__m256i)__builtin_ia32_psrldi256 ((__v8si)__A, __B);
	vpsrld	ymm2, ymm0, 23	 # tmp143, _14,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:158:   return (__m256) __builtin_ia32_andps256 ((__v8sf)__A, (__v8sf)__B);
	vandps	ymm0, ymm0, ymm1	 # tmp144, _14, tmp146
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:817:   return (__m256i) ((__v8su)__A - (__v8su)__B);
	vmovd	xmm1, edx	 # tmp153, tmp154
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:316:   return (__m256) __builtin_ia32_orps256 ((__v8sf)__A, (__v8sf)__B);
	vorps	ymm0, ymm0, ymm7	 # tmp147, tmp144, tmp149
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:817:   return (__m256i) ((__v8su)__A - (__v8su)__B);
	vpbroadcastd	ymm1, xmm1	 # tmp153, tmp153
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vcmpps	ymm3, ymm0, ymm3, 1	 # tmp155, tmp147, tmp157,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:817:   return (__m256i) ((__v8su)__A - (__v8su)__B);
	vpaddd	ymm2, ymm2, ymm1	 # _20, tmp143, tmp153
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:407:   return (__m256)__builtin_ia32_cvtdq2ps256 ((__v8si) __A);
	vcvtdq2ps	ymm2, ymm2	 # tmp150, _20
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:133:   return (__m256) ((__v8sf)__A + (__v8sf)__B);
	vaddps	ymm2, ymm2, ymm6	 # _23, tmp150, tmp161
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:158:   return (__m256) __builtin_ia32_andps256 ((__v8sf)__A, (__v8sf)__B);
	vandps	ymm1, ymm0, ymm3	 # tmp158, tmp147, tmp155
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:352:   return (__m256) ((__v8sf)__A - (__v8sf)__B);
	vaddps	ymm0, ymm0, ymm4	 # _26, tmp147, tmp164
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:158:   return (__m256) __builtin_ia32_andps256 ((__v8sf)__A, (__v8sf)__B);
	vandps	ymm3, ymm6, ymm3	 # tmp159, tmp161, tmp155
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:352:   return (__m256) ((__v8sf)__A - (__v8sf)__B);
	vsubps	ymm2, ymm2, ymm3	 # _28, _23, tmp159
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:133:   return (__m256) ((__v8sf)__A + (__v8sf)__B);
	vaddps	ymm0, ymm0, ymm1	 # _29, _26, tmp158
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vbroadcastss	ymm1, DWORD PTR .LC64[rip]	 # tmp167,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vmulps	ymm4, ymm0, ymm0	 # _30, _29, _29
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vfmadd132ps	ymm1, ymm8, ymm0	 # tmp165, tmp169, _29
	vbroadcastss	ymm8, DWORD PTR .LC68[rip]	 # tmp172,
	vfmadd132ps	ymm1, ymm8, ymm0	 # tmp170, tmp172, _29
	vbroadcastss	ymm8, DWORD PTR .LC70[rip]	 # tmp175,
	vfmadd132ps	ymm1, ymm8, ymm0	 # tmp173, tmp175, _29
	vbroadcastss	ymm8, DWORD PTR .LC72[rip]	 # tmp178,
	vfmadd132ps	ymm1, ymm8, ymm0	 # tmp176, tmp178, _29
	vbroadcastss	ymm8, DWORD PTR .LC74[rip]	 # tmp181,
	vfmadd132ps	ymm1, ymm8, ymm0	 # tmp179, tmp181, _29
	vbroadcastss	ymm8, DWORD PTR .LC76[rip]	 # tmp184,
	vfmadd132ps	ymm1, ymm8, ymm0	 # tmp182, tmp184, _29
	vbroadcastss	ymm8, DWORD PTR .LC78[rip]	 # tmp187,
	vfmadd132ps	ymm1, ymm8, ymm0	 # tmp185, tmp187, _29
	vbroadcastss	ymm8, DWORD PTR .LC80[rip]	 # tmp190,
	vfmadd132ps	ymm1, ymm8, ymm0	 # tmp188, tmp190, _29
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vmulps	ymm1, ymm0, ymm1	 # _39, _29, tmp188
	vmulps	ymm1, ymm1, ymm4	 # _40, _39, _30
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:161:   return (__m256)__builtin_ia32_vfnmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vfnmadd132ps	ymm4, ymm1, ymm7	 # tmp191, _40, tmp149
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vbroadcastss	ymm1, DWORD PTR .LC5[rip]	 # tmp199,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:133:   return (__m256) ((__v8sf)__A + (__v8sf)__B);
	vaddps	ymm0, ymm0, ymm4	 # _42, _29, tmp191
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vfmadd132ps	ymm0, ymm2, ymm1	 # tmp196, _28, tmp199
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:316:   return (__m256) __builtin_ia32_orps256 ((__v8sf)__A, (__v8sf)__B);
	vorps	ymm0, ymm0, ymm5	 # tmp204, tmp196, tmp134
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:30: KW __m256 avx2k_log2_ps  (__m256 x) { return avx2_log2_ps(x); }
	vmovups	YMMWORD PTR [rcx], ymm0	 # <retval>, tmp204
	vzeroupper
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:30: KW __m256 avx2k_log2_ps  (__m256 x) { return avx2_log2_ps(x); }
	vmovups	xmm6, XMMWORD PTR [rsp]	 #,
	vmovups	xmm7, XMMWORD PTR 16[rsp]	 #,
	vmovups	xmm8, XMMWORD PTR 32[rsp]	 #,
	add	rsp, 56	 #,
	ret	
	.seh_endproc
	.p2align 4
	.globl	avx2k_log10_ps
	.def	avx2k_log10_ps;	.scl	2;	.type	32;	.endef
	.seh_proc	avx2k_log10_ps
avx2k_log10_ps:
	sub	rsp, 56	 #,
	.seh_stackalloc	56
	vmovups	XMMWORD PTR [rsp], xmm6	 #,
	.seh_savexmm	xmm6, 0
	vmovups	XMMWORD PTR 16[rsp], xmm7	 #,
	.seh_savexmm	xmm7, 16
	vmovups	XMMWORD PTR 32[rsp], xmm8	 #,
	.seh_savexmm	xmm8, 32
	.seh_endprologue
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vxorps	xmm5, xmm5, xmm5	 # tmp136
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:280:   return (__m256) __builtin_ia32_maxps256 ((__v8sf)__A, (__v8sf)__B);
	vbroadcastss	ymm1, DWORD PTR .LC57[rip]	 # tmp138,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:316:   return (__m256) __builtin_ia32_orps256 ((__v8sf)__A, (__v8sf)__B);
	vbroadcastss	ymm7, DWORD PTR .LC21[rip]	 # tmp150,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vbroadcastss	ymm3, DWORD PTR .LC62[rip]	 # tmp158,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:352:   return (__m256) ((__v8sf)__A - (__v8sf)__B);
	vbroadcastss	ymm4, DWORD PTR .LC46[rip]	 # tmp165,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vbroadcastss	ymm8, DWORD PTR .LC66[rip]	 # tmp170,
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:31: KW __m256 avx2k_log10_ps (__m256 x) { return avx2_log10_ps(x); }
	vmovups	ymm0, YMMWORD PTR [rdx]	 # x, x
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:817:   return (__m256i) ((__v8su)__A - (__v8su)__B);
	mov	edx, -127	 # tmp155,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:158:   return (__m256) __builtin_ia32_andps256 ((__v8sf)__A, (__v8sf)__B);
	vbroadcastss	ymm6, DWORD PTR .LC24[rip]	 # tmp162,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vcmpps	ymm5, ymm0, ymm5, 2	 # tmp135, x, tmp136,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:280:   return (__m256) __builtin_ia32_maxps256 ((__v8sf)__A, (__v8sf)__B);
	vmaxps	ymm0, ymm0, ymm1	 # _13, x, tmp138
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:158:   return (__m256) __builtin_ia32_andps256 ((__v8sf)__A, (__v8sf)__B);
	vbroadcastss	ymm1, DWORD PTR .LC59[rip]	 # tmp147,
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:31: KW __m256 avx2k_log10_ps (__m256 x) { return avx2_log10_ps(x); }
	mov	rax, rcx	 # .result_ptr, .result_ptr
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:775:   return (__m256i)__builtin_ia32_psrldi256 ((__v8si)__A, __B);
	vpsrld	ymm2, ymm0, 23	 # tmp144, _13,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:158:   return (__m256) __builtin_ia32_andps256 ((__v8sf)__A, (__v8sf)__B);
	vandps	ymm0, ymm0, ymm1	 # tmp145, _13, tmp147
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:817:   return (__m256i) ((__v8su)__A - (__v8su)__B);
	vmovd	xmm1, edx	 # tmp154, tmp155
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:316:   return (__m256) __builtin_ia32_orps256 ((__v8sf)__A, (__v8sf)__B);
	vorps	ymm0, ymm0, ymm7	 # tmp148, tmp145, tmp150
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:817:   return (__m256i) ((__v8su)__A - (__v8su)__B);
	vpbroadcastd	ymm1, xmm1	 # tmp154, tmp154
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vcmpps	ymm3, ymm0, ymm3, 1	 # tmp156, tmp148, tmp158,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:817:   return (__m256i) ((__v8su)__A - (__v8su)__B);
	vpaddd	ymm2, ymm2, ymm1	 # _19, tmp144, tmp154
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:407:   return (__m256)__builtin_ia32_cvtdq2ps256 ((__v8si) __A);
	vcvtdq2ps	ymm2, ymm2	 # tmp151, _19
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:133:   return (__m256) ((__v8sf)__A + (__v8sf)__B);
	vaddps	ymm2, ymm2, ymm6	 # _22, tmp151, tmp162
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:158:   return (__m256) __builtin_ia32_andps256 ((__v8sf)__A, (__v8sf)__B);
	vandps	ymm1, ymm0, ymm3	 # tmp159, tmp148, tmp156
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:352:   return (__m256) ((__v8sf)__A - (__v8sf)__B);
	vaddps	ymm0, ymm0, ymm4	 # _25, tmp148, tmp165
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:158:   return (__m256) __builtin_ia32_andps256 ((__v8sf)__A, (__v8sf)__B);
	vandps	ymm3, ymm6, ymm3	 # tmp160, tmp162, tmp156
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:352:   return (__m256) ((__v8sf)__A - (__v8sf)__B);
	vsubps	ymm2, ymm2, ymm3	 # _27, _22, tmp160
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:133:   return (__m256) ((__v8sf)__A + (__v8sf)__B);
	vaddps	ymm0, ymm0, ymm1	 # _28, _25, tmp159
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vbroadcastss	ymm1, DWORD PTR .LC64[rip]	 # tmp168,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vmulps	ymm4, ymm0, ymm0	 # _29, _28, _28
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vfmadd132ps	ymm1, ymm8, ymm0	 # tmp166, tmp170, _28
	vbroadcastss	ymm8, DWORD PTR .LC68[rip]	 # tmp173,
	vfmadd132ps	ymm1, ymm8, ymm0	 # tmp171, tmp173, _28
	vbroadcastss	ymm8, DWORD PTR .LC70[rip]	 # tmp176,
	vfmadd132ps	ymm1, ymm8, ymm0	 # tmp174, tmp176, _28
	vbroadcastss	ymm8, DWORD PTR .LC72[rip]	 # tmp179,
	vfmadd132ps	ymm1, ymm8, ymm0	 # tmp177, tmp179, _28
	vbroadcastss	ymm8, DWORD PTR .LC74[rip]	 # tmp182,
	vfmadd132ps	ymm1, ymm8, ymm0	 # tmp180, tmp182, _28
	vbroadcastss	ymm8, DWORD PTR .LC76[rip]	 # tmp185,
	vfmadd132ps	ymm1, ymm8, ymm0	 # tmp183, tmp185, _28
	vbroadcastss	ymm8, DWORD PTR .LC78[rip]	 # tmp188,
	vfmadd132ps	ymm1, ymm8, ymm0	 # tmp186, tmp188, _28
	vbroadcastss	ymm8, DWORD PTR .LC80[rip]	 # tmp191,
	vfmadd132ps	ymm1, ymm8, ymm0	 # tmp189, tmp191, _28
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vmulps	ymm1, ymm0, ymm1	 # _38, _28, tmp189
	vmulps	ymm1, ymm1, ymm4	 # _39, _38, _29
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:161:   return (__m256)__builtin_ia32_vfnmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vfnmadd132ps	ymm4, ymm1, ymm7	 # tmp192, _39, tmp150
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vbroadcastss	ymm1, DWORD PTR .LC84[rip]	 # tmp207,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:133:   return (__m256) ((__v8sf)__A + (__v8sf)__B);
	vaddps	ymm0, ymm0, ymm4	 # _41, _28, tmp192
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vmulps	ymm0, ymm0, ymm1	 # _6, _41, tmp207
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vbroadcastss	ymm1, DWORD PTR .LC82[rip]	 # tmp203,
	vfmadd132ps	ymm2, ymm0, ymm1	 # tmp197, _6, tmp203
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:316:   return (__m256) __builtin_ia32_orps256 ((__v8sf)__A, (__v8sf)__B);
	vorps	ymm2, ymm2, ymm5	 # tmp208, tmp197, tmp135
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:31: KW __m256 avx2k_log10_ps (__m256 x) { return avx2_log10_ps(x); }
	vmovups	YMMWORD PTR [rcx], ymm2	 # <retval>, tmp208
	vzeroupper
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:31: KW __m256 avx2k_log10_ps (__m256 x) { return avx2_log10_ps(x); }
	vmovups	xmm6, XMMWORD PTR [rsp]	 #,
	vmovups	xmm7, XMMWORD PTR 16[rsp]	 #,
	vmovups	xmm8, XMMWORD PTR 32[rsp]	 #,
	add	rsp, 56	 #,
	ret	
	.seh_endproc
	.p2align 4
	.globl	avx2k_log1p_ps
	.def	avx2k_log1p_ps;	.scl	2;	.type	32;	.endef
	.seh_proc	avx2k_log1p_ps
avx2k_log1p_ps:
	sub	rsp, 88	 #,
	.seh_stackalloc	88
	vmovups	XMMWORD PTR [rsp], xmm6	 #,
	.seh_savexmm	xmm6, 0
	vmovups	XMMWORD PTR 16[rsp], xmm7	 #,
	.seh_savexmm	xmm7, 16
	vmovups	XMMWORD PTR 32[rsp], xmm8	 #,
	.seh_savexmm	xmm8, 32
	vmovups	XMMWORD PTR 48[rsp], xmm9	 #,
	.seh_savexmm	xmm9, 48
	vmovups	XMMWORD PTR 64[rsp], xmm10	 #,
	.seh_savexmm	xmm10, 64
	.seh_endprologue
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vxorps	xmm8, xmm8, xmm8	 # tmp158
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:133:   return (__m256) ((__v8sf)__A + (__v8sf)__B);
	vbroadcastss	ymm5, DWORD PTR .LC24[rip]	 # tmp156,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:280:   return (__m256) __builtin_ia32_maxps256 ((__v8sf)__A, (__v8sf)__B);
	vbroadcastss	ymm0, DWORD PTR .LC57[rip]	 # tmp160,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:158:   return (__m256) __builtin_ia32_andps256 ((__v8sf)__A, (__v8sf)__B);
	vbroadcastss	ymm1, DWORD PTR .LC59[rip]	 # tmp169,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:316:   return (__m256) __builtin_ia32_orps256 ((__v8sf)__A, (__v8sf)__B);
	vbroadcastss	ymm9, DWORD PTR .LC21[rip]	 # tmp172,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:352:   return (__m256) ((__v8sf)__A - (__v8sf)__B);
	vbroadcastss	ymm6, DWORD PTR .LC46[rip]	 # tmp190,
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:32: KW __m256 avx2k_log1p_ps (__m256 x) { return avx2_log1p_ps(x); }
	vmovups	ymm4, YMMWORD PTR [rdx]	 # x, x
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:817:   return (__m256i) ((__v8su)__A - (__v8su)__B);
	mov	edx, -127	 # tmp177,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vbroadcastss	ymm10, DWORD PTR .LC66[rip]	 # tmp195,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:133:   return (__m256) ((__v8sf)__A + (__v8sf)__B);
	vaddps	ymm2, ymm4, ymm5	 # _5, x, tmp156
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:32: KW __m256 avx2k_log1p_ps (__m256 x) { return avx2_log1p_ps(x); }
	mov	rax, rcx	 # .result_ptr, .result_ptr
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:280:   return (__m256) __builtin_ia32_maxps256 ((__v8sf)__A, (__v8sf)__B);
	vmaxps	ymm0, ymm2, ymm0	 # _28, _5, tmp160
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vcmpps	ymm8, ymm2, ymm8, 2	 # tmp157, _5, tmp158,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:775:   return (__m256i)__builtin_ia32_psrldi256 ((__v8si)__A, __B);
	vpsrld	ymm3, ymm0, 23	 # tmp166, _28,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:158:   return (__m256) __builtin_ia32_andps256 ((__v8sf)__A, (__v8sf)__B);
	vandps	ymm0, ymm0, ymm1	 # tmp167, _28, tmp169
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:817:   return (__m256i) ((__v8su)__A - (__v8su)__B);
	vmovd	xmm1, edx	 # tmp176, tmp177
	vpbroadcastd	ymm1, xmm1	 # tmp176, tmp176
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:316:   return (__m256) __builtin_ia32_orps256 ((__v8sf)__A, (__v8sf)__B);
	vorps	ymm0, ymm0, ymm9	 # tmp170, tmp167, tmp172
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:817:   return (__m256i) ((__v8su)__A - (__v8su)__B);
	vpaddd	ymm3, ymm3, ymm1	 # _34, tmp166, tmp176
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vbroadcastss	ymm1, DWORD PTR .LC62[rip]	 # tmp180,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:407:   return (__m256)__builtin_ia32_cvtdq2ps256 ((__v8si) __A);
	vcvtdq2ps	ymm3, ymm3	 # tmp173, _34
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:133:   return (__m256) ((__v8sf)__A + (__v8sf)__B);
	vaddps	ymm3, ymm3, ymm5	 # _37, tmp173, tmp156
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vcmpps	ymm1, ymm0, ymm1, 1	 # tmp178, tmp170, tmp180,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:158:   return (__m256) __builtin_ia32_andps256 ((__v8sf)__A, (__v8sf)__B);
	vandps	ymm7, ymm0, ymm1	 # tmp181, tmp170, tmp178
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:352:   return (__m256) ((__v8sf)__A - (__v8sf)__B);
	vaddps	ymm0, ymm0, ymm6	 # _40, tmp170, tmp190
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:158:   return (__m256) __builtin_ia32_andps256 ((__v8sf)__A, (__v8sf)__B);
	vandps	ymm1, ymm5, ymm1	 # tmp182, tmp156, tmp178
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:352:   return (__m256) ((__v8sf)__A - (__v8sf)__B);
	vsubps	ymm3, ymm3, ymm1	 # _42, _37, tmp182
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vcmpps	ymm5, ymm2, ymm5, 0	 # tmp230, _5, tmp156,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vbroadcastss	ymm1, DWORD PTR .LC64[rip]	 # tmp193,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:133:   return (__m256) ((__v8sf)__A + (__v8sf)__B);
	vaddps	ymm0, ymm0, ymm7	 # _43, _40, tmp181
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vmulps	ymm7, ymm0, ymm0	 # _44, _43, _43
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vfmadd132ps	ymm1, ymm10, ymm0	 # tmp191, tmp195, _43
	vbroadcastss	ymm10, DWORD PTR .LC68[rip]	 # tmp198,
	vfmadd132ps	ymm1, ymm10, ymm0	 # tmp196, tmp198, _43
	vbroadcastss	ymm10, DWORD PTR .LC70[rip]	 # tmp201,
	vfmadd132ps	ymm1, ymm10, ymm0	 # tmp199, tmp201, _43
	vbroadcastss	ymm10, DWORD PTR .LC72[rip]	 # tmp204,
	vfmadd132ps	ymm1, ymm10, ymm0	 # tmp202, tmp204, _43
	vbroadcastss	ymm10, DWORD PTR .LC74[rip]	 # tmp207,
	vfmadd132ps	ymm1, ymm10, ymm0	 # tmp205, tmp207, _43
	vbroadcastss	ymm10, DWORD PTR .LC76[rip]	 # tmp210,
	vfmadd132ps	ymm1, ymm10, ymm0	 # tmp208, tmp210, _43
	vbroadcastss	ymm10, DWORD PTR .LC78[rip]	 # tmp213,
	vfmadd132ps	ymm1, ymm10, ymm0	 # tmp211, tmp213, _43
	vbroadcastss	ymm10, DWORD PTR .LC80[rip]	 # tmp216,
	vfmadd132ps	ymm1, ymm10, ymm0	 # tmp214, tmp216, _43
	vbroadcastss	ymm10, DWORD PTR .LC9[rip]	 # tmp219,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vmulps	ymm1, ymm0, ymm1	 # _53, _43, tmp214
	vmulps	ymm1, ymm1, ymm7	 # _54, _53, _44
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vfmadd231ps	ymm1, ymm3, ymm10	 # tmp217, _42, tmp219
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:161:   return (__m256)__builtin_ia32_vfnmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vfnmadd132ps	ymm7, ymm1, ymm9	 # tmp222, tmp217, tmp172
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vcmpps	ymm9, ymm4, ymm6, 0	 # tmp233, x, tmp190,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vbroadcastss	ymm1, DWORD PTR .LC7[rip]	 # tmp227,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:133:   return (__m256) ((__v8sf)__A + (__v8sf)__B);
	vaddps	ymm0, ymm0, ymm7	 # _57, _43, tmp222
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vfmadd132ps	ymm3, ymm0, ymm1	 # tmp225, _57, tmp227
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:352:   return (__m256) ((__v8sf)__A - (__v8sf)__B);
	vaddps	ymm0, ymm2, ymm6	 # _7, _5, tmp190
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vbroadcastss	ymm1, DWORD PTR .LC55[rip]	 # tmp241,
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:32: KW __m256 avx2k_log1p_ps (__m256 x) { return avx2_log1p_ps(x); }
	vbroadcastss	ymm2, DWORD PTR .LC86[rip]	 # tmp264,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vcmpps	ymm7, ymm4, ymm1, 0	 # tmp239, x, tmp241,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:227:   return (__m256) ((__v8sf)__A / (__v8sf)__B);
	vdivps	ymm0, ymm4, ymm0	 # _8, x, _7
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:316:   return (__m256) __builtin_ia32_orps256 ((__v8sf)__A, (__v8sf)__B);
	vorps	ymm3, ymm3, ymm8	 # tmp229, tmp225, tmp157
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vcmpps	ymm8, ymm4, ymm6, 1	 # tmp236, x, tmp190,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vmulps	ymm0, ymm0, ymm3	 # _9, _8, tmp229
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:32: KW __m256 avx2k_log1p_ps (__m256 x) { return avx2_log1p_ps(x); }
	vblendvps	ymm0, ymm0, ymm4, ymm5	 # tmp254, _9, x, tmp230
	vblendvps	ymm0, ymm0, ymm2, ymm9	 # tmp250, tmp254, tmp264, tmp233
	vbroadcastss	ymm2, DWORD PTR .LC88[rip]	 # tmp266,
	vblendvps	ymm0, ymm0, ymm2, ymm8	 # tmp246, tmp250, tmp266, tmp236
	vblendvps	ymm0, ymm0, ymm1, ymm7	 # tmp242, tmp246, tmp241, tmp239
	vmovups	YMMWORD PTR [rcx], ymm0	 # <retval>, tmp242
	vzeroupper
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:32: KW __m256 avx2k_log1p_ps (__m256 x) { return avx2_log1p_ps(x); }
	vmovups	xmm6, XMMWORD PTR [rsp]	 #,
	vmovups	xmm7, XMMWORD PTR 16[rsp]	 #,
	vmovups	xmm8, XMMWORD PTR 32[rsp]	 #,
	vmovups	xmm9, XMMWORD PTR 48[rsp]	 #,
	vmovups	xmm10, XMMWORD PTR 64[rsp]	 #,
	add	rsp, 88	 #,
	ret	
	.seh_endproc
	.p2align 4
	.globl	avx2k_tanh_ps
	.def	avx2k_tanh_ps;	.scl	2;	.type	32;	.endef
	.seh_proc	avx2k_tanh_ps
avx2k_tanh_ps:
	sub	rsp, 40	 #,
	.seh_stackalloc	40
	vmovups	XMMWORD PTR [rsp], xmm6	 #,
	.seh_savexmm	xmm6, 0
	vmovups	XMMWORD PTR 16[rsp], xmm7	 #,
	.seh_savexmm	xmm7, 16
	.seh_endprologue
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:352:   return (__m256) ((__v8sf)__A - (__v8sf)__B);
	vxorps	xmm0, xmm0, xmm0	 # tmp151
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:170:   return (__m256) __builtin_ia32_andnps256 ((__v8sf)__A, (__v8sf)__B);
	vbroadcastss	ymm5, DWORD PTR .LC48[rip]	 # tmp145,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:352:   return (__m256) ((__v8sf)__A - (__v8sf)__B);
	vbroadcastss	ymm6, DWORD PTR .LC90[rip]	 # tmp150,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:292:   return (__m256) __builtin_ia32_minps256 ((__v8sf)__A, (__v8sf)__B);
	vbroadcastss	ymm1, DWORD PTR .LC1[rip]	 # tmp153,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:161:   return (__m256)__builtin_ia32_vfnmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vbroadcastss	ymm3, DWORD PTR .LC7[rip]	 # tmp172,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vbroadcastss	ymm7, DWORD PTR .LC13[rip]	 # tmp180,
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:33: KW __m256 avx2k_tanh_ps  (__m256 x) { return avx2_tanh_ps(x); }
	vmovups	ymm2, YMMWORD PTR [rdx]	 # x, x
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:170:   return (__m256) __builtin_ia32_andnps256 ((__v8sf)__A, (__v8sf)__B);
	vandnps	ymm4, ymm5, ymm2	 # tmp143, tmp145, x
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:158:   return (__m256) __builtin_ia32_andps256 ((__v8sf)__A, (__v8sf)__B);
	vandps	ymm5, ymm5, ymm2	 # tmp146, tmp145, x
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:352:   return (__m256) ((__v8sf)__A - (__v8sf)__B);
	vfnmadd231ps	ymm0, ymm4, ymm6	 # _8, tmp143, tmp150
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:33: KW __m256 avx2k_tanh_ps  (__m256 x) { return avx2_tanh_ps(x); }
	mov	rax, rcx	 # .result_ptr, .result_ptr
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:292:   return (__m256) __builtin_ia32_minps256 ((__v8sf)__A, (__v8sf)__B);
	vminps	ymm0, ymm0, ymm1	 # _27, _8, tmp153
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:280:   return (__m256) __builtin_ia32_maxps256 ((__v8sf)__A, (__v8sf)__B);
	vbroadcastss	ymm1, DWORD PTR .LC3[rip]	 # tmp160,
	vmaxps	ymm0, ymm0, ymm1	 # _29, _27, tmp160
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vbroadcastss	ymm1, DWORD PTR .LC5[rip]	 # tmp169,
	vmulps	ymm1, ymm0, ymm1	 # _30, _29, tmp169
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:1010:   return (__m256) __builtin_ia32_roundps256 ((__v8sf)__V, __M);
	vroundps	ymm1, ymm1, 8	 # tmp166, _30,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:161:   return (__m256)__builtin_ia32_vfnmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vfnmadd231ps	ymm0, ymm1, ymm3	 # tmp170, tmp166, tmp172
	vbroadcastss	ymm3, DWORD PTR .LC9[rip]	 # tmp175,
	vfnmadd132ps	ymm3, ymm0, ymm1	 # tmp173, tmp170, tmp166
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:443:   return (__m256i)__builtin_ia32_cvttps2dq256 ((__v8sf) __A);
	vcvttps2dq	ymm1, ymm1	 # tmp195, tmp166
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vbroadcastss	ymm0, DWORD PTR .LC11[rip]	 # tmp178,
	vfmadd132ps	ymm0, ymm7, ymm3	 # tmp176, tmp180, tmp173
	vbroadcastss	ymm7, DWORD PTR .LC15[rip]	 # tmp183,
	vfmadd132ps	ymm0, ymm7, ymm3	 # tmp181, tmp183, tmp173
	vbroadcastss	ymm7, DWORD PTR .LC17[rip]	 # tmp186,
	vfmadd132ps	ymm0, ymm7, ymm3	 # tmp184, tmp186, tmp173
	vbroadcastss	ymm7, DWORD PTR .LC19[rip]	 # tmp189,
	vfmadd132ps	ymm0, ymm7, ymm3	 # tmp187, tmp189, tmp173
	vbroadcastss	ymm7, DWORD PTR .LC21[rip]	 # tmp192,
	vfmadd132ps	ymm0, ymm7, ymm3	 # tmp190, tmp192, tmp173
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vmulps	ymm7, ymm3, ymm3	 # _34, tmp173, tmp173
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vfmadd132ps	ymm0, ymm3, ymm7	 # tmp193, tmp173, _34
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:121:   return (__m256i) ((__v8su)__A + (__v8su)__B);
	vpcmpeqd	ymm3, ymm3, ymm3	 # tmp200
	vpsrld	ymm3, ymm3, 25	 # tmp199, tmp200,
	vpaddd	ymm1, ymm1, ymm3	 # _44, tmp195, tmp199
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:133:   return (__m256) ((__v8sf)__A + (__v8sf)__B);
	vbroadcastss	ymm3, DWORD PTR .LC24[rip]	 # tmp203,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:684:   return (__m256i)__builtin_ia32_pslldi256 ((__v8si)__A, __B);
	vpslld	ymm1, ymm1, 23	 # tmp196, _44,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:133:   return (__m256) ((__v8sf)__A + (__v8sf)__B);
	vaddps	ymm0, ymm0, ymm3	 # _41, tmp193, tmp203
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vmulps	ymm0, ymm0, ymm1	 # _48, _41, tmp196
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:133:   return (__m256) ((__v8sf)__A + (__v8sf)__B);
	vaddps	ymm1, ymm0, ymm3	 # _10, _48, tmp203
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:227:   return (__m256) ((__v8sf)__A / (__v8sf)__B);
	vdivps	ymm0, ymm0, ymm1	 # _11, _48, _10
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vmulps	ymm1, ymm2, ymm2	 # _14, x, x
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:161:   return (__m256)__builtin_ia32_vfnmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vfnmadd132ps	ymm6, ymm3, ymm0	 # tmp204, tmp203, _11
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vbroadcastss	ymm3, DWORD PTR .LC94[rip]	 # tmp218,
	vbroadcastss	ymm0, DWORD PTR .LC92[rip]	 # tmp216,
	vfmadd132ps	ymm0, ymm3, ymm1	 # tmp214, tmp218, _14
	vbroadcastss	ymm3, DWORD PTR .LC96[rip]	 # tmp221,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:316:   return (__m256) __builtin_ia32_orps256 ((__v8sf)__A, (__v8sf)__B);
	vorps	ymm6, ymm6, ymm5	 # tmp213, tmp204, tmp146
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vfmadd132ps	ymm0, ymm3, ymm1	 # tmp219, tmp221, _14
	vbroadcastss	ymm3, DWORD PTR .LC98[rip]	 # tmp224,
	vfmadd132ps	ymm0, ymm3, ymm1	 # tmp222, tmp224, _14
	vbroadcastss	ymm3, DWORD PTR .LC100[rip]	 # tmp227,
	vfmadd132ps	ymm0, ymm3, ymm1	 # tmp225, tmp227, _14
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vmulps	ymm1, ymm1, ymm0	 # _19, _14, tmp225
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vbroadcastss	ymm0, DWORD PTR .LC102[rip]	 # tmp233,
	vcmpps	ymm4, ymm4, ymm0, 1	 # tmp231, tmp143, tmp233,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vfmadd132ps	ymm2, ymm2, ymm1	 # tmp228, x, _19
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:316:   return (__m256) __builtin_ia32_orps256 ((__v8sf)__A, (__v8sf)__B);
	vorps	ymm2, ymm2, ymm5	 # tmp230, tmp228, tmp146
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:33: KW __m256 avx2k_tanh_ps  (__m256 x) { return avx2_tanh_ps(x); }
	vblendvps	ymm6, ymm6, ymm2, ymm4	 # tmp234, tmp213, tmp230, tmp231
	vmovups	YMMWORD PTR [rcx], ymm6	 # <retval>, tmp234
	vzeroupper
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:33: KW __m256 avx2k_tanh_ps  (__m256 x) { return avx2_tanh_ps(x); }
	vmovups	xmm6, XMMWORD PTR [rsp]	 #,
	vmovups	xmm7, XMMWORD PTR 16[rsp]	 #,
	add	rsp, 40	 #,
	ret	
	.seh_endproc
	.p2align 4
	.globl	avx2k_sigmoid_ps
	.def	avx2k_sigmoid_ps;	.scl	2;	.type	32;	.endef
	.seh_proc	avx2k_sigmoid_ps
avx2k_sigmoid_ps:
	.seh_endprologue
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vxorps	xmm0, xmm0, xmm0	 # tmp137
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:170:   return (__m256) __builtin_ia32_andnps256 ((__v8sf)__A, (__v8sf)__B);
	vbroadcastss	ymm1, DWORD PTR .LC48[rip]	 # tmp135,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:161:   return (__m256)__builtin_ia32_vfnmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vbroadcastss	ymm2, DWORD PTR .LC7[rip]	 # tmp159,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vbroadcastss	ymm4, DWORD PTR .LC13[rip]	 # tmp167,
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:34: KW __m256 avx2k_sigmoid_ps(__m256 x){ return avx2_sigmoid_ps(x); }
	vmovups	ymm3, YMMWORD PTR [rdx]	 # x, x
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:170:   return (__m256) __builtin_ia32_andnps256 ((__v8sf)__A, (__v8sf)__B);
	vandnps	ymm1, ymm1, ymm3	 # tmp133, tmp135, x
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vcmpps	ymm3, ymm3, ymm0, 1	 # tmp136, x, tmp137,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:352:   return (__m256) ((__v8sf)__A - (__v8sf)__B);
	vsubps	ymm0, ymm0, ymm1	 # _7, tmp137, tmp133
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:292:   return (__m256) __builtin_ia32_minps256 ((__v8sf)__A, (__v8sf)__B);
	vbroadcastss	ymm1, DWORD PTR .LC1[rip]	 # tmp140,
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:34: KW __m256 avx2k_sigmoid_ps(__m256 x){ return avx2_sigmoid_ps(x); }
	mov	rax, rcx	 # .result_ptr, .result_ptr
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:292:   return (__m256) __builtin_ia32_minps256 ((__v8sf)__A, (__v8sf)__B);
	vminps	ymm0, ymm0, ymm1	 # _16, _7, tmp140
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:280:   return (__m256) __builtin_ia32_maxps256 ((__v8sf)__A, (__v8sf)__B);
	vbroadcastss	ymm1, DWORD PTR .LC3[rip]	 # tmp147,
	vmaxps	ymm0, ymm0, ymm1	 # _18, _16, tmp147
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vbroadcastss	ymm1, DWORD PTR .LC5[rip]	 # tmp156,
	vmulps	ymm1, ymm0, ymm1	 # _19, _18, tmp156
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:1010:   return (__m256) __builtin_ia32_roundps256 ((__v8sf)__V, __M);
	vroundps	ymm1, ymm1, 8	 # tmp153, _19,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:161:   return (__m256)__builtin_ia32_vfnmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vfnmadd231ps	ymm0, ymm1, ymm2	 # tmp157, tmp153, tmp159
	vbroadcastss	ymm2, DWORD PTR .LC9[rip]	 # tmp162,
	vfnmadd132ps	ymm2, ymm0, ymm1	 # tmp160, tmp157, tmp153
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:443:   return (__m256i)__builtin_ia32_cvttps2dq256 ((__v8sf) __A);
	vcvttps2dq	ymm1, ymm1	 # tmp182, tmp153
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vbroadcastss	ymm0, DWORD PTR .LC11[rip]	 # tmp165,
	vfmadd132ps	ymm0, ymm4, ymm2	 # tmp163, tmp167, tmp160
	vbroadcastss	ymm4, DWORD PTR .LC15[rip]	 # tmp170,
	vfmadd132ps	ymm0, ymm4, ymm2	 # tmp168, tmp170, tmp160
	vbroadcastss	ymm4, DWORD PTR .LC17[rip]	 # tmp173,
	vfmadd132ps	ymm0, ymm4, ymm2	 # tmp171, tmp173, tmp160
	vbroadcastss	ymm4, DWORD PTR .LC19[rip]	 # tmp176,
	vfmadd132ps	ymm0, ymm4, ymm2	 # tmp174, tmp176, tmp160
	vbroadcastss	ymm4, DWORD PTR .LC21[rip]	 # tmp179,
	vfmadd132ps	ymm0, ymm4, ymm2	 # tmp177, tmp179, tmp160
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vmulps	ymm4, ymm2, ymm2	 # _23, tmp160, tmp160
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vfmadd132ps	ymm0, ymm2, ymm4	 # tmp180, tmp160, _23
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:121:   return (__m256i) ((__v8su)__A + (__v8su)__B);
	vpcmpeqd	ymm2, ymm2, ymm2	 # tmp187
	vpsrld	ymm2, ymm2, 25	 # tmp186, tmp187,
	vpaddd	ymm1, ymm1, ymm2	 # _33, tmp182, tmp186
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:133:   return (__m256) ((__v8sf)__A + (__v8sf)__B);
	vbroadcastss	ymm2, DWORD PTR .LC24[rip]	 # tmp190,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:684:   return (__m256i)__builtin_ia32_pslldi256 ((__v8si)__A, __B);
	vpslld	ymm1, ymm1, 23	 # tmp183, _33,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:133:   return (__m256) ((__v8sf)__A + (__v8sf)__B);
	vaddps	ymm0, ymm0, ymm2	 # _30, tmp180, tmp190
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vmulps	ymm0, ymm0, ymm1	 # _37, _30, tmp183
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:133:   return (__m256) ((__v8sf)__A + (__v8sf)__B);
	vaddps	ymm1, ymm0, ymm2	 # _9, _37, tmp190
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:227:   return (__m256) ((__v8sf)__A / (__v8sf)__B);
	vdivps	ymm0, ymm0, ymm1	 # _10, _37, _9
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:352:   return (__m256) ((__v8sf)__A - (__v8sf)__B);
	vsubps	ymm2, ymm2, ymm0	 # _11, tmp190, _10
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:34: KW __m256 avx2k_sigmoid_ps(__m256 x){ return avx2_sigmoid_ps(x); }
	vblendvps	ymm2, ymm2, ymm0, ymm3	 # tmp194, _11, _10, tmp136
	vmovups	YMMWORD PTR [rcx], ymm2	 # <retval>, tmp194
	vzeroupper
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:34: KW __m256 avx2k_sigmoid_ps(__m256 x){ return avx2_sigmoid_ps(x); }
	ret	
	.seh_endproc
	.p2align 4
	.globl	avx2k_pow_ps
	.def	avx2k_pow_ps;	.scl	2;	.type	32;	.endef
	.seh_proc	avx2k_pow_ps
avx2k_pow_ps:
	sub	rsp, 104	 #,
	.seh_stackalloc	104
	vmovups	XMMWORD PTR [rsp], xmm6	 #,
	.seh_savexmm	xmm6, 0
	vmovups	XMMWORD PTR 16[rsp], xmm7	 #,
	.seh_savexmm	xmm7, 16
	vmovups	XMMWORD PTR 32[rsp], xmm8	 #,
	.seh_savexmm	xmm8, 32
	vmovups	XMMWORD PTR 48[rsp], xmm9	 #,
	.seh_savexmm	xmm9, 48
	vmovups	XMMWORD PTR 64[rsp], xmm10	 #,
	.seh_savexmm	xmm10, 64
	vmovups	XMMWORD PTR 80[rsp], xmm11	 #,
	.seh_savexmm	xmm11, 80
	.seh_endprologue
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vxorps	xmm5, xmm5, xmm5	 # tmp186
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:280:   return (__m256) __builtin_ia32_maxps256 ((__v8sf)__A, (__v8sf)__B);
	vbroadcastss	ymm0, DWORD PTR .LC57[rip]	 # tmp188,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:158:   return (__m256) __builtin_ia32_andps256 ((__v8sf)__A, (__v8sf)__B);
	vbroadcastss	ymm1, DWORD PTR .LC59[rip]	 # tmp197,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:316:   return (__m256) __builtin_ia32_orps256 ((__v8sf)__A, (__v8sf)__B);
	vbroadcastss	ymm6, DWORD PTR .LC21[rip]	 # tmp200,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vbroadcastss	ymm9, DWORD PTR .LC62[rip]	 # tmp208,
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:35: KW __m256 avx2k_pow_ps   (__m256 a, __m256 b) { return avx2_pow_ps(a, b); }
	vmovups	ymm2, YMMWORD PTR [rdx]	 # a, a
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:817:   return (__m256i) ((__v8su)__A - (__v8su)__B);
	mov	edx, -127	 # tmp205,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:352:   return (__m256) ((__v8sf)__A - (__v8sf)__B);
	vbroadcastss	ymm10, DWORD PTR .LC46[rip]	 # tmp215,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vbroadcastss	ymm11, DWORD PTR .LC66[rip]	 # tmp220,
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:35: KW __m256 avx2k_pow_ps   (__m256 a, __m256 b) { return avx2_pow_ps(a, b); }
	vmovups	ymm3, YMMWORD PTR [r8]	 # b, b
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:280:   return (__m256) __builtin_ia32_maxps256 ((__v8sf)__A, (__v8sf)__B);
	vmaxps	ymm0, ymm2, ymm0	 # _63, a, tmp188
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vcmpps	ymm8, ymm2, ymm5, 2	 # tmp185, a, tmp186,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:158:   return (__m256) __builtin_ia32_andps256 ((__v8sf)__A, (__v8sf)__B);
	vbroadcastss	ymm4, DWORD PTR .LC24[rip]	 # tmp212,
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:35: KW __m256 avx2k_pow_ps   (__m256 a, __m256 b) { return avx2_pow_ps(a, b); }
	mov	rax, rcx	 # .result_ptr, .result_ptr
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:775:   return (__m256i)__builtin_ia32_psrldi256 ((__v8si)__A, __B);
	vpsrld	ymm7, ymm0, 23	 # tmp194, _63,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:158:   return (__m256) __builtin_ia32_andps256 ((__v8sf)__A, (__v8sf)__B);
	vandps	ymm0, ymm0, ymm1	 # tmp195, _63, tmp197
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:817:   return (__m256i) ((__v8su)__A - (__v8su)__B);
	vmovd	xmm1, edx	 # tmp204, tmp205
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:316:   return (__m256) __builtin_ia32_orps256 ((__v8sf)__A, (__v8sf)__B);
	vorps	ymm0, ymm0, ymm6	 # tmp198, tmp195, tmp200
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:817:   return (__m256i) ((__v8su)__A - (__v8su)__B);
	vpbroadcastd	ymm1, xmm1	 # tmp204, tmp204
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vcmpps	ymm9, ymm0, ymm9, 1	 # tmp206, tmp198, tmp208,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:817:   return (__m256i) ((__v8su)__A - (__v8su)__B);
	vpaddd	ymm7, ymm7, ymm1	 # _69, tmp194, tmp204
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:407:   return (__m256)__builtin_ia32_cvtdq2ps256 ((__v8si) __A);
	vcvtdq2ps	ymm7, ymm7	 # tmp201, _69
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:133:   return (__m256) ((__v8sf)__A + (__v8sf)__B);
	vaddps	ymm7, ymm7, ymm4	 # _72, tmp201, tmp212
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:158:   return (__m256) __builtin_ia32_andps256 ((__v8sf)__A, (__v8sf)__B);
	vandps	ymm1, ymm0, ymm9	 # tmp209, tmp198, tmp206
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:352:   return (__m256) ((__v8sf)__A - (__v8sf)__B);
	vaddps	ymm0, ymm0, ymm10	 # _75, tmp198, tmp215
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:158:   return (__m256) __builtin_ia32_andps256 ((__v8sf)__A, (__v8sf)__B);
	vandps	ymm9, ymm4, ymm9	 # tmp210, tmp212, tmp206
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:352:   return (__m256) ((__v8sf)__A - (__v8sf)__B);
	vsubps	ymm7, ymm7, ymm9	 # _77, _72, tmp210
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vcmpps	ymm9, ymm3, ymm5, 1	 # tmp310, b, tmp186,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:133:   return (__m256) ((__v8sf)__A + (__v8sf)__B);
	vaddps	ymm0, ymm0, ymm1	 # _78, _75, tmp209
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vbroadcastss	ymm1, DWORD PTR .LC64[rip]	 # tmp218,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vmulps	ymm10, ymm0, ymm0	 # _79, _78, _78
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vfmadd132ps	ymm1, ymm11, ymm0	 # tmp216, tmp220, _78
	vbroadcastss	ymm11, DWORD PTR .LC68[rip]	 # tmp223,
	vfmadd132ps	ymm1, ymm11, ymm0	 # tmp221, tmp223, _78
	vbroadcastss	ymm11, DWORD PTR .LC70[rip]	 # tmp226,
	vfmadd132ps	ymm1, ymm11, ymm0	 # tmp224, tmp226, _78
	vbroadcastss	ymm11, DWORD PTR .LC72[rip]	 # tmp229,
	vfmadd132ps	ymm1, ymm11, ymm0	 # tmp227, tmp229, _78
	vbroadcastss	ymm11, DWORD PTR .LC74[rip]	 # tmp232,
	vfmadd132ps	ymm1, ymm11, ymm0	 # tmp230, tmp232, _78
	vbroadcastss	ymm11, DWORD PTR .LC76[rip]	 # tmp235,
	vfmadd132ps	ymm1, ymm11, ymm0	 # tmp233, tmp235, _78
	vbroadcastss	ymm11, DWORD PTR .LC78[rip]	 # tmp238,
	vfmadd132ps	ymm1, ymm11, ymm0	 # tmp236, tmp238, _78
	vbroadcastss	ymm11, DWORD PTR .LC80[rip]	 # tmp241,
	vfmadd132ps	ymm1, ymm11, ymm0	 # tmp239, tmp241, _78
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vmulps	ymm1, ymm0, ymm1	 # _88, _78, tmp239
	vmulps	ymm1, ymm1, ymm10	 # _89, _88, _79
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:161:   return (__m256)__builtin_ia32_vfnmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vfnmadd132ps	ymm10, ymm1, ymm6	 # tmp242, _89, tmp200
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vbroadcastss	ymm1, DWORD PTR .LC5[rip]	 # tmp250,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:133:   return (__m256) ((__v8sf)__A + (__v8sf)__B);
	vaddps	ymm0, ymm0, ymm10	 # _91, _78, tmp242
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vcmpps	ymm10, ymm3, ymm3, 3	 # tmp314, b, b,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vfmadd132ps	ymm0, ymm7, ymm1	 # tmp247, _77, tmp250
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:292:   return (__m256) __builtin_ia32_minps256 ((__v8sf)__A, (__v8sf)__B);
	vbroadcastss	ymm1, DWORD PTR .LC26[rip]	 # tmp257,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:316:   return (__m256) __builtin_ia32_orps256 ((__v8sf)__A, (__v8sf)__B);
	vorps	ymm0, ymm0, ymm8	 # tmp255, tmp247, tmp185
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vbroadcastss	ymm8, DWORD PTR .LC13[rip]	 # tmp278,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vmulps	ymm0, ymm3, ymm0	 # _11, b, tmp255
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vcmpps	ymm3, ymm3, ymm5, 0	 # tmp320, b, tmp186,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:292:   return (__m256) __builtin_ia32_minps256 ((__v8sf)__A, (__v8sf)__B);
	vminps	ymm0, ymm0, ymm1	 # _40, _11, tmp257
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:280:   return (__m256) __builtin_ia32_maxps256 ((__v8sf)__A, (__v8sf)__B);
	vbroadcastss	ymm1, DWORD PTR .LC28[rip]	 # tmp264,
	vmaxps	ymm0, ymm0, ymm1	 # _42, _40, tmp264
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vbroadcastss	ymm1, DWORD PTR .LC30[rip]	 # tmp273,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:1010:   return (__m256) __builtin_ia32_roundps256 ((__v8sf)__V, __M);
	vroundps	ymm7, ymm0, 8	 # tmp270, _42,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:352:   return (__m256) ((__v8sf)__A - (__v8sf)__B);
	vsubps	ymm0, ymm0, ymm7	 # _44, _42, tmp270
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:443:   return (__m256i)__builtin_ia32_cvttps2dq256 ((__v8sf) __A);
	vcvttps2dq	ymm7, ymm7	 # tmp293, tmp270
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vmulps	ymm0, ymm0, ymm1	 # _45, _44, tmp273
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vbroadcastss	ymm1, DWORD PTR .LC11[rip]	 # tmp276,
	vfmadd132ps	ymm1, ymm8, ymm0	 # tmp274, tmp278, _45
	vbroadcastss	ymm8, DWORD PTR .LC15[rip]	 # tmp281,
	vfmadd132ps	ymm1, ymm8, ymm0	 # tmp279, tmp281, _45
	vbroadcastss	ymm8, DWORD PTR .LC17[rip]	 # tmp284,
	vfmadd132ps	ymm1, ymm8, ymm0	 # tmp282, tmp284, _45
	vbroadcastss	ymm8, DWORD PTR .LC19[rip]	 # tmp287,
	vfmadd132ps	ymm1, ymm8, ymm0	 # tmp285, tmp287, _45
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vcmpps	ymm8, ymm2, ymm5, 0	 # tmp312, a, tmp186,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vfmadd132ps	ymm1, ymm6, ymm0	 # tmp288, tmp200, _45
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vmulps	ymm6, ymm0, ymm0	 # _46, _45, _45
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vfmadd231ps	ymm0, ymm1, ymm6	 # tmp291, tmp288, _46
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vcmpps	ymm6, ymm2, ymm5, 1	 # tmp299, a, tmp186,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:121:   return (__m256i) ((__v8su)__A + (__v8su)__B);
	vpcmpeqd	ymm1, ymm1, ymm1	 # tmp298
	vpsrld	ymm1, ymm1, 25	 # tmp297, tmp298,
	vpaddd	ymm7, ymm7, ymm1	 # _56, tmp293, tmp297
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:213:   return (__m256) __builtin_ia32_blendvps256 ((__v8sf)__X,
	vpxor	xmm1, xmm1, xmm1	 # tmp302
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:684:   return (__m256i)__builtin_ia32_pslldi256 ((__v8si)__A, __B);
	vpslld	ymm7, ymm7, 23	 # tmp294, _56,
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:35: KW __m256 avx2k_pow_ps   (__m256 a, __m256 b) { return avx2_pow_ps(a, b); }
	vpcmpgtd	ymm3, ymm1, ymm3	 # tmp328, tmp302, tmp320
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:133:   return (__m256) ((__v8sf)__A + (__v8sf)__B);
	vaddps	ymm0, ymm0, ymm4	 # _53, tmp291, tmp212
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vmulps	ymm0, ymm0, ymm7	 # _60, _53, tmp294
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:213:   return (__m256) __builtin_ia32_blendvps256 ((__v8sf)__X,
	vbroadcastss	ymm7, DWORD PTR .LC88[rip]	 # tmp309,
	vblendvps	ymm0, ymm0, ymm7, ymm6	 # _16, _60, tmp309, tmp299
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vcmpps	ymm6, ymm2, ymm2, 3	 # tmp315, a, a,
	vcmpps	ymm2, ymm2, ymm4, 0	 # tmp317, a, tmp212,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:316:   return (__m256) __builtin_ia32_orps256 ((__v8sf)__A, (__v8sf)__B);
	vorps	ymm6, ymm6, ymm10	 # tmp316, tmp315, tmp314
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:35: KW __m256 avx2k_pow_ps   (__m256 a, __m256 b) { return avx2_pow_ps(a, b); }
	vpcmpgtd	ymm2, ymm1, ymm2	 # tmp325, tmp302, tmp317
	vpcmpgtd	ymm1, ymm1, ymm9	 # tmp341, tmp302, tmp310
	vpor	ymm2, ymm2, ymm3	 # _37, tmp325, tmp328
	vbroadcastss	ymm3, DWORD PTR .LC55[rip]	 # tmp343,
	vandps	ymm1, ymm3, ymm1	 # tmp338, tmp343, tmp341
	vblendvps	ymm0, ymm0, ymm1, ymm8	 # tmp334, _16, tmp338, tmp312
	vblendvps	ymm0, ymm0, ymm7, ymm6	 # tmp330, tmp334, tmp309, tmp316
	vblendvps	ymm0, ymm0, ymm4, ymm2	 # tmp322, tmp330, tmp212, _37
	vmovups	YMMWORD PTR [rcx], ymm0	 # <retval>, tmp322
	vzeroupper
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:35: KW __m256 avx2k_pow_ps   (__m256 a, __m256 b) { return avx2_pow_ps(a, b); }
	vmovups	xmm6, XMMWORD PTR [rsp]	 #,
	vmovups	xmm7, XMMWORD PTR 16[rsp]	 #,
	vmovups	xmm8, XMMWORD PTR 32[rsp]	 #,
	vmovups	xmm9, XMMWORD PTR 48[rsp]	 #,
	vmovups	xmm10, XMMWORD PTR 64[rsp]	 #,
	vmovups	xmm11, XMMWORD PTR 80[rsp]	 #,
	add	rsp, 104	 #,
	ret	
	.seh_endproc
	.p2align 4
	.globl	avx2k_exp_pd
	.def	avx2k_exp_pd;	.scl	2;	.type	32;	.endef
	.seh_proc	avx2k_exp_pd
avx2k_exp_pd:
	sub	rsp, 56	 #,
	.seh_stackalloc	56
	vmovups	XMMWORD PTR [rsp], xmm6	 #,
	.seh_savexmm	xmm6, 0
	vmovups	XMMWORD PTR 16[rsp], xmm7	 #,
	.seh_savexmm	xmm7, 16
	vmovups	XMMWORD PTR 32[rsp], xmm8	 #,
	.seh_savexmm	xmm8, 32
	.seh_endprologue
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:371:   return (__m256d) __builtin_ia32_cmppd256 ((__v4df)__X, (__v4df)__Y,
	vbroadcastsd	ymm2, QWORD PTR .LC104[rip]	 # tmp153,
	vbroadcastsd	ymm1, QWORD PTR .LC106[rip]	 # tmp156,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:49:   return (__m256d)__builtin_ia32_vfmaddpd256 ((__v4df)__A, (__v4df)__B,
	vbroadcastsd	ymm6, QWORD PTR .LC116[rip]	 # tmp186,
	vbroadcastsd	ymm8, QWORD PTR .LC118[rip]	 # tmp189,
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:38: KW __m256d avx2k_exp_pd  (__m256d x) { return avx2_exp_pd(x); }
	vmovupd	ymm0, YMMWORD PTR [rdx]	 # x, x
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:371:   return (__m256d) __builtin_ia32_cmppd256 ((__v4df)__X, (__v4df)__Y,
	vcmppd	ymm5, ymm0, ymm2, 30	 # tmp151, x, tmp153,
	vcmppd	ymm4, ymm0, ymm1, 17	 # tmp154, x, tmp156,
	vcmppd	ymm3, ymm0, ymm0, 3	 # tmp157, x, x,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:286:   return (__m256d) __builtin_ia32_minpd256 ((__v4df)__A, (__v4df)__B);
	vminpd	ymm0, ymm0, ymm2	 # _9, x, tmp153
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:145:   return (__m256d)__builtin_ia32_vfnmaddpd256 ((__v4df)__A, (__v4df)__B,
	vbroadcastsd	ymm2, QWORD PTR .LC110[rip]	 # tmp178,
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:38: KW __m256d avx2k_exp_pd  (__m256d x) { return avx2_exp_pd(x); }
	mov	rax, rcx	 # .result_ptr, .result_ptr
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:274:   return (__m256d) __builtin_ia32_maxpd256 ((__v4df)__A, (__v4df)__B);
	vmaxpd	ymm1, ymm0, ymm1	 # _11, _9, tmp156
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:298:   return (__m256d) ((__v4df)__A * (__v4df)__B);
	vbroadcastsd	ymm0, QWORD PTR .LC108[rip]	 # tmp175,
	vmulpd	ymm0, ymm1, ymm0	 # _12, _11, tmp175
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:1004:   return (__m256d) __builtin_ia32_roundpd256 ((__v4df)__V, __M);
	vroundpd	ymm0, ymm0, 8	 # tmp172, _12,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:145:   return (__m256d)__builtin_ia32_vfnmaddpd256 ((__v4df)__A, (__v4df)__B,
	vfnmadd132pd	ymm2, ymm1, ymm0	 # tmp176, _11, tmp172
	vbroadcastsd	ymm1, QWORD PTR .LC112[rip]	 # tmp181,
	vfnmadd132pd	ymm1, ymm2, ymm0	 # tmp179, tmp176, tmp172
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:437:   return (__m128i)__builtin_ia32_cvtpd2dq256 ((__v4df) __A);
	vcvtpd2dq	xmm0, ymm0	 # tmp208, tmp172
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:49:   return (__m256d)__builtin_ia32_vfmaddpd256 ((__v4df)__A, (__v4df)__B,
	vbroadcastsd	ymm2, QWORD PTR .LC114[rip]	 # tmp184,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:298:   return (__m256d) ((__v4df)__A * (__v4df)__B);
	vmulpd	ymm7, ymm1, ymm1	 # _16, tmp179, tmp179
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:49:   return (__m256d)__builtin_ia32_vfmaddpd256 ((__v4df)__A, (__v4df)__B,
	vfmadd132pd	ymm2, ymm6, ymm7	 # tmp182, tmp186, _16
	vbroadcastsd	ymm6, QWORD PTR .LC120[rip]	 # tmp192,
	vfmadd132pd	ymm2, ymm8, ymm7	 # tmp187, tmp189, _16
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:298:   return (__m256d) ((__v4df)__A * (__v4df)__B);
	vmulpd	ymm2, ymm1, ymm2	 # _19, tmp179, tmp187
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:49:   return (__m256d)__builtin_ia32_vfmaddpd256 ((__v4df)__A, (__v4df)__B,
	vbroadcastsd	ymm1, QWORD PTR .LC122[rip]	 # tmp194,
	vfmadd132pd	ymm6, ymm1, ymm7	 # tmp190, tmp194, _16
	vbroadcastsd	ymm1, QWORD PTR .LC124[rip]	 # tmp197,
	vfmadd132pd	ymm6, ymm1, ymm7	 # tmp195, tmp197, _16
	vbroadcastsd	ymm1, QWORD PTR .LC126[rip]	 # tmp200,
	vfmadd132pd	ymm6, ymm1, ymm7	 # tmp198, tmp200, _16
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:128:   return (__m256i) ((__v4du)__A + (__v4du)__B);
	vpbroadcastq	ymm7, QWORD PTR .LC132[rip]	 # tmp216,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:346:   return (__m256d) ((__v4df)__A - (__v4df)__B);
	vsubpd	ymm6, ymm6, ymm2	 # _23, tmp198, _19
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:221:   return (__m256d) ((__v4df)__A / (__v4df)__B);
	vdivpd	ymm2, ymm2, ymm6	 # _24, _19, _23
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:49:   return (__m256d)__builtin_ia32_vfmaddpd256 ((__v4df)__A, (__v4df)__B,
	vfmadd132pd	ymm1, ymm8, ymm2	 # tmp201, tmp189, _24
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/emmintrin.h:1211:   return (__m128i)__builtin_ia32_psradi128 ((__v4si)__A, __B);
	vpsrad	xmm2, xmm0, 1	 # tmp209, tmp208,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:477:   return (__m256i) __builtin_ia32_pmovsxdq256 ((__v4si)__X);
	vpmovsxdq	ymm6, xmm2	 # _27, tmp209
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/emmintrin.h:1121:   return (__m128i) ((__v4su)__A - (__v4su)__B);
	vpsubd	xmm2, xmm0, xmm2	 # _30, tmp208, tmp209
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:128:   return (__m256i) ((__v4du)__A + (__v4du)__B);
	vpaddq	ymm0, ymm6, ymm7	 # _35, _27, tmp216
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:477:   return (__m256i) __builtin_ia32_pmovsxdq256 ((__v4si)__X);
	vpmovsxdq	ymm2, xmm2	 # _30, _30
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:698:   return (__m256i)__builtin_ia32_psllqi256 ((__v4di)__A, __B);
	vpsllq	ymm0, ymm0, 52	 # tmp213, _35,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:128:   return (__m256i) ((__v4du)__A + (__v4du)__B);
	vpaddq	ymm2, ymm2, ymm7	 # _39, _30, tmp216
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:698:   return (__m256i)__builtin_ia32_psllqi256 ((__v4di)__A, __B);
	vpsllq	ymm2, ymm2, 52	 # tmp218, _39,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:298:   return (__m256d) ((__v4df)__A * (__v4df)__B);
	vmulpd	ymm0, ymm1, ymm0	 # _43, tmp201, tmp213
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:38: KW __m256d avx2k_exp_pd  (__m256d x) { return avx2_exp_pd(x); }
	vbroadcastsd	ymm1, QWORD PTR .LC129[rip]	 # tmp238,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:298:   return (__m256d) ((__v4df)__A * (__v4df)__B);
	vmulpd	ymm0, ymm0, ymm2	 # _45, _43, tmp218
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:38: KW __m256d avx2k_exp_pd  (__m256d x) { return avx2_exp_pd(x); }
	vblendvpd	ymm0, ymm0, ymm1, ymm5	 # tmp231, _45, tmp238, tmp151
	vxorpd	xmm1, xmm1, xmm1	 # tmp239
	vblendvpd	ymm0, ymm0, ymm1, ymm4	 # tmp227, tmp231, tmp239, tmp154
	vbroadcastsd	ymm1, QWORD PTR .LC131[rip]	 # tmp241,
	vblendvpd	ymm0, ymm0, ymm1, ymm3	 # tmp223, tmp227, tmp241, tmp157
	vmovupd	YMMWORD PTR [rcx], ymm0	 # <retval>, tmp223
	vzeroupper
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:38: KW __m256d avx2k_exp_pd  (__m256d x) { return avx2_exp_pd(x); }
	vmovups	xmm6, XMMWORD PTR [rsp]	 #,
	vmovups	xmm7, XMMWORD PTR 16[rsp]	 #,
	vmovups	xmm8, XMMWORD PTR 32[rsp]	 #,
	add	rsp, 56	 #,
	ret	
	.seh_endproc
	.p2align 4
	.globl	avx2k_log_pd
	.def	avx2k_log_pd;	.scl	2;	.type	32;	.endef
	.seh_proc	avx2k_log_pd
avx2k_log_pd:
	sub	rsp, 104	 #,
	.seh_stackalloc	104
	vmovups	XMMWORD PTR [rsp], xmm6	 #,
	.seh_savexmm	xmm6, 0
	vmovups	XMMWORD PTR 16[rsp], xmm7	 #,
	.seh_savexmm	xmm7, 16
	vmovups	XMMWORD PTR 32[rsp], xmm8	 #,
	.seh_savexmm	xmm8, 32
	vmovups	XMMWORD PTR 48[rsp], xmm9	 #,
	.seh_savexmm	xmm9, 48
	vmovups	XMMWORD PTR 64[rsp], xmm10	 #,
	.seh_savexmm	xmm10, 64
	vmovups	XMMWORD PTR 80[rsp], xmm11	 #,
	.seh_savexmm	xmm11, 80
	.seh_endprologue
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:371:   return (__m256d) __builtin_ia32_cmppd256 ((__v4df)__X, (__v4df)__Y,
	vxorpd	xmm4, xmm4, xmm4	 # tmp168
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:205:   return (__m256d) __builtin_ia32_blendvpd256 ((__v4df)__X,
	vpxor	xmm5, xmm5, xmm5	 # tmp178
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:298:   return (__m256d) ((__v4df)__A * (__v4df)__B);
	vbroadcastsd	ymm0, QWORD PTR .LC136[rip]	 # tmp182,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:371:   return (__m256d) __builtin_ia32_cmppd256 ((__v4df)__X, (__v4df)__Y,
	vbroadcastsd	ymm10, QWORD PTR .LC134[rip]	 # tmp176,
	vbroadcastsd	ymm6, QWORD PTR .LC129[rip]	 # tmp173,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:152:   return (__m256d) __builtin_ia32_andpd256 ((__v4df)__A, (__v4df)__B);
	vbroadcastsd	ymm9, QWORD PTR .LC142[rip]	 # tmp203,
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:39: KW __m256d avx2k_log_pd  (__m256d x) { return avx2_log_pd(x); }
	vmovupd	ymm1, YMMWORD PTR [rdx]	 # x, x
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:298:   return (__m256d) ((__v4df)__A * (__v4df)__B);
	vmulpd	ymm0, ymm1, ymm0	 # _10, x, tmp182
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:371:   return (__m256d) __builtin_ia32_cmppd256 ((__v4df)__X, (__v4df)__Y,
	vcmppd	ymm10, ymm1, ymm10, 17	 # tmp174, x, tmp176,
	vcmppd	ymm7, ymm1, ymm6, 0	 # tmp171, x, tmp173,
	vcmppd	ymm8, ymm1, ymm1, 3	 # tmp166, x, x,
	vcmppd	ymm3, ymm1, ymm4, 17	 # tmp167, x, tmp168,
	vcmppd	ymm4, ymm1, ymm4, 0	 # tmp169, x, tmp168,
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:39: KW __m256d avx2k_log_pd  (__m256d x) { return avx2_log_pd(x); }
	mov	rax, rcx	 # .result_ptr, .result_ptr
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:152:   return (__m256d) __builtin_ia32_andpd256 ((__v4df)__A, (__v4df)__B);
	vandpd	ymm9, ymm10, ymm9	 # tmp201, tmp174, tmp203
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:205:   return (__m256d) __builtin_ia32_blendvpd256 ((__v4df)__X,
	vblendvpd	ymm1, ymm1, ymm0, ymm10	 # _13, x, _10, tmp174
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:39: KW __m256d avx2k_log_pd  (__m256d x) { return avx2_log_pd(x); }
	vpcmpgtq	ymm3, ymm5, ymm3	 # tmp266, tmp178, tmp167
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:181:   return (__m256i) ((__v4du)__A & (__v4du)__B);
	vpbroadcastq	ymm0, QWORD PTR .LC179[rip]	 # tmp185,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:346:   return (__m256d) ((__v4df)__A - (__v4df)__B);
	vbroadcastsd	ymm10, QWORD PTR .LC146[rip]	 # tmp210,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:789:   return (__m256i)__builtin_ia32_psrlqi256 ((__v4di)__A, __B);
	vpsrlq	ymm2, ymm1, 52	 # tmp183, _13,
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:39: KW __m256d avx2k_log_pd  (__m256d x) { return avx2_log_pd(x); }
	vpcmpgtq	ymm5, ymm5, ymm8	 # tmp269, tmp178, tmp166
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:181:   return (__m256i) ((__v4du)__A & (__v4du)__B);
	vpand	ymm2, ymm2, ymm0	 # _17, tmp183, tmp185
	vbroadcastsd	ymm0, QWORD PTR .LC139[rip]	 # tmp190,
	vandpd	ymm1, ymm1, ymm0	 # tmp188, _13, tmp190
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:1422:   return (__m128i) __builtin_ia32_si_si256 ((__v8si)__A);
	vmovdqa	xmm0, xmm2	 # tmp195, _17
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:1098:   return (__m128i) __builtin_ia32_extract128i256 ((__v4di)__X, __M);
	vextracti128	xmm2, ymm2, 0x1	 # tmp196, _17
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:576:   return (__m256i) ((__v4du)__A | (__v4du)__B);
	vpor	ymm1, ymm1, YMMWORD PTR .LC140[rip]	 # _21, tmp188,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/xmmintrin.h:794:   return (__m128) __builtin_ia32_shufps ((__v4sf)__A, (__v4sf)__B, __mask);
	vshufps	xmm0, xmm0, xmm2, 136	 # _28, tmp195, tmp196,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:401:   return (__m256d)__builtin_ia32_cvtdq2pd256 ((__v4si) __A);
	vcvtdq2pd	ymm0, xmm0	 # tmp197, _28
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:371:   return (__m256d) __builtin_ia32_cmppd256 ((__v4df)__X, (__v4df)__Y,
	vbroadcastsd	ymm2, QWORD PTR .LC144[rip]	 # tmp206,
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:39: KW __m256d avx2k_log_pd  (__m256d x) { return avx2_log_pd(x); }
	vpor	ymm3, ymm3, ymm5	 # _68, tmp266, tmp269
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:371:   return (__m256d) __builtin_ia32_cmppd256 ((__v4df)__X, (__v4df)__Y,
	vcmppd	ymm2, ymm1, ymm2, 17	 # tmp204, _21, tmp206,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:152:   return (__m256d) __builtin_ia32_andpd256 ((__v4df)__A, (__v4df)__B);
	vandpd	ymm11, ymm2, ymm1	 # tmp207, tmp204, _21
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:346:   return (__m256d) ((__v4df)__A - (__v4df)__B);
	vaddpd	ymm1, ymm10, ymm1	 # _36, tmp210, _21
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:152:   return (__m256d) __builtin_ia32_andpd256 ((__v4df)__A, (__v4df)__B);
	vbroadcastsd	ymm10, QWORD PTR .LC118[rip]	 # tmp213,
	vandpd	ymm2, ymm2, ymm10	 # tmp211, tmp204, tmp213
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:346:   return (__m256d) ((__v4df)__A - (__v4df)__B);
	vbroadcastsd	ymm10, QWORD PTR .LC148[rip]	 # tmp216,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:127:   return (__m256d) ((__v4df)__A + (__v4df)__B);
	vaddpd	ymm1, ymm1, ymm11	 # _37, _36, tmp207
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:49:   return (__m256d)__builtin_ia32_vfmaddpd256 ((__v4df)__A, (__v4df)__B,
	vbroadcastsd	ymm11, QWORD PTR .LC164[rip]	 # tmp240,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:346:   return (__m256d) ((__v4df)__A - (__v4df)__B);
	vaddpd	ymm0, ymm0, ymm10	 # _31, tmp197, tmp216
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:49:   return (__m256d)__builtin_ia32_vfmaddpd256 ((__v4df)__A, (__v4df)__B,
	vbroadcastsd	ymm10, QWORD PTR .LC152[rip]	 # tmp222,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:346:   return (__m256d) ((__v4df)__A - (__v4df)__B);
	vsubpd	ymm0, ymm0, ymm9	 # _33, _31, tmp201
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:298:   return (__m256d) ((__v4df)__A * (__v4df)__B);
	vmulpd	ymm9, ymm1, ymm1	 # _40, _37, _37
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:346:   return (__m256d) ((__v4df)__A - (__v4df)__B);
	vsubpd	ymm0, ymm0, ymm2	 # _39, _33, tmp211
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:49:   return (__m256d)__builtin_ia32_vfmaddpd256 ((__v4df)__A, (__v4df)__B,
	vbroadcastsd	ymm2, QWORD PTR .LC150[rip]	 # tmp220,
	vfmadd132pd	ymm2, ymm10, ymm1	 # tmp218, tmp222, _37
	vbroadcastsd	ymm10, QWORD PTR .LC154[rip]	 # tmp225,
	vfmadd132pd	ymm2, ymm10, ymm1	 # tmp223, tmp225, _37
	vbroadcastsd	ymm10, QWORD PTR .LC156[rip]	 # tmp228,
	vfmadd132pd	ymm2, ymm10, ymm1	 # tmp226, tmp228, _37
	vbroadcastsd	ymm10, QWORD PTR .LC158[rip]	 # tmp231,
	vfmadd132pd	ymm2, ymm10, ymm1	 # tmp229, tmp231, _37
	vbroadcastsd	ymm10, QWORD PTR .LC160[rip]	 # tmp234,
	vfmadd231pd	ymm10, ymm2, ymm1	 # tmp232, tmp229, _37
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:127:   return (__m256d) ((__v4df)__A + (__v4df)__B);
	vbroadcastsd	ymm2, QWORD PTR .LC162[rip]	 # tmp238,
	vaddpd	ymm2, ymm1, ymm2	 # _46, _37, tmp238
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:49:   return (__m256d)__builtin_ia32_vfmaddpd256 ((__v4df)__A, (__v4df)__B,
	vfmadd132pd	ymm2, ymm11, ymm1	 # tmp235, tmp240, _37
	vbroadcastsd	ymm11, QWORD PTR .LC166[rip]	 # tmp243,
	vfmadd132pd	ymm2, ymm11, ymm1	 # tmp241, tmp243, _37
	vbroadcastsd	ymm11, QWORD PTR .LC168[rip]	 # tmp246,
	vfmadd132pd	ymm2, ymm11, ymm1	 # tmp244, tmp246, _37
	vbroadcastsd	ymm11, QWORD PTR .LC170[rip]	 # tmp249,
	vfmadd132pd	ymm2, ymm11, ymm1	 # tmp247, tmp249, _37
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:221:   return (__m256d) ((__v4df)__A / (__v4df)__B);
	vdivpd	ymm2, ymm10, ymm2	 # _51, tmp232, tmp247
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:49:   return (__m256d)__builtin_ia32_vfmaddpd256 ((__v4df)__A, (__v4df)__B,
	vbroadcastsd	ymm10, QWORD PTR .LC172[rip]	 # tmp252,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:298:   return (__m256d) ((__v4df)__A * (__v4df)__B);
	vmulpd	ymm2, ymm2, ymm9	 # _52, _51, _40
	vmulpd	ymm2, ymm2, ymm1	 # _53, _52, _37
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:49:   return (__m256d)__builtin_ia32_vfmaddpd256 ((__v4df)__A, (__v4df)__B,
	vfmadd231pd	ymm2, ymm0, ymm10	 # tmp250, _39, tmp252
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:145:   return (__m256d)__builtin_ia32_vfnmaddpd256 ((__v4df)__A, (__v4df)__B,
	vbroadcastsd	ymm10, QWORD PTR .LC174[rip]	 # tmp258,
	vfnmadd132pd	ymm9, ymm2, ymm10	 # tmp256, tmp250, tmp258
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:49:   return (__m256d)__builtin_ia32_vfmaddpd256 ((__v4df)__A, (__v4df)__B,
	vbroadcastsd	ymm2, QWORD PTR .LC176[rip]	 # tmp261,
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:127:   return (__m256d) ((__v4df)__A + (__v4df)__B);
	vaddpd	ymm1, ymm1, ymm9	 # _56, _37, tmp256
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:49:   return (__m256d)__builtin_ia32_vfmaddpd256 ((__v4df)__A, (__v4df)__B,
	vfmadd132pd	ymm0, ymm1, ymm2	 # tmp259, _56, tmp261
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:39: KW __m256d avx2k_log_pd  (__m256d x) { return avx2_log_pd(x); }
	vbroadcastsd	ymm1, QWORD PTR .LC178[rip]	 # tmp282,
	vblendvpd	ymm0, ymm0, ymm6, ymm7	 # tmp275, tmp259, tmp173, tmp171
	vblendvpd	ymm0, ymm0, ymm1, ymm4	 # tmp271, tmp275, tmp282, tmp169
	vbroadcastsd	ymm1, QWORD PTR .LC131[rip]	 # tmp284,
	vblendvpd	ymm0, ymm0, ymm1, ymm3	 # tmp263, tmp271, tmp284, _68
	vmovupd	YMMWORD PTR [rcx], ymm0	 # <retval>, tmp263
	vzeroupper
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:39: KW __m256d avx2k_log_pd  (__m256d x) { return avx2_log_pd(x); }
	vmovups	xmm6, XMMWORD PTR [rsp]	 #,
	vmovups	xmm7, XMMWORD PTR 16[rsp]	 #,
	vmovups	xmm8, XMMWORD PTR 32[rsp]	 #,
	vmovups	xmm9, XMMWORD PTR 48[rsp]	 #,
	vmovups	xmm10, XMMWORD PTR 64[rsp]	 #,
	vmovups	xmm11, XMMWORD PTR 80[rsp]	 #,
	add	rsp, 104	 #,
	ret	
	.seh_endproc
	.section .rdata,"dr"
	.align 4
.LC1:
	.long	1118879909
	.align 4
.LC3:
	.long	-1028603739
	.align 4
.LC5:
	.long	1069066811
	.align 4
.LC7:
	.long	1060208640
	.align 4
.LC9:
	.long	-1184989053
	.align 4
.LC11:
	.long	961571175
	.align 4
.LC13:
	.long	985088974
	.align 4
.LC15:
	.long	1007192328
	.align 4
.LC17:
	.long	1026206145
	.align 4
.LC19:
	.long	1042983594
	.align 4
.LC21:
	.long	1056964608
	.align 4
.LC24:
	.long	1065353216
	.align 4
.LC26:
	.long	1123942400
	.align 4
.LC28:
	.long	-1023541248
	.align 4
.LC30:
	.long	1060205080
	.align 4
.LC32:
	.long	1108869120
	.align 4
.LC34:
	.long	-1038876672
	.align 4
.LC36:
	.long	1079286392
	.align 4
.LC38:
	.long	1050288128
	.align 4
.LC40:
	.long	916096252
	.align 4
.LC42:
	.long	1075010958
	.align 4
.LC44:
	.long	1118925336
	.align 4
.LC46:
	.long	-1082130432
	.align 4
.LC48:
	.long	-2147483648
	.align 4
.LC50:
	.long	872415232
	.align 4
.LC52:
	.long	-1047879389
	.align 4
.LC55:
	.long	2139095040
	.align 4
.LC57:
	.long	8388608
	.align 4
.LC59:
	.long	-2139095041
	.align 4
.LC62:
	.long	1060439283
	.align 4
.LC64:
	.long	1032855995
	.align 4
.LC66:
	.long	-1108618824
	.align 4
.LC68:
	.long	1039082778
	.align 4
.LC70:
	.long	-1107403441
	.align 4
.LC72:
	.long	1041361343
	.align 4
.LC74:
	.long	-1104499120
	.align 4
.LC76:
	.long	1045221036
	.align 4
.LC78:
	.long	-1098907652
	.align 4
.LC80:
	.long	1051372202
	.align 4
.LC82:
	.long	1050288283
	.align 4
.LC84:
	.long	1054759897
	.align 4
.LC86:
	.long	-8388608
	.align 4
.LC88:
	.long	2143289344
	.set	.LC90,.LC126+4
	.align 4
.LC92:
	.long	-1145376534
	.align 4
.LC94:
	.long	1017713486
	.align 4
.LC96:
	.long	-1118036435
	.align 4
.LC98:
	.long	1040745363
	.align 4
.LC100:
	.long	-1096111463
	.align 4
.LC102:
	.long	1059061760
	.align 8
.LC104:
	.long	-17155601
	.long	1082535490
	.align 8
.LC106:
	.long	-718458799
	.long	-1064875760
	.align 8
.LC108:
	.long	1697350398
	.long	1073157447
	.align 8
.LC110:
	.long	0
	.long	1072049728
	.align 8
.LC112:
	.long	-814109750
	.long	1052243921
	.align 8
.LC114:
	.long	-706458648
	.long	1059097037
	.align 8
.LC116:
	.long	214576254
	.long	1067386577
	.align 8
.LC118:
	.long	0
	.long	1072693248
	.align 8
.LC120:
	.long	-1137287264
	.long	1053372086
	.align 8
.LC122:
	.long	-1257720128
	.long	1063562809
	.align 8
.LC124:
	.long	-1735925644
	.long	1070405385
	.align 8
.LC126:
	.long	0
	.long	1073741824
	.align 8
.LC129:
	.long	0
	.long	2146435072
	.align 8
.LC131:
	.long	0
	.long	2146959360
	.align 8
.LC132:
	.quad	1023
	.align 8
.LC134:
	.long	0
	.long	1048576
	.align 8
.LC136:
	.long	0
	.long	1129316352
	.align 8
.LC139:
	.long	-1
	.long	1048575
	.align 32
.LC140:
	.quad	4602678819172646912
	.quad	4602678819172646912
	.quad	4602678819172646912
	.quad	4602678819172646912
	.align 8
.LC142:
	.long	0
	.long	1078657024
	.align 8
.LC144:
	.long	1719614413
	.long	1072079006
	.align 8
.LC146:
	.long	0
	.long	-1074790400
	.align 8
.LC148:
	.long	0
	.long	-1064308736
	.align 8
.LC150:
	.long	-1815929936
	.long	1058714818
	.align 8
.LC152:
	.long	1062621938
	.long	1071634165
	.align 8
.LC154:
	.long	-309171951
	.long	1074975418
	.align 8
.LC156:
	.long	-968955090
	.long	1076690802
	.align 8
.LC158:
	.long	-1840527283
	.long	1077014486
	.align 8
.LC160:
	.long	2105466104
	.long	1075762531
	.align 8
.LC162:
	.long	-1365774450
	.long	1076269856
	.align 8
.LC164:
	.long	1310310451
	.long	1078369580
	.align 8
.LC166:
	.long	-1557742147
	.long	1079295795
	.align 8
.LC168:
	.long	-346116575
	.long	1079101922
	.align 8
.LC170:
	.long	-1642125902
	.long	1077354506
	.align 8
.LC172:
	.long	1549864104
	.long	-1087647728
	.set	.LC174,.LC140
	.align 8
.LC176:
	.long	0
	.long	1072050176
	.align 8
.LC178:
	.long	0
	.long	-1048576
	.align 8
.LC179:
	.quad	2047
	.ident	"GCC: (Rev8, Built by MSYS2 project) 15.2.0"
