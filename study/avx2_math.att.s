	.file	"kernels.c"
 # GNU C23 (Rev8, Built by MSYS2 project) version 15.2.0 (x86_64-w64-mingw32)
 #	compiled by GNU C version 15.2.0, GMP version 6.3.0, MPFR version 4.2.2, MPC version 1.3.1, isl version isl-0.27-GMP

 # GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
 # options passed: -mavx2 -mfma -mtune=generic -march=nocona -O3
	.text
	.p2align 4
	.globl	avx2k_exp_ps
	.def	avx2k_exp_ps;	.scl	2;	.type	32;	.endef
	.seh_proc	avx2k_exp_ps
avx2k_exp_ps:
	.seh_endprologue
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:292:   return (__m256) __builtin_ia32_minps256 ((__v8sf)__A, (__v8sf)__B);
	vbroadcastss	.LC1(%rip), %ymm1	 #, tmp125
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:161:   return (__m256)__builtin_ia32_vfnmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vbroadcastss	.LC7(%rip), %ymm2	 #, tmp144
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vbroadcastss	.LC13(%rip), %ymm3	 #, tmp152
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:25: KW __m256 avx2k_exp_ps   (__m256 x) { return avx2_exp_ps(x); }
	vmovups	(%rdx), %ymm0	 # x, x
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:292:   return (__m256) __builtin_ia32_minps256 ((__v8sf)__A, (__v8sf)__B);
	vminps	%ymm1, %ymm0, %ymm0	 # tmp125, x, _6
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:280:   return (__m256) __builtin_ia32_maxps256 ((__v8sf)__A, (__v8sf)__B);
	vbroadcastss	.LC3(%rip), %ymm1	 #, tmp132
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:25: KW __m256 avx2k_exp_ps   (__m256 x) { return avx2_exp_ps(x); }
	movq	%rcx, %rax	 # .result_ptr, .result_ptr
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:280:   return (__m256) __builtin_ia32_maxps256 ((__v8sf)__A, (__v8sf)__B);
	vmaxps	%ymm1, %ymm0, %ymm0	 # tmp132, _6, _8
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vbroadcastss	.LC5(%rip), %ymm1	 #, tmp141
	vmulps	%ymm1, %ymm0, %ymm1	 # tmp141, _8, _9
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:1010:   return (__m256) __builtin_ia32_roundps256 ((__v8sf)__V, __M);
	vroundps	$8, %ymm1, %ymm1	 #, _9, tmp138
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:161:   return (__m256)__builtin_ia32_vfnmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vfnmadd231ps	%ymm2, %ymm1, %ymm0	 # tmp144, tmp138, tmp142
	vbroadcastss	.LC9(%rip), %ymm2	 #, tmp147
	vfnmadd132ps	%ymm1, %ymm0, %ymm2	 # tmp138, tmp142, tmp145
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:443:   return (__m256i)__builtin_ia32_cvttps2dq256 ((__v8sf) __A);
	vcvttps2dq	%ymm1, %ymm1	 # tmp138, tmp167
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vbroadcastss	.LC11(%rip), %ymm0	 #, tmp150
	vfmadd132ps	%ymm2, %ymm3, %ymm0	 # tmp145, tmp152, tmp148
	vbroadcastss	.LC15(%rip), %ymm3	 #, tmp155
	vfmadd132ps	%ymm2, %ymm3, %ymm0	 # tmp145, tmp155, tmp153
	vbroadcastss	.LC17(%rip), %ymm3	 #, tmp158
	vfmadd132ps	%ymm2, %ymm3, %ymm0	 # tmp145, tmp158, tmp156
	vbroadcastss	.LC19(%rip), %ymm3	 #, tmp161
	vfmadd132ps	%ymm2, %ymm3, %ymm0	 # tmp145, tmp161, tmp159
	vbroadcastss	.LC21(%rip), %ymm3	 #, tmp164
	vfmadd132ps	%ymm2, %ymm3, %ymm0	 # tmp145, tmp164, tmp162
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vmulps	%ymm2, %ymm2, %ymm3	 # tmp145, tmp145, _13
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vfmadd132ps	%ymm3, %ymm2, %ymm0	 # _13, tmp145, tmp165
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:121:   return (__m256i) ((__v8su)__A + (__v8su)__B);
	vpcmpeqd	%ymm2, %ymm2, %ymm2	 # tmp172
	vpsrld	$25, %ymm2, %ymm2	 #, tmp172, tmp171
	vpaddd	%ymm2, %ymm1, %ymm1	 # tmp171, tmp167, _23
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:133:   return (__m256) ((__v8sf)__A + (__v8sf)__B);
	vbroadcastss	.LC24(%rip), %ymm2	 #, tmp175
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:684:   return (__m256i)__builtin_ia32_pslldi256 ((__v8si)__A, __B);
	vpslld	$23, %ymm1, %ymm1	 #, _23, tmp168
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:133:   return (__m256) ((__v8sf)__A + (__v8sf)__B);
	vaddps	%ymm2, %ymm0, %ymm0	 # tmp175, tmp165, _20
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vmulps	%ymm1, %ymm0, %ymm0	 # tmp168, _20, _27
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:25: KW __m256 avx2k_exp_ps   (__m256 x) { return avx2_exp_ps(x); }
	vmovups	%ymm0, (%rcx)	 # _27, <retval>
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
	vbroadcastss	.LC26(%rip), %ymm0	 #, tmp124
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vbroadcastss	.LC13(%rip), %ymm3	 #, tmp145
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:26: KW __m256 avx2k_exp2_ps  (__m256 x) { return avx2_exp2_ps(x); }
	vmovups	(%rdx), %ymm1	 # x, x
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:292:   return (__m256) __builtin_ia32_minps256 ((__v8sf)__A, (__v8sf)__B);
	vminps	%ymm0, %ymm1, %ymm1	 # tmp124, x, _6
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:280:   return (__m256) __builtin_ia32_maxps256 ((__v8sf)__A, (__v8sf)__B);
	vbroadcastss	.LC28(%rip), %ymm0	 #, tmp131
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:26: KW __m256 avx2k_exp2_ps  (__m256 x) { return avx2_exp2_ps(x); }
	movq	%rcx, %rax	 # .result_ptr, .result_ptr
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:280:   return (__m256) __builtin_ia32_maxps256 ((__v8sf)__A, (__v8sf)__B);
	vmaxps	%ymm0, %ymm1, %ymm1	 # tmp131, _6, _8
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vbroadcastss	.LC30(%rip), %ymm0	 #, tmp140
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:1010:   return (__m256) __builtin_ia32_roundps256 ((__v8sf)__V, __M);
	vroundps	$8, %ymm1, %ymm2	 #, _8, tmp137
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:352:   return (__m256) ((__v8sf)__A - (__v8sf)__B);
	vsubps	%ymm2, %ymm1, %ymm1	 # tmp137, _8, _10
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:443:   return (__m256i)__builtin_ia32_cvttps2dq256 ((__v8sf) __A);
	vcvttps2dq	%ymm2, %ymm2	 # tmp137, tmp160
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vmulps	%ymm0, %ymm1, %ymm1	 # tmp140, _10, _11
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vbroadcastss	.LC11(%rip), %ymm0	 #, tmp143
	vfmadd132ps	%ymm1, %ymm3, %ymm0	 # _11, tmp145, tmp141
	vbroadcastss	.LC15(%rip), %ymm3	 #, tmp148
	vfmadd132ps	%ymm1, %ymm3, %ymm0	 # _11, tmp148, tmp146
	vbroadcastss	.LC17(%rip), %ymm3	 #, tmp151
	vfmadd132ps	%ymm1, %ymm3, %ymm0	 # _11, tmp151, tmp149
	vbroadcastss	.LC19(%rip), %ymm3	 #, tmp154
	vfmadd132ps	%ymm1, %ymm3, %ymm0	 # _11, tmp154, tmp152
	vbroadcastss	.LC21(%rip), %ymm3	 #, tmp157
	vfmadd132ps	%ymm1, %ymm3, %ymm0	 # _11, tmp157, tmp155
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vmulps	%ymm1, %ymm1, %ymm3	 # _11, _11, _12
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vfmadd132ps	%ymm3, %ymm1, %ymm0	 # _12, _11, tmp158
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:121:   return (__m256i) ((__v8su)__A + (__v8su)__B);
	vpcmpeqd	%ymm1, %ymm1, %ymm1	 # tmp165
	vpsrld	$25, %ymm1, %ymm1	 #, tmp165, tmp164
	vpaddd	%ymm1, %ymm2, %ymm2	 # tmp164, tmp160, _22
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:133:   return (__m256) ((__v8sf)__A + (__v8sf)__B);
	vbroadcastss	.LC24(%rip), %ymm1	 #, tmp168
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:684:   return (__m256i)__builtin_ia32_pslldi256 ((__v8si)__A, __B);
	vpslld	$23, %ymm2, %ymm2	 #, _22, tmp161
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:133:   return (__m256) ((__v8sf)__A + (__v8sf)__B);
	vaddps	%ymm1, %ymm0, %ymm0	 # tmp168, tmp158, _19
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vmulps	%ymm2, %ymm0, %ymm0	 # tmp161, _19, _26
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:26: KW __m256 avx2k_exp2_ps  (__m256 x) { return avx2_exp2_ps(x); }
	vmovups	%ymm0, (%rcx)	 # _26, <retval>
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
	vbroadcastss	.LC32(%rip), %ymm1	 #, tmp126
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:161:   return (__m256)__builtin_ia32_vfnmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vbroadcastss	.LC38(%rip), %ymm2	 #, tmp145
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vbroadcastss	.LC13(%rip), %ymm3	 #, tmp155
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:27: KW __m256 avx2k_exp10_ps (__m256 x) { return avx2_exp10_ps(x); }
	vmovups	(%rdx), %ymm0	 # x, x
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:292:   return (__m256) __builtin_ia32_minps256 ((__v8sf)__A, (__v8sf)__B);
	vminps	%ymm1, %ymm0, %ymm0	 # tmp126, x, _6
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:280:   return (__m256) __builtin_ia32_maxps256 ((__v8sf)__A, (__v8sf)__B);
	vbroadcastss	.LC34(%rip), %ymm1	 #, tmp133
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:27: KW __m256 avx2k_exp10_ps (__m256 x) { return avx2_exp10_ps(x); }
	movq	%rcx, %rax	 # .result_ptr, .result_ptr
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:280:   return (__m256) __builtin_ia32_maxps256 ((__v8sf)__A, (__v8sf)__B);
	vmaxps	%ymm1, %ymm0, %ymm0	 # tmp133, _6, _8
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vbroadcastss	.LC36(%rip), %ymm1	 #, tmp142
	vmulps	%ymm1, %ymm0, %ymm1	 # tmp142, _8, _9
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:1010:   return (__m256) __builtin_ia32_roundps256 ((__v8sf)__V, __M);
	vroundps	$8, %ymm1, %ymm1	 #, _9, tmp139
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:161:   return (__m256)__builtin_ia32_vfnmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vfnmadd231ps	%ymm2, %ymm1, %ymm0	 # tmp145, tmp139, tmp143
	vbroadcastss	.LC40(%rip), %ymm2	 #, tmp148
	vfnmadd132ps	%ymm1, %ymm0, %ymm2	 # tmp139, tmp143, tmp146
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:443:   return (__m256i)__builtin_ia32_cvttps2dq256 ((__v8sf) __A);
	vcvttps2dq	%ymm1, %ymm1	 # tmp139, tmp170
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vbroadcastss	.LC42(%rip), %ymm0	 #, tmp150
	vmulps	%ymm0, %ymm2, %ymm2	 # tmp150, tmp146, _13
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vbroadcastss	.LC11(%rip), %ymm0	 #, tmp153
	vfmadd132ps	%ymm2, %ymm3, %ymm0	 # _13, tmp155, tmp151
	vbroadcastss	.LC15(%rip), %ymm3	 #, tmp158
	vfmadd132ps	%ymm2, %ymm3, %ymm0	 # _13, tmp158, tmp156
	vbroadcastss	.LC17(%rip), %ymm3	 #, tmp161
	vfmadd132ps	%ymm2, %ymm3, %ymm0	 # _13, tmp161, tmp159
	vbroadcastss	.LC19(%rip), %ymm3	 #, tmp164
	vfmadd132ps	%ymm2, %ymm3, %ymm0	 # _13, tmp164, tmp162
	vbroadcastss	.LC21(%rip), %ymm3	 #, tmp167
	vfmadd132ps	%ymm2, %ymm3, %ymm0	 # _13, tmp167, tmp165
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vmulps	%ymm2, %ymm2, %ymm3	 # _13, _13, _14
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vfmadd132ps	%ymm3, %ymm2, %ymm0	 # _14, _13, tmp168
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:121:   return (__m256i) ((__v8su)__A + (__v8su)__B);
	vpcmpeqd	%ymm2, %ymm2, %ymm2	 # tmp175
	vpsrld	$25, %ymm2, %ymm2	 #, tmp175, tmp174
	vpaddd	%ymm2, %ymm1, %ymm1	 # tmp174, tmp170, _24
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:133:   return (__m256) ((__v8sf)__A + (__v8sf)__B);
	vbroadcastss	.LC24(%rip), %ymm2	 #, tmp178
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:684:   return (__m256i)__builtin_ia32_pslldi256 ((__v8si)__A, __B);
	vpslld	$23, %ymm1, %ymm1	 #, _24, tmp171
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:133:   return (__m256) ((__v8sf)__A + (__v8sf)__B);
	vaddps	%ymm2, %ymm0, %ymm0	 # tmp178, tmp168, _21
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vmulps	%ymm1, %ymm0, %ymm0	 # tmp171, _21, _28
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:27: KW __m256 avx2k_exp10_ps (__m256 x) { return avx2_exp10_ps(x); }
	vmovups	%ymm0, (%rcx)	 # _28, <retval>
	vzeroupper
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:27: KW __m256 avx2k_exp10_ps (__m256 x) { return avx2_exp10_ps(x); }
	ret	
	.seh_endproc
	.p2align 4
	.globl	avx2k_expm1_ps
	.def	avx2k_expm1_ps;	.scl	2;	.type	32;	.endef
	.seh_proc	avx2k_expm1_ps
avx2k_expm1_ps:
	subq	$104, %rsp	 #,
	.seh_stackalloc	104
	vmovups	%xmm6, (%rsp)	 #,
	.seh_savexmm	%xmm6, 0
	vmovups	%xmm7, 16(%rsp)	 #,
	.seh_savexmm	%xmm7, 16
	vmovups	%xmm8, 32(%rsp)	 #,
	.seh_savexmm	%xmm8, 32
	vmovups	%xmm9, 48(%rsp)	 #,
	.seh_savexmm	%xmm9, 48
	vmovups	%xmm10, 64(%rsp)	 #,
	.seh_savexmm	%xmm10, 64
	vmovups	%xmm11, 80(%rsp)	 #,
	.seh_savexmm	%xmm11, 80
	.seh_endprologue
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:292:   return (__m256) __builtin_ia32_minps256 ((__v8sf)__A, (__v8sf)__B);
	vbroadcastss	.LC44(%rip), %ymm7	 #, tmp155
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vbroadcastss	.LC5(%rip), %ymm1	 #, tmp164
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:161:   return (__m256)__builtin_ia32_vfnmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vbroadcastss	.LC7(%rip), %ymm0	 #, tmp167
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vbroadcastss	.LC13(%rip), %ymm4	 #, tmp175
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:352:   return (__m256) ((__v8sf)__A - (__v8sf)__B);
	vbroadcastss	.LC46(%rip), %ymm8	 #, tmp198
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:28: KW __m256 avx2k_expm1_ps (__m256 x) { return avx2_expm1_ps(x); }
	vmovups	(%rdx), %ymm3	 # x, x
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:170:   return (__m256) __builtin_ia32_andnps256 ((__v8sf)__A, (__v8sf)__B);
	vbroadcastss	.LC48(%rip), %ymm11	 #, tmp209
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:292:   return (__m256) __builtin_ia32_minps256 ((__v8sf)__A, (__v8sf)__B);
	vminps	%ymm7, %ymm3, %ymm2	 # tmp155, x, _6
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vcmpps	$14, %ymm7, %ymm3, %ymm10	 #, tmp155, x, tmp216
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:170:   return (__m256) __builtin_ia32_andnps256 ((__v8sf)__A, (__v8sf)__B);
	vandnps	%ymm3, %ymm11, %ymm11	 # x, tmp209, tmp207
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vcmpps	$3, %ymm3, %ymm3, %ymm7	 #, x, x, tmp219
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:28: KW __m256 avx2k_expm1_ps (__m256 x) { return avx2_expm1_ps(x); }
	movq	%rcx, %rax	 # .result_ptr, .result_ptr
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vmulps	%ymm1, %ymm2, %ymm1	 # tmp164, _6, _7
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:1010:   return (__m256) __builtin_ia32_roundps256 ((__v8sf)__V, __M);
	vroundps	$8, %ymm1, %ymm1	 #, _7, tmp161
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:161:   return (__m256)__builtin_ia32_vfnmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vfnmadd132ps	%ymm1, %ymm2, %ymm0	 # tmp161, _6, tmp165
	vbroadcastss	.LC9(%rip), %ymm2	 #, tmp170
	vfnmadd132ps	%ymm1, %ymm0, %ymm2	 # tmp161, tmp165, tmp168
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:443:   return (__m256i)__builtin_ia32_cvttps2dq256 ((__v8sf) __A);
	vcvttps2dq	%ymm1, %ymm1	 # tmp161, tmp190
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vbroadcastss	.LC11(%rip), %ymm0	 #, tmp173
	vfmadd132ps	%ymm2, %ymm4, %ymm0	 # tmp168, tmp175, tmp171
	vbroadcastss	.LC15(%rip), %ymm4	 #, tmp178
	vfmadd132ps	%ymm2, %ymm4, %ymm0	 # tmp168, tmp178, tmp176
	vbroadcastss	.LC17(%rip), %ymm4	 #, tmp181
	vfmadd132ps	%ymm2, %ymm4, %ymm0	 # tmp168, tmp181, tmp179
	vbroadcastss	.LC19(%rip), %ymm4	 #, tmp184
	vfmadd132ps	%ymm2, %ymm4, %ymm0	 # tmp168, tmp184, tmp182
	vbroadcastss	.LC21(%rip), %ymm4	 #, tmp187
	vfmadd132ps	%ymm2, %ymm4, %ymm0	 # tmp168, tmp187, tmp185
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vmulps	%ymm2, %ymm2, %ymm4	 # tmp168, tmp168, _11
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vfmadd132ps	%ymm4, %ymm2, %ymm0	 # _11, tmp168, tmp188
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:121:   return (__m256i) ((__v8su)__A + (__v8su)__B);
	vpcmpeqd	%ymm2, %ymm2, %ymm2	 # tmp193
	vpsrld	$25, %ymm2, %ymm9	 #, tmp193, tmp192
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:275:   return (__m256i) ((__v8si)__A > (__v8si)__B);
	vpsrld	$26, %ymm2, %ymm2	 #, tmp193, tmp239
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:121:   return (__m256i) ((__v8su)__A + (__v8su)__B);
	vpaddd	%ymm9, %ymm1, %ymm6	 # tmp192, tmp190, _20
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:684:   return (__m256i)__builtin_ia32_pslldi256 ((__v8si)__A, __B);
	vpslld	$23, %ymm6, %ymm4	 #, _20, tmp194
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:352:   return (__m256) ((__v8sf)__A - (__v8sf)__B);
	vaddps	%ymm4, %ymm8, %ymm5	 # tmp194, tmp198, _24
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vfmadd132ps	%ymm0, %ymm5, %ymm4	 # tmp188, _24, tmp195
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:726:   return (__m256i)__builtin_ia32_psradi256 ((__v8si)__A, __B);
	vpsrad	$1, %ymm1, %ymm5	 #, tmp190, tmp199
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:275:   return (__m256i) ((__v8si)__A > (__v8si)__B);
	vpcmpgtd	%ymm2, %ymm1, %ymm1	 # tmp239, tmp190, tmp241
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:121:   return (__m256i) ((__v8su)__A + (__v8su)__B);
	vpsubd	%ymm5, %ymm6, %ymm6	 # tmp199, _20, _29
	vpaddd	%ymm9, %ymm5, %ymm5	 # tmp192, tmp199, _33
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:133:   return (__m256) ((__v8sf)__A + (__v8sf)__B);
	vbroadcastss	.LC24(%rip), %ymm2	 #, tmp245
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:684:   return (__m256i)__builtin_ia32_pslldi256 ((__v8si)__A, __B);
	vpslld	$23, %ymm6, %ymm6	 #, _29, tmp200
	vpslld	$23, %ymm5, %ymm5	 #, _33, tmp202
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vbroadcastss	.LC50(%rip), %ymm9	 #, tmp212
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:133:   return (__m256) ((__v8sf)__A + (__v8sf)__B);
	vaddps	%ymm2, %ymm0, %ymm2	 # tmp245, tmp188, _37
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vcmpps	$1, %ymm9, %ymm11, %ymm11	 #, tmp212, tmp207, tmp210
	vbroadcastss	.LC52(%rip), %ymm9	 #, tmp215
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vmulps	%ymm6, %ymm2, %ymm2	 # tmp200, _37, _38
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vcmpps	$1, %ymm9, %ymm3, %ymm9	 #, tmp215, x, tmp213
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:28: KW __m256 avx2k_expm1_ps (__m256 x) { return avx2_expm1_ps(x); }
	vfmadd132ps	%ymm2, %ymm8, %ymm5	 # _38, tmp198, tmp242
	vblendvps	%ymm1, %ymm5, %ymm4, %ymm0	 # tmp241, tmp242, tmp195, tmp236
	vbroadcastss	.LC55(%rip), %ymm1	 #, tmp252
	vblendvps	%ymm11, %ymm3, %ymm0, %ymm0	 # tmp210, x, tmp236, tmp232
	vblendvps	%ymm9, %ymm8, %ymm0, %ymm0	 # tmp213, tmp198, tmp232, tmp228
	vblendvps	%ymm10, %ymm1, %ymm0, %ymm0	 # tmp216, tmp252, tmp228, tmp224
	vblendvps	%ymm7, %ymm3, %ymm0, %ymm0	 # tmp219, x, tmp224, tmp220
	vmovups	%ymm0, (%rcx)	 # tmp220, <retval>
	vzeroupper
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:28: KW __m256 avx2k_expm1_ps (__m256 x) { return avx2_expm1_ps(x); }
	vmovups	(%rsp), %xmm6	 #,
	vmovups	16(%rsp), %xmm7	 #,
	vmovups	32(%rsp), %xmm8	 #,
	vmovups	48(%rsp), %xmm9	 #,
	vmovups	64(%rsp), %xmm10	 #,
	vmovups	80(%rsp), %xmm11	 #,
	addq	$104, %rsp	 #,
	ret	
	.seh_endproc
	.p2align 4
	.globl	avx2k_log_ps
	.def	avx2k_log_ps;	.scl	2;	.type	32;	.endef
	.seh_proc	avx2k_log_ps
avx2k_log_ps:
	subq	$24, %rsp	 #,
	.seh_stackalloc	24
	vmovups	%xmm6, (%rsp)	 #,
	.seh_savexmm	%xmm6, 0
	.seh_endprologue
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vxorps	%xmm2, %xmm2, %xmm2	 # tmp136
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:280:   return (__m256) __builtin_ia32_maxps256 ((__v8sf)__A, (__v8sf)__B);
	vbroadcastss	.LC57(%rip), %ymm1	 #, tmp138
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:316:   return (__m256) __builtin_ia32_orps256 ((__v8sf)__A, (__v8sf)__B);
	vbroadcastss	.LC21(%rip), %ymm4	 #, tmp150
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:158:   return (__m256) __builtin_ia32_andps256 ((__v8sf)__A, (__v8sf)__B);
	vbroadcastss	.LC24(%rip), %ymm5	 #, tmp162
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:29: KW __m256 avx2k_log_ps   (__m256 x) { return avx2_log_ps(x); }
	vmovups	(%rdx), %ymm0	 # x, x
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:817:   return (__m256i) ((__v8su)__A - (__v8su)__B);
	movl	$-127, %edx	 #, tmp155
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vcmpps	$2, %ymm2, %ymm0, %ymm2	 #, tmp136, x, tmp135
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:280:   return (__m256) __builtin_ia32_maxps256 ((__v8sf)__A, (__v8sf)__B);
	vmaxps	%ymm1, %ymm0, %ymm0	 # tmp138, x, _7
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:158:   return (__m256) __builtin_ia32_andps256 ((__v8sf)__A, (__v8sf)__B);
	vbroadcastss	.LC59(%rip), %ymm1	 #, tmp147
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:29: KW __m256 avx2k_log_ps   (__m256 x) { return avx2_log_ps(x); }
	movq	%rcx, %rax	 # .result_ptr, .result_ptr
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:775:   return (__m256i)__builtin_ia32_psrldi256 ((__v8si)__A, __B);
	vpsrld	$23, %ymm0, %ymm3	 #, _7, tmp144
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:158:   return (__m256) __builtin_ia32_andps256 ((__v8sf)__A, (__v8sf)__B);
	vandps	%ymm1, %ymm0, %ymm0	 # tmp147, _7, tmp145
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:817:   return (__m256i) ((__v8su)__A - (__v8su)__B);
	vmovd	%edx, %xmm1	 # tmp155, tmp154
	vpbroadcastd	%xmm1, %ymm1	 # tmp154, tmp154
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:316:   return (__m256) __builtin_ia32_orps256 ((__v8sf)__A, (__v8sf)__B);
	vorps	%ymm4, %ymm0, %ymm0	 # tmp150, tmp145, tmp148
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:817:   return (__m256i) ((__v8su)__A - (__v8su)__B);
	vpaddd	%ymm1, %ymm3, %ymm3	 # tmp154, tmp144, _13
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vbroadcastss	.LC62(%rip), %ymm1	 #, tmp158
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:407:   return (__m256)__builtin_ia32_cvtdq2ps256 ((__v8si) __A);
	vcvtdq2ps	%ymm3, %ymm3	 # _13, tmp151
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:133:   return (__m256) ((__v8sf)__A + (__v8sf)__B);
	vaddps	%ymm5, %ymm3, %ymm3	 # tmp162, tmp151, _16
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vcmpps	$1, %ymm1, %ymm0, %ymm1	 #, tmp158, tmp148, tmp156
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:158:   return (__m256) __builtin_ia32_andps256 ((__v8sf)__A, (__v8sf)__B);
	vandps	%ymm1, %ymm0, %ymm6	 # tmp156, tmp148, tmp159
	vandps	%ymm1, %ymm5, %ymm1	 # tmp156, tmp162, tmp160
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:352:   return (__m256) ((__v8sf)__A - (__v8sf)__B);
	vsubps	%ymm1, %ymm3, %ymm3	 # tmp160, _16, _21
	vbroadcastss	.LC46(%rip), %ymm1	 #, tmp168
	vaddps	%ymm1, %ymm0, %ymm0	 # tmp168, tmp148, _19
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vbroadcastss	.LC64(%rip), %ymm1	 #, tmp171
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:133:   return (__m256) ((__v8sf)__A + (__v8sf)__B);
	vaddps	%ymm6, %ymm0, %ymm0	 # tmp159, _19, _22
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vbroadcastss	.LC66(%rip), %ymm6	 #, tmp173
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vmulps	%ymm0, %ymm0, %ymm5	 # _22, _22, _23
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vfmadd132ps	%ymm0, %ymm6, %ymm1	 # _22, tmp173, tmp169
	vbroadcastss	.LC68(%rip), %ymm6	 #, tmp176
	vfmadd132ps	%ymm0, %ymm6, %ymm1	 # _22, tmp176, tmp174
	vbroadcastss	.LC70(%rip), %ymm6	 #, tmp179
	vfmadd132ps	%ymm0, %ymm6, %ymm1	 # _22, tmp179, tmp177
	vbroadcastss	.LC72(%rip), %ymm6	 #, tmp182
	vfmadd132ps	%ymm0, %ymm6, %ymm1	 # _22, tmp182, tmp180
	vbroadcastss	.LC74(%rip), %ymm6	 #, tmp185
	vfmadd132ps	%ymm0, %ymm6, %ymm1	 # _22, tmp185, tmp183
	vbroadcastss	.LC76(%rip), %ymm6	 #, tmp188
	vfmadd132ps	%ymm0, %ymm6, %ymm1	 # _22, tmp188, tmp186
	vbroadcastss	.LC78(%rip), %ymm6	 #, tmp191
	vfmadd132ps	%ymm0, %ymm6, %ymm1	 # _22, tmp191, tmp189
	vbroadcastss	.LC80(%rip), %ymm6	 #, tmp194
	vfmadd132ps	%ymm0, %ymm6, %ymm1	 # _22, tmp194, tmp192
	vbroadcastss	.LC9(%rip), %ymm6	 #, tmp197
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vmulps	%ymm1, %ymm0, %ymm1	 # tmp192, _22, _32
	vmulps	%ymm5, %ymm1, %ymm1	 # _23, _32, _33
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vfmadd231ps	%ymm6, %ymm3, %ymm1	 # tmp197, _21, tmp195
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:161:   return (__m256)__builtin_ia32_vfnmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vfnmadd132ps	%ymm4, %ymm1, %ymm5	 # tmp150, tmp195, tmp200
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vbroadcastss	.LC7(%rip), %ymm1	 #, tmp205
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:133:   return (__m256) ((__v8sf)__A + (__v8sf)__B);
	vaddps	%ymm5, %ymm0, %ymm0	 # tmp200, _22, _36
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vfmadd132ps	%ymm1, %ymm0, %ymm3	 # tmp205, _36, tmp203
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:316:   return (__m256) __builtin_ia32_orps256 ((__v8sf)__A, (__v8sf)__B);
	vorps	%ymm2, %ymm3, %ymm3	 # tmp135, tmp203, tmp207
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:29: KW __m256 avx2k_log_ps   (__m256 x) { return avx2_log_ps(x); }
	vmovups	%ymm3, (%rcx)	 # tmp207, <retval>
	vzeroupper
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:29: KW __m256 avx2k_log_ps   (__m256 x) { return avx2_log_ps(x); }
	vmovups	(%rsp), %xmm6	 #,
	addq	$24, %rsp	 #,
	ret	
	.seh_endproc
	.p2align 4
	.globl	avx2k_log2_ps
	.def	avx2k_log2_ps;	.scl	2;	.type	32;	.endef
	.seh_proc	avx2k_log2_ps
avx2k_log2_ps:
	subq	$56, %rsp	 #,
	.seh_stackalloc	56
	vmovups	%xmm6, (%rsp)	 #,
	.seh_savexmm	%xmm6, 0
	vmovups	%xmm7, 16(%rsp)	 #,
	.seh_savexmm	%xmm7, 16
	vmovups	%xmm8, 32(%rsp)	 #,
	.seh_savexmm	%xmm8, 32
	.seh_endprologue
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vxorps	%xmm5, %xmm5, %xmm5	 # tmp135
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:280:   return (__m256) __builtin_ia32_maxps256 ((__v8sf)__A, (__v8sf)__B);
	vbroadcastss	.LC57(%rip), %ymm1	 #, tmp137
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:316:   return (__m256) __builtin_ia32_orps256 ((__v8sf)__A, (__v8sf)__B);
	vbroadcastss	.LC21(%rip), %ymm7	 #, tmp149
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vbroadcastss	.LC62(%rip), %ymm3	 #, tmp157
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:352:   return (__m256) ((__v8sf)__A - (__v8sf)__B);
	vbroadcastss	.LC46(%rip), %ymm4	 #, tmp164
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vbroadcastss	.LC66(%rip), %ymm8	 #, tmp169
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:30: KW __m256 avx2k_log2_ps  (__m256 x) { return avx2_log2_ps(x); }
	vmovups	(%rdx), %ymm0	 # x, x
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:817:   return (__m256i) ((__v8su)__A - (__v8su)__B);
	movl	$-127, %edx	 #, tmp154
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:158:   return (__m256) __builtin_ia32_andps256 ((__v8sf)__A, (__v8sf)__B);
	vbroadcastss	.LC24(%rip), %ymm6	 #, tmp161
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vcmpps	$2, %ymm5, %ymm0, %ymm5	 #, tmp135, x, tmp134
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:280:   return (__m256) __builtin_ia32_maxps256 ((__v8sf)__A, (__v8sf)__B);
	vmaxps	%ymm1, %ymm0, %ymm0	 # tmp137, x, _14
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:158:   return (__m256) __builtin_ia32_andps256 ((__v8sf)__A, (__v8sf)__B);
	vbroadcastss	.LC59(%rip), %ymm1	 #, tmp146
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:30: KW __m256 avx2k_log2_ps  (__m256 x) { return avx2_log2_ps(x); }
	movq	%rcx, %rax	 # .result_ptr, .result_ptr
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:775:   return (__m256i)__builtin_ia32_psrldi256 ((__v8si)__A, __B);
	vpsrld	$23, %ymm0, %ymm2	 #, _14, tmp143
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:158:   return (__m256) __builtin_ia32_andps256 ((__v8sf)__A, (__v8sf)__B);
	vandps	%ymm1, %ymm0, %ymm0	 # tmp146, _14, tmp144
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:817:   return (__m256i) ((__v8su)__A - (__v8su)__B);
	vmovd	%edx, %xmm1	 # tmp154, tmp153
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:316:   return (__m256) __builtin_ia32_orps256 ((__v8sf)__A, (__v8sf)__B);
	vorps	%ymm7, %ymm0, %ymm0	 # tmp149, tmp144, tmp147
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:817:   return (__m256i) ((__v8su)__A - (__v8su)__B);
	vpbroadcastd	%xmm1, %ymm1	 # tmp153, tmp153
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vcmpps	$1, %ymm3, %ymm0, %ymm3	 #, tmp157, tmp147, tmp155
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:817:   return (__m256i) ((__v8su)__A - (__v8su)__B);
	vpaddd	%ymm1, %ymm2, %ymm2	 # tmp153, tmp143, _20
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:407:   return (__m256)__builtin_ia32_cvtdq2ps256 ((__v8si) __A);
	vcvtdq2ps	%ymm2, %ymm2	 # _20, tmp150
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:133:   return (__m256) ((__v8sf)__A + (__v8sf)__B);
	vaddps	%ymm6, %ymm2, %ymm2	 # tmp161, tmp150, _23
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:158:   return (__m256) __builtin_ia32_andps256 ((__v8sf)__A, (__v8sf)__B);
	vandps	%ymm3, %ymm0, %ymm1	 # tmp155, tmp147, tmp158
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:352:   return (__m256) ((__v8sf)__A - (__v8sf)__B);
	vaddps	%ymm4, %ymm0, %ymm0	 # tmp164, tmp147, _26
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:158:   return (__m256) __builtin_ia32_andps256 ((__v8sf)__A, (__v8sf)__B);
	vandps	%ymm3, %ymm6, %ymm3	 # tmp155, tmp161, tmp159
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:352:   return (__m256) ((__v8sf)__A - (__v8sf)__B);
	vsubps	%ymm3, %ymm2, %ymm2	 # tmp159, _23, _28
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:133:   return (__m256) ((__v8sf)__A + (__v8sf)__B);
	vaddps	%ymm1, %ymm0, %ymm0	 # tmp158, _26, _29
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vbroadcastss	.LC64(%rip), %ymm1	 #, tmp167
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vmulps	%ymm0, %ymm0, %ymm4	 # _29, _29, _30
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vfmadd132ps	%ymm0, %ymm8, %ymm1	 # _29, tmp169, tmp165
	vbroadcastss	.LC68(%rip), %ymm8	 #, tmp172
	vfmadd132ps	%ymm0, %ymm8, %ymm1	 # _29, tmp172, tmp170
	vbroadcastss	.LC70(%rip), %ymm8	 #, tmp175
	vfmadd132ps	%ymm0, %ymm8, %ymm1	 # _29, tmp175, tmp173
	vbroadcastss	.LC72(%rip), %ymm8	 #, tmp178
	vfmadd132ps	%ymm0, %ymm8, %ymm1	 # _29, tmp178, tmp176
	vbroadcastss	.LC74(%rip), %ymm8	 #, tmp181
	vfmadd132ps	%ymm0, %ymm8, %ymm1	 # _29, tmp181, tmp179
	vbroadcastss	.LC76(%rip), %ymm8	 #, tmp184
	vfmadd132ps	%ymm0, %ymm8, %ymm1	 # _29, tmp184, tmp182
	vbroadcastss	.LC78(%rip), %ymm8	 #, tmp187
	vfmadd132ps	%ymm0, %ymm8, %ymm1	 # _29, tmp187, tmp185
	vbroadcastss	.LC80(%rip), %ymm8	 #, tmp190
	vfmadd132ps	%ymm0, %ymm8, %ymm1	 # _29, tmp190, tmp188
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vmulps	%ymm1, %ymm0, %ymm1	 # tmp188, _29, _39
	vmulps	%ymm4, %ymm1, %ymm1	 # _30, _39, _40
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:161:   return (__m256)__builtin_ia32_vfnmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vfnmadd132ps	%ymm7, %ymm1, %ymm4	 # tmp149, _40, tmp191
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vbroadcastss	.LC5(%rip), %ymm1	 #, tmp199
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:133:   return (__m256) ((__v8sf)__A + (__v8sf)__B);
	vaddps	%ymm4, %ymm0, %ymm0	 # tmp191, _29, _42
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vfmadd132ps	%ymm1, %ymm2, %ymm0	 # tmp199, _28, tmp196
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:316:   return (__m256) __builtin_ia32_orps256 ((__v8sf)__A, (__v8sf)__B);
	vorps	%ymm5, %ymm0, %ymm0	 # tmp134, tmp196, tmp204
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:30: KW __m256 avx2k_log2_ps  (__m256 x) { return avx2_log2_ps(x); }
	vmovups	%ymm0, (%rcx)	 # tmp204, <retval>
	vzeroupper
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:30: KW __m256 avx2k_log2_ps  (__m256 x) { return avx2_log2_ps(x); }
	vmovups	(%rsp), %xmm6	 #,
	vmovups	16(%rsp), %xmm7	 #,
	vmovups	32(%rsp), %xmm8	 #,
	addq	$56, %rsp	 #,
	ret	
	.seh_endproc
	.p2align 4
	.globl	avx2k_log10_ps
	.def	avx2k_log10_ps;	.scl	2;	.type	32;	.endef
	.seh_proc	avx2k_log10_ps
avx2k_log10_ps:
	subq	$56, %rsp	 #,
	.seh_stackalloc	56
	vmovups	%xmm6, (%rsp)	 #,
	.seh_savexmm	%xmm6, 0
	vmovups	%xmm7, 16(%rsp)	 #,
	.seh_savexmm	%xmm7, 16
	vmovups	%xmm8, 32(%rsp)	 #,
	.seh_savexmm	%xmm8, 32
	.seh_endprologue
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vxorps	%xmm5, %xmm5, %xmm5	 # tmp136
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:280:   return (__m256) __builtin_ia32_maxps256 ((__v8sf)__A, (__v8sf)__B);
	vbroadcastss	.LC57(%rip), %ymm1	 #, tmp138
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:316:   return (__m256) __builtin_ia32_orps256 ((__v8sf)__A, (__v8sf)__B);
	vbroadcastss	.LC21(%rip), %ymm7	 #, tmp150
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vbroadcastss	.LC62(%rip), %ymm3	 #, tmp158
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:352:   return (__m256) ((__v8sf)__A - (__v8sf)__B);
	vbroadcastss	.LC46(%rip), %ymm4	 #, tmp165
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vbroadcastss	.LC66(%rip), %ymm8	 #, tmp170
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:31: KW __m256 avx2k_log10_ps (__m256 x) { return avx2_log10_ps(x); }
	vmovups	(%rdx), %ymm0	 # x, x
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:817:   return (__m256i) ((__v8su)__A - (__v8su)__B);
	movl	$-127, %edx	 #, tmp155
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:158:   return (__m256) __builtin_ia32_andps256 ((__v8sf)__A, (__v8sf)__B);
	vbroadcastss	.LC24(%rip), %ymm6	 #, tmp162
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vcmpps	$2, %ymm5, %ymm0, %ymm5	 #, tmp136, x, tmp135
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:280:   return (__m256) __builtin_ia32_maxps256 ((__v8sf)__A, (__v8sf)__B);
	vmaxps	%ymm1, %ymm0, %ymm0	 # tmp138, x, _13
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:158:   return (__m256) __builtin_ia32_andps256 ((__v8sf)__A, (__v8sf)__B);
	vbroadcastss	.LC59(%rip), %ymm1	 #, tmp147
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:31: KW __m256 avx2k_log10_ps (__m256 x) { return avx2_log10_ps(x); }
	movq	%rcx, %rax	 # .result_ptr, .result_ptr
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:775:   return (__m256i)__builtin_ia32_psrldi256 ((__v8si)__A, __B);
	vpsrld	$23, %ymm0, %ymm2	 #, _13, tmp144
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:158:   return (__m256) __builtin_ia32_andps256 ((__v8sf)__A, (__v8sf)__B);
	vandps	%ymm1, %ymm0, %ymm0	 # tmp147, _13, tmp145
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:817:   return (__m256i) ((__v8su)__A - (__v8su)__B);
	vmovd	%edx, %xmm1	 # tmp155, tmp154
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:316:   return (__m256) __builtin_ia32_orps256 ((__v8sf)__A, (__v8sf)__B);
	vorps	%ymm7, %ymm0, %ymm0	 # tmp150, tmp145, tmp148
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:817:   return (__m256i) ((__v8su)__A - (__v8su)__B);
	vpbroadcastd	%xmm1, %ymm1	 # tmp154, tmp154
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vcmpps	$1, %ymm3, %ymm0, %ymm3	 #, tmp158, tmp148, tmp156
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:817:   return (__m256i) ((__v8su)__A - (__v8su)__B);
	vpaddd	%ymm1, %ymm2, %ymm2	 # tmp154, tmp144, _19
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:407:   return (__m256)__builtin_ia32_cvtdq2ps256 ((__v8si) __A);
	vcvtdq2ps	%ymm2, %ymm2	 # _19, tmp151
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:133:   return (__m256) ((__v8sf)__A + (__v8sf)__B);
	vaddps	%ymm6, %ymm2, %ymm2	 # tmp162, tmp151, _22
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:158:   return (__m256) __builtin_ia32_andps256 ((__v8sf)__A, (__v8sf)__B);
	vandps	%ymm3, %ymm0, %ymm1	 # tmp156, tmp148, tmp159
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:352:   return (__m256) ((__v8sf)__A - (__v8sf)__B);
	vaddps	%ymm4, %ymm0, %ymm0	 # tmp165, tmp148, _25
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:158:   return (__m256) __builtin_ia32_andps256 ((__v8sf)__A, (__v8sf)__B);
	vandps	%ymm3, %ymm6, %ymm3	 # tmp156, tmp162, tmp160
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:352:   return (__m256) ((__v8sf)__A - (__v8sf)__B);
	vsubps	%ymm3, %ymm2, %ymm2	 # tmp160, _22, _27
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:133:   return (__m256) ((__v8sf)__A + (__v8sf)__B);
	vaddps	%ymm1, %ymm0, %ymm0	 # tmp159, _25, _28
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vbroadcastss	.LC64(%rip), %ymm1	 #, tmp168
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vmulps	%ymm0, %ymm0, %ymm4	 # _28, _28, _29
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vfmadd132ps	%ymm0, %ymm8, %ymm1	 # _28, tmp170, tmp166
	vbroadcastss	.LC68(%rip), %ymm8	 #, tmp173
	vfmadd132ps	%ymm0, %ymm8, %ymm1	 # _28, tmp173, tmp171
	vbroadcastss	.LC70(%rip), %ymm8	 #, tmp176
	vfmadd132ps	%ymm0, %ymm8, %ymm1	 # _28, tmp176, tmp174
	vbroadcastss	.LC72(%rip), %ymm8	 #, tmp179
	vfmadd132ps	%ymm0, %ymm8, %ymm1	 # _28, tmp179, tmp177
	vbroadcastss	.LC74(%rip), %ymm8	 #, tmp182
	vfmadd132ps	%ymm0, %ymm8, %ymm1	 # _28, tmp182, tmp180
	vbroadcastss	.LC76(%rip), %ymm8	 #, tmp185
	vfmadd132ps	%ymm0, %ymm8, %ymm1	 # _28, tmp185, tmp183
	vbroadcastss	.LC78(%rip), %ymm8	 #, tmp188
	vfmadd132ps	%ymm0, %ymm8, %ymm1	 # _28, tmp188, tmp186
	vbroadcastss	.LC80(%rip), %ymm8	 #, tmp191
	vfmadd132ps	%ymm0, %ymm8, %ymm1	 # _28, tmp191, tmp189
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vmulps	%ymm1, %ymm0, %ymm1	 # tmp189, _28, _38
	vmulps	%ymm4, %ymm1, %ymm1	 # _29, _38, _39
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:161:   return (__m256)__builtin_ia32_vfnmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vfnmadd132ps	%ymm7, %ymm1, %ymm4	 # tmp150, _39, tmp192
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vbroadcastss	.LC84(%rip), %ymm1	 #, tmp207
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:133:   return (__m256) ((__v8sf)__A + (__v8sf)__B);
	vaddps	%ymm4, %ymm0, %ymm0	 # tmp192, _28, _41
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vmulps	%ymm1, %ymm0, %ymm0	 # tmp207, _41, _6
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vbroadcastss	.LC82(%rip), %ymm1	 #, tmp203
	vfmadd132ps	%ymm1, %ymm0, %ymm2	 # tmp203, _6, tmp197
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:316:   return (__m256) __builtin_ia32_orps256 ((__v8sf)__A, (__v8sf)__B);
	vorps	%ymm5, %ymm2, %ymm2	 # tmp135, tmp197, tmp208
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:31: KW __m256 avx2k_log10_ps (__m256 x) { return avx2_log10_ps(x); }
	vmovups	%ymm2, (%rcx)	 # tmp208, <retval>
	vzeroupper
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:31: KW __m256 avx2k_log10_ps (__m256 x) { return avx2_log10_ps(x); }
	vmovups	(%rsp), %xmm6	 #,
	vmovups	16(%rsp), %xmm7	 #,
	vmovups	32(%rsp), %xmm8	 #,
	addq	$56, %rsp	 #,
	ret	
	.seh_endproc
	.p2align 4
	.globl	avx2k_log1p_ps
	.def	avx2k_log1p_ps;	.scl	2;	.type	32;	.endef
	.seh_proc	avx2k_log1p_ps
avx2k_log1p_ps:
	subq	$88, %rsp	 #,
	.seh_stackalloc	88
	vmovups	%xmm6, (%rsp)	 #,
	.seh_savexmm	%xmm6, 0
	vmovups	%xmm7, 16(%rsp)	 #,
	.seh_savexmm	%xmm7, 16
	vmovups	%xmm8, 32(%rsp)	 #,
	.seh_savexmm	%xmm8, 32
	vmovups	%xmm9, 48(%rsp)	 #,
	.seh_savexmm	%xmm9, 48
	vmovups	%xmm10, 64(%rsp)	 #,
	.seh_savexmm	%xmm10, 64
	.seh_endprologue
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vxorps	%xmm8, %xmm8, %xmm8	 # tmp158
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:133:   return (__m256) ((__v8sf)__A + (__v8sf)__B);
	vbroadcastss	.LC24(%rip), %ymm5	 #, tmp156
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:280:   return (__m256) __builtin_ia32_maxps256 ((__v8sf)__A, (__v8sf)__B);
	vbroadcastss	.LC57(%rip), %ymm0	 #, tmp160
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:158:   return (__m256) __builtin_ia32_andps256 ((__v8sf)__A, (__v8sf)__B);
	vbroadcastss	.LC59(%rip), %ymm1	 #, tmp169
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:316:   return (__m256) __builtin_ia32_orps256 ((__v8sf)__A, (__v8sf)__B);
	vbroadcastss	.LC21(%rip), %ymm9	 #, tmp172
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:352:   return (__m256) ((__v8sf)__A - (__v8sf)__B);
	vbroadcastss	.LC46(%rip), %ymm6	 #, tmp190
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:32: KW __m256 avx2k_log1p_ps (__m256 x) { return avx2_log1p_ps(x); }
	vmovups	(%rdx), %ymm4	 # x, x
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:817:   return (__m256i) ((__v8su)__A - (__v8su)__B);
	movl	$-127, %edx	 #, tmp177
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vbroadcastss	.LC66(%rip), %ymm10	 #, tmp195
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:133:   return (__m256) ((__v8sf)__A + (__v8sf)__B);
	vaddps	%ymm5, %ymm4, %ymm2	 # tmp156, x, _5
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:32: KW __m256 avx2k_log1p_ps (__m256 x) { return avx2_log1p_ps(x); }
	movq	%rcx, %rax	 # .result_ptr, .result_ptr
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:280:   return (__m256) __builtin_ia32_maxps256 ((__v8sf)__A, (__v8sf)__B);
	vmaxps	%ymm0, %ymm2, %ymm0	 # tmp160, _5, _28
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vcmpps	$2, %ymm8, %ymm2, %ymm8	 #, tmp158, _5, tmp157
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:775:   return (__m256i)__builtin_ia32_psrldi256 ((__v8si)__A, __B);
	vpsrld	$23, %ymm0, %ymm3	 #, _28, tmp166
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:158:   return (__m256) __builtin_ia32_andps256 ((__v8sf)__A, (__v8sf)__B);
	vandps	%ymm1, %ymm0, %ymm0	 # tmp169, _28, tmp167
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:817:   return (__m256i) ((__v8su)__A - (__v8su)__B);
	vmovd	%edx, %xmm1	 # tmp177, tmp176
	vpbroadcastd	%xmm1, %ymm1	 # tmp176, tmp176
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:316:   return (__m256) __builtin_ia32_orps256 ((__v8sf)__A, (__v8sf)__B);
	vorps	%ymm9, %ymm0, %ymm0	 # tmp172, tmp167, tmp170
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:817:   return (__m256i) ((__v8su)__A - (__v8su)__B);
	vpaddd	%ymm1, %ymm3, %ymm3	 # tmp176, tmp166, _34
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vbroadcastss	.LC62(%rip), %ymm1	 #, tmp180
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:407:   return (__m256)__builtin_ia32_cvtdq2ps256 ((__v8si) __A);
	vcvtdq2ps	%ymm3, %ymm3	 # _34, tmp173
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:133:   return (__m256) ((__v8sf)__A + (__v8sf)__B);
	vaddps	%ymm5, %ymm3, %ymm3	 # tmp156, tmp173, _37
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vcmpps	$1, %ymm1, %ymm0, %ymm1	 #, tmp180, tmp170, tmp178
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:158:   return (__m256) __builtin_ia32_andps256 ((__v8sf)__A, (__v8sf)__B);
	vandps	%ymm1, %ymm0, %ymm7	 # tmp178, tmp170, tmp181
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:352:   return (__m256) ((__v8sf)__A - (__v8sf)__B);
	vaddps	%ymm6, %ymm0, %ymm0	 # tmp190, tmp170, _40
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:158:   return (__m256) __builtin_ia32_andps256 ((__v8sf)__A, (__v8sf)__B);
	vandps	%ymm1, %ymm5, %ymm1	 # tmp178, tmp156, tmp182
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:352:   return (__m256) ((__v8sf)__A - (__v8sf)__B);
	vsubps	%ymm1, %ymm3, %ymm3	 # tmp182, _37, _42
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vcmpps	$0, %ymm5, %ymm2, %ymm5	 #, tmp156, _5, tmp230
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vbroadcastss	.LC64(%rip), %ymm1	 #, tmp193
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:133:   return (__m256) ((__v8sf)__A + (__v8sf)__B);
	vaddps	%ymm7, %ymm0, %ymm0	 # tmp181, _40, _43
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vmulps	%ymm0, %ymm0, %ymm7	 # _43, _43, _44
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vfmadd132ps	%ymm0, %ymm10, %ymm1	 # _43, tmp195, tmp191
	vbroadcastss	.LC68(%rip), %ymm10	 #, tmp198
	vfmadd132ps	%ymm0, %ymm10, %ymm1	 # _43, tmp198, tmp196
	vbroadcastss	.LC70(%rip), %ymm10	 #, tmp201
	vfmadd132ps	%ymm0, %ymm10, %ymm1	 # _43, tmp201, tmp199
	vbroadcastss	.LC72(%rip), %ymm10	 #, tmp204
	vfmadd132ps	%ymm0, %ymm10, %ymm1	 # _43, tmp204, tmp202
	vbroadcastss	.LC74(%rip), %ymm10	 #, tmp207
	vfmadd132ps	%ymm0, %ymm10, %ymm1	 # _43, tmp207, tmp205
	vbroadcastss	.LC76(%rip), %ymm10	 #, tmp210
	vfmadd132ps	%ymm0, %ymm10, %ymm1	 # _43, tmp210, tmp208
	vbroadcastss	.LC78(%rip), %ymm10	 #, tmp213
	vfmadd132ps	%ymm0, %ymm10, %ymm1	 # _43, tmp213, tmp211
	vbroadcastss	.LC80(%rip), %ymm10	 #, tmp216
	vfmadd132ps	%ymm0, %ymm10, %ymm1	 # _43, tmp216, tmp214
	vbroadcastss	.LC9(%rip), %ymm10	 #, tmp219
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vmulps	%ymm1, %ymm0, %ymm1	 # tmp214, _43, _53
	vmulps	%ymm7, %ymm1, %ymm1	 # _44, _53, _54
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vfmadd231ps	%ymm10, %ymm3, %ymm1	 # tmp219, _42, tmp217
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:161:   return (__m256)__builtin_ia32_vfnmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vfnmadd132ps	%ymm9, %ymm1, %ymm7	 # tmp172, tmp217, tmp222
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vcmpps	$0, %ymm6, %ymm4, %ymm9	 #, tmp190, x, tmp233
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vbroadcastss	.LC7(%rip), %ymm1	 #, tmp227
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:133:   return (__m256) ((__v8sf)__A + (__v8sf)__B);
	vaddps	%ymm7, %ymm0, %ymm0	 # tmp222, _43, _57
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vfmadd132ps	%ymm1, %ymm0, %ymm3	 # tmp227, _57, tmp225
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:352:   return (__m256) ((__v8sf)__A - (__v8sf)__B);
	vaddps	%ymm6, %ymm2, %ymm0	 # tmp190, _5, _7
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vbroadcastss	.LC55(%rip), %ymm1	 #, tmp241
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:32: KW __m256 avx2k_log1p_ps (__m256 x) { return avx2_log1p_ps(x); }
	vbroadcastss	.LC86(%rip), %ymm2	 #, tmp264
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vcmpps	$0, %ymm1, %ymm4, %ymm7	 #, tmp241, x, tmp239
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:227:   return (__m256) ((__v8sf)__A / (__v8sf)__B);
	vdivps	%ymm0, %ymm4, %ymm0	 # _7, x, _8
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:316:   return (__m256) __builtin_ia32_orps256 ((__v8sf)__A, (__v8sf)__B);
	vorps	%ymm8, %ymm3, %ymm3	 # tmp157, tmp225, tmp229
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vcmpps	$1, %ymm6, %ymm4, %ymm8	 #, tmp190, x, tmp236
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vmulps	%ymm3, %ymm0, %ymm0	 # tmp229, _8, _9
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:32: KW __m256 avx2k_log1p_ps (__m256 x) { return avx2_log1p_ps(x); }
	vblendvps	%ymm5, %ymm4, %ymm0, %ymm0	 # tmp230, x, _9, tmp254
	vblendvps	%ymm9, %ymm2, %ymm0, %ymm0	 # tmp233, tmp264, tmp254, tmp250
	vbroadcastss	.LC88(%rip), %ymm2	 #, tmp266
	vblendvps	%ymm8, %ymm2, %ymm0, %ymm0	 # tmp236, tmp266, tmp250, tmp246
	vblendvps	%ymm7, %ymm1, %ymm0, %ymm0	 # tmp239, tmp241, tmp246, tmp242
	vmovups	%ymm0, (%rcx)	 # tmp242, <retval>
	vzeroupper
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:32: KW __m256 avx2k_log1p_ps (__m256 x) { return avx2_log1p_ps(x); }
	vmovups	(%rsp), %xmm6	 #,
	vmovups	16(%rsp), %xmm7	 #,
	vmovups	32(%rsp), %xmm8	 #,
	vmovups	48(%rsp), %xmm9	 #,
	vmovups	64(%rsp), %xmm10	 #,
	addq	$88, %rsp	 #,
	ret	
	.seh_endproc
	.p2align 4
	.globl	avx2k_tanh_ps
	.def	avx2k_tanh_ps;	.scl	2;	.type	32;	.endef
	.seh_proc	avx2k_tanh_ps
avx2k_tanh_ps:
	subq	$40, %rsp	 #,
	.seh_stackalloc	40
	vmovups	%xmm6, (%rsp)	 #,
	.seh_savexmm	%xmm6, 0
	vmovups	%xmm7, 16(%rsp)	 #,
	.seh_savexmm	%xmm7, 16
	.seh_endprologue
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:352:   return (__m256) ((__v8sf)__A - (__v8sf)__B);
	vxorps	%xmm0, %xmm0, %xmm0	 # tmp151
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:170:   return (__m256) __builtin_ia32_andnps256 ((__v8sf)__A, (__v8sf)__B);
	vbroadcastss	.LC48(%rip), %ymm5	 #, tmp145
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:352:   return (__m256) ((__v8sf)__A - (__v8sf)__B);
	vbroadcastss	.LC90(%rip), %ymm6	 #, tmp150
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:292:   return (__m256) __builtin_ia32_minps256 ((__v8sf)__A, (__v8sf)__B);
	vbroadcastss	.LC1(%rip), %ymm1	 #, tmp153
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:161:   return (__m256)__builtin_ia32_vfnmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vbroadcastss	.LC7(%rip), %ymm3	 #, tmp172
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vbroadcastss	.LC13(%rip), %ymm7	 #, tmp180
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:33: KW __m256 avx2k_tanh_ps  (__m256 x) { return avx2_tanh_ps(x); }
	vmovups	(%rdx), %ymm2	 # x, x
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:170:   return (__m256) __builtin_ia32_andnps256 ((__v8sf)__A, (__v8sf)__B);
	vandnps	%ymm2, %ymm5, %ymm4	 # x, tmp145, tmp143
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:158:   return (__m256) __builtin_ia32_andps256 ((__v8sf)__A, (__v8sf)__B);
	vandps	%ymm2, %ymm5, %ymm5	 # x, tmp145, tmp146
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:352:   return (__m256) ((__v8sf)__A - (__v8sf)__B);
	vfnmadd231ps	%ymm6, %ymm4, %ymm0	 # tmp150, tmp143, _8
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:33: KW __m256 avx2k_tanh_ps  (__m256 x) { return avx2_tanh_ps(x); }
	movq	%rcx, %rax	 # .result_ptr, .result_ptr
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:292:   return (__m256) __builtin_ia32_minps256 ((__v8sf)__A, (__v8sf)__B);
	vminps	%ymm1, %ymm0, %ymm0	 # tmp153, _8, _27
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:280:   return (__m256) __builtin_ia32_maxps256 ((__v8sf)__A, (__v8sf)__B);
	vbroadcastss	.LC3(%rip), %ymm1	 #, tmp160
	vmaxps	%ymm1, %ymm0, %ymm0	 # tmp160, _27, _29
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vbroadcastss	.LC5(%rip), %ymm1	 #, tmp169
	vmulps	%ymm1, %ymm0, %ymm1	 # tmp169, _29, _30
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:1010:   return (__m256) __builtin_ia32_roundps256 ((__v8sf)__V, __M);
	vroundps	$8, %ymm1, %ymm1	 #, _30, tmp166
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:161:   return (__m256)__builtin_ia32_vfnmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vfnmadd231ps	%ymm3, %ymm1, %ymm0	 # tmp172, tmp166, tmp170
	vbroadcastss	.LC9(%rip), %ymm3	 #, tmp175
	vfnmadd132ps	%ymm1, %ymm0, %ymm3	 # tmp166, tmp170, tmp173
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:443:   return (__m256i)__builtin_ia32_cvttps2dq256 ((__v8sf) __A);
	vcvttps2dq	%ymm1, %ymm1	 # tmp166, tmp195
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vbroadcastss	.LC11(%rip), %ymm0	 #, tmp178
	vfmadd132ps	%ymm3, %ymm7, %ymm0	 # tmp173, tmp180, tmp176
	vbroadcastss	.LC15(%rip), %ymm7	 #, tmp183
	vfmadd132ps	%ymm3, %ymm7, %ymm0	 # tmp173, tmp183, tmp181
	vbroadcastss	.LC17(%rip), %ymm7	 #, tmp186
	vfmadd132ps	%ymm3, %ymm7, %ymm0	 # tmp173, tmp186, tmp184
	vbroadcastss	.LC19(%rip), %ymm7	 #, tmp189
	vfmadd132ps	%ymm3, %ymm7, %ymm0	 # tmp173, tmp189, tmp187
	vbroadcastss	.LC21(%rip), %ymm7	 #, tmp192
	vfmadd132ps	%ymm3, %ymm7, %ymm0	 # tmp173, tmp192, tmp190
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vmulps	%ymm3, %ymm3, %ymm7	 # tmp173, tmp173, _34
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vfmadd132ps	%ymm7, %ymm3, %ymm0	 # _34, tmp173, tmp193
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:121:   return (__m256i) ((__v8su)__A + (__v8su)__B);
	vpcmpeqd	%ymm3, %ymm3, %ymm3	 # tmp200
	vpsrld	$25, %ymm3, %ymm3	 #, tmp200, tmp199
	vpaddd	%ymm3, %ymm1, %ymm1	 # tmp199, tmp195, _44
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:133:   return (__m256) ((__v8sf)__A + (__v8sf)__B);
	vbroadcastss	.LC24(%rip), %ymm3	 #, tmp203
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:684:   return (__m256i)__builtin_ia32_pslldi256 ((__v8si)__A, __B);
	vpslld	$23, %ymm1, %ymm1	 #, _44, tmp196
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:133:   return (__m256) ((__v8sf)__A + (__v8sf)__B);
	vaddps	%ymm3, %ymm0, %ymm0	 # tmp203, tmp193, _41
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vmulps	%ymm1, %ymm0, %ymm0	 # tmp196, _41, _48
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:133:   return (__m256) ((__v8sf)__A + (__v8sf)__B);
	vaddps	%ymm3, %ymm0, %ymm1	 # tmp203, _48, _10
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:227:   return (__m256) ((__v8sf)__A / (__v8sf)__B);
	vdivps	%ymm1, %ymm0, %ymm0	 # _10, _48, _11
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vmulps	%ymm2, %ymm2, %ymm1	 # x, x, _14
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:161:   return (__m256)__builtin_ia32_vfnmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vfnmadd132ps	%ymm0, %ymm3, %ymm6	 # _11, tmp203, tmp204
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vbroadcastss	.LC94(%rip), %ymm3	 #, tmp218
	vbroadcastss	.LC92(%rip), %ymm0	 #, tmp216
	vfmadd132ps	%ymm1, %ymm3, %ymm0	 # _14, tmp218, tmp214
	vbroadcastss	.LC96(%rip), %ymm3	 #, tmp221
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:316:   return (__m256) __builtin_ia32_orps256 ((__v8sf)__A, (__v8sf)__B);
	vorps	%ymm5, %ymm6, %ymm6	 # tmp146, tmp204, tmp213
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vfmadd132ps	%ymm1, %ymm3, %ymm0	 # _14, tmp221, tmp219
	vbroadcastss	.LC98(%rip), %ymm3	 #, tmp224
	vfmadd132ps	%ymm1, %ymm3, %ymm0	 # _14, tmp224, tmp222
	vbroadcastss	.LC100(%rip), %ymm3	 #, tmp227
	vfmadd132ps	%ymm1, %ymm3, %ymm0	 # _14, tmp227, tmp225
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vmulps	%ymm0, %ymm1, %ymm1	 # tmp225, _14, _19
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vbroadcastss	.LC102(%rip), %ymm0	 #, tmp233
	vcmpps	$1, %ymm0, %ymm4, %ymm4	 #, tmp233, tmp143, tmp231
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vfmadd132ps	%ymm1, %ymm2, %ymm2	 # _19, x, tmp228
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:316:   return (__m256) __builtin_ia32_orps256 ((__v8sf)__A, (__v8sf)__B);
	vorps	%ymm5, %ymm2, %ymm2	 # tmp146, tmp228, tmp230
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:33: KW __m256 avx2k_tanh_ps  (__m256 x) { return avx2_tanh_ps(x); }
	vblendvps	%ymm4, %ymm2, %ymm6, %ymm6	 # tmp231, tmp230, tmp213, tmp234
	vmovups	%ymm6, (%rcx)	 # tmp234, <retval>
	vzeroupper
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:33: KW __m256 avx2k_tanh_ps  (__m256 x) { return avx2_tanh_ps(x); }
	vmovups	(%rsp), %xmm6	 #,
	vmovups	16(%rsp), %xmm7	 #,
	addq	$40, %rsp	 #,
	ret	
	.seh_endproc
	.p2align 4
	.globl	avx2k_sigmoid_ps
	.def	avx2k_sigmoid_ps;	.scl	2;	.type	32;	.endef
	.seh_proc	avx2k_sigmoid_ps
avx2k_sigmoid_ps:
	.seh_endprologue
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vxorps	%xmm0, %xmm0, %xmm0	 # tmp137
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:170:   return (__m256) __builtin_ia32_andnps256 ((__v8sf)__A, (__v8sf)__B);
	vbroadcastss	.LC48(%rip), %ymm1	 #, tmp135
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:161:   return (__m256)__builtin_ia32_vfnmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vbroadcastss	.LC7(%rip), %ymm2	 #, tmp159
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vbroadcastss	.LC13(%rip), %ymm4	 #, tmp167
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:34: KW __m256 avx2k_sigmoid_ps(__m256 x){ return avx2_sigmoid_ps(x); }
	vmovups	(%rdx), %ymm3	 # x, x
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:170:   return (__m256) __builtin_ia32_andnps256 ((__v8sf)__A, (__v8sf)__B);
	vandnps	%ymm3, %ymm1, %ymm1	 # x, tmp135, tmp133
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vcmpps	$1, %ymm0, %ymm3, %ymm3	 #, tmp137, x, tmp136
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:352:   return (__m256) ((__v8sf)__A - (__v8sf)__B);
	vsubps	%ymm1, %ymm0, %ymm0	 # tmp133, tmp137, _7
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:292:   return (__m256) __builtin_ia32_minps256 ((__v8sf)__A, (__v8sf)__B);
	vbroadcastss	.LC1(%rip), %ymm1	 #, tmp140
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:34: KW __m256 avx2k_sigmoid_ps(__m256 x){ return avx2_sigmoid_ps(x); }
	movq	%rcx, %rax	 # .result_ptr, .result_ptr
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:292:   return (__m256) __builtin_ia32_minps256 ((__v8sf)__A, (__v8sf)__B);
	vminps	%ymm1, %ymm0, %ymm0	 # tmp140, _7, _16
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:280:   return (__m256) __builtin_ia32_maxps256 ((__v8sf)__A, (__v8sf)__B);
	vbroadcastss	.LC3(%rip), %ymm1	 #, tmp147
	vmaxps	%ymm1, %ymm0, %ymm0	 # tmp147, _16, _18
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vbroadcastss	.LC5(%rip), %ymm1	 #, tmp156
	vmulps	%ymm1, %ymm0, %ymm1	 # tmp156, _18, _19
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:1010:   return (__m256) __builtin_ia32_roundps256 ((__v8sf)__V, __M);
	vroundps	$8, %ymm1, %ymm1	 #, _19, tmp153
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:161:   return (__m256)__builtin_ia32_vfnmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vfnmadd231ps	%ymm2, %ymm1, %ymm0	 # tmp159, tmp153, tmp157
	vbroadcastss	.LC9(%rip), %ymm2	 #, tmp162
	vfnmadd132ps	%ymm1, %ymm0, %ymm2	 # tmp153, tmp157, tmp160
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:443:   return (__m256i)__builtin_ia32_cvttps2dq256 ((__v8sf) __A);
	vcvttps2dq	%ymm1, %ymm1	 # tmp153, tmp182
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vbroadcastss	.LC11(%rip), %ymm0	 #, tmp165
	vfmadd132ps	%ymm2, %ymm4, %ymm0	 # tmp160, tmp167, tmp163
	vbroadcastss	.LC15(%rip), %ymm4	 #, tmp170
	vfmadd132ps	%ymm2, %ymm4, %ymm0	 # tmp160, tmp170, tmp168
	vbroadcastss	.LC17(%rip), %ymm4	 #, tmp173
	vfmadd132ps	%ymm2, %ymm4, %ymm0	 # tmp160, tmp173, tmp171
	vbroadcastss	.LC19(%rip), %ymm4	 #, tmp176
	vfmadd132ps	%ymm2, %ymm4, %ymm0	 # tmp160, tmp176, tmp174
	vbroadcastss	.LC21(%rip), %ymm4	 #, tmp179
	vfmadd132ps	%ymm2, %ymm4, %ymm0	 # tmp160, tmp179, tmp177
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vmulps	%ymm2, %ymm2, %ymm4	 # tmp160, tmp160, _23
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vfmadd132ps	%ymm4, %ymm2, %ymm0	 # _23, tmp160, tmp180
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:121:   return (__m256i) ((__v8su)__A + (__v8su)__B);
	vpcmpeqd	%ymm2, %ymm2, %ymm2	 # tmp187
	vpsrld	$25, %ymm2, %ymm2	 #, tmp187, tmp186
	vpaddd	%ymm2, %ymm1, %ymm1	 # tmp186, tmp182, _33
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:133:   return (__m256) ((__v8sf)__A + (__v8sf)__B);
	vbroadcastss	.LC24(%rip), %ymm2	 #, tmp190
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:684:   return (__m256i)__builtin_ia32_pslldi256 ((__v8si)__A, __B);
	vpslld	$23, %ymm1, %ymm1	 #, _33, tmp183
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:133:   return (__m256) ((__v8sf)__A + (__v8sf)__B);
	vaddps	%ymm2, %ymm0, %ymm0	 # tmp190, tmp180, _30
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vmulps	%ymm1, %ymm0, %ymm0	 # tmp183, _30, _37
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:133:   return (__m256) ((__v8sf)__A + (__v8sf)__B);
	vaddps	%ymm2, %ymm0, %ymm1	 # tmp190, _37, _9
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:227:   return (__m256) ((__v8sf)__A / (__v8sf)__B);
	vdivps	%ymm1, %ymm0, %ymm0	 # _9, _37, _10
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:352:   return (__m256) ((__v8sf)__A - (__v8sf)__B);
	vsubps	%ymm0, %ymm2, %ymm2	 # _10, tmp190, _11
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:34: KW __m256 avx2k_sigmoid_ps(__m256 x){ return avx2_sigmoid_ps(x); }
	vblendvps	%ymm3, %ymm0, %ymm2, %ymm2	 # tmp136, _10, _11, tmp194
	vmovups	%ymm2, (%rcx)	 # tmp194, <retval>
	vzeroupper
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:34: KW __m256 avx2k_sigmoid_ps(__m256 x){ return avx2_sigmoid_ps(x); }
	ret	
	.seh_endproc
	.p2align 4
	.globl	avx2k_rsqrt_ps
	.def	avx2k_rsqrt_ps;	.scl	2;	.type	32;	.endef
	.seh_proc	avx2k_rsqrt_ps
avx2k_rsqrt_ps:
	subq	$24, %rsp	 #,
	.seh_stackalloc	24
	vmovups	%xmm6, (%rsp)	 #,
	.seh_savexmm	%xmm6, 0
	.seh_endprologue
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vbroadcastss	.LC21(%rip), %ymm1	 #, tmp123
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:161:   return (__m256)__builtin_ia32_vfnmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vbroadcastss	.LC104(%rip), %ymm4	 #, tmp127
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:35: KW __m256 avx2k_rsqrt_ps (__m256 x) { return avx2_rsqrt_ps(x); }
	vmovups	(%rdx), %ymm2	 # x, x
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vmulps	%ymm1, %ymm2, %ymm1	 # tmp123, x, _6
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:985:   return (__m256) __builtin_ia32_rsqrtps256 ((__v8sf)__A);
	vrsqrtps	%ymm2, %ymm0	 # x, tmp121
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:35: KW __m256 avx2k_rsqrt_ps (__m256 x) { return avx2_rsqrt_ps(x); }
	movq	%rcx, %rax	 # .result_ptr, .result_ptr
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vmulps	%ymm1, %ymm0, %ymm3	 # _6, tmp121, _7
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:161:   return (__m256)__builtin_ia32_vfnmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vfnmadd132ps	%ymm0, %ymm4, %ymm3	 # tmp121, tmp127, tmp124
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vmulps	%ymm3, %ymm0, %ymm0	 # tmp124, tmp121, _9
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vxorps	%xmm3, %xmm3, %xmm3	 # tmp133
	vcmpps	$0, %ymm3, %ymm2, %ymm6	 #, tmp133, x, tmp132
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vmulps	%ymm0, %ymm1, %ymm1	 # _9, _6, _10
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:161:   return (__m256)__builtin_ia32_vfnmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vfnmadd132ps	%ymm0, %ymm4, %ymm1	 # _9, tmp127, tmp128
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vbroadcastss	.LC55(%rip), %ymm4	 #, tmp136
	vcmpps	$0, %ymm4, %ymm2, %ymm5	 #, tmp136, x, tmp134
	vcmpps	$1, %ymm3, %ymm2, %ymm2	 #, tmp133, x, tmp137
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vmulps	%ymm1, %ymm0, %ymm0	 # tmp128, _9, _12
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:35: KW __m256 avx2k_rsqrt_ps (__m256 x) { return avx2_rsqrt_ps(x); }
	vbroadcastss	.LC88(%rip), %ymm1	 #, tmp156
	vblendvps	%ymm6, %ymm4, %ymm0, %ymm0	 # tmp132, tmp136, _12, tmp147
	vblendvps	%ymm5, %ymm3, %ymm0, %ymm0	 # tmp134, tmp133, tmp147, tmp143
	vblendvps	%ymm2, %ymm1, %ymm0, %ymm0	 # tmp137, tmp156, tmp143, tmp139
	vmovups	%ymm0, (%rcx)	 # tmp139, <retval>
	vzeroupper
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:35: KW __m256 avx2k_rsqrt_ps (__m256 x) { return avx2_rsqrt_ps(x); }
	vmovups	(%rsp), %xmm6	 #,
	addq	$24, %rsp	 #,
	ret	
	.seh_endproc
	.p2align 4
	.globl	avx2k_sqrt_ps
	.def	avx2k_sqrt_ps;	.scl	2;	.type	32;	.endef
	.seh_proc	avx2k_sqrt_ps
avx2k_sqrt_ps:
	.seh_endprologue
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:997:   return (__m256) __builtin_ia32_sqrtps256 ((__v8sf)__A);
	vsqrtps	(%rdx), %ymm0	 # x, tmp102
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:36: KW __m256 avx2k_sqrt_ps  (__m256 x) { return avx2_sqrt_ps(x); }
	movq	%rcx, %rax	 # .result_ptr, .result_ptr
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:36: KW __m256 avx2k_sqrt_ps  (__m256 x) { return avx2_sqrt_ps(x); }
	vmovups	%ymm0, (%rcx)	 # tmp102, <retval>
	vzeroupper
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:36: KW __m256 avx2k_sqrt_ps  (__m256 x) { return avx2_sqrt_ps(x); }
	ret	
	.seh_endproc
	.p2align 4
	.globl	avx2k_cbrt_ps
	.def	avx2k_cbrt_ps;	.scl	2;	.type	32;	.endef
	.seh_proc	avx2k_cbrt_ps
avx2k_cbrt_ps:
	subq	$24, %rsp	 #,
	.seh_stackalloc	24
	vmovups	%xmm6, (%rsp)	 #,
	.seh_savexmm	%xmm6, 0
	.seh_endprologue
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:158:   return (__m256) __builtin_ia32_andps256 ((__v8sf)__A, (__v8sf)__B);
	vbroadcastss	.LC48(%rip), %ymm1	 #, tmp146
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:37: KW __m256 avx2k_cbrt_ps  (__m256 x) { return avx2_cbrt_ps(x); }
	vmovups	(%rdx), %ymm3	 # x, x
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:569:   return (__m256i)__builtin_ia32_pmuludq256 ((__v8si)__A, (__v8si)__B);
	movl	$-1431655765, %edx	 #, tmp153
	vmovd	%edx, %xmm5	 # tmp153, tmp152
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:121:   return (__m256i) ((__v8su)__A + (__v8su)__B);
	movl	$709967975, %edx	 #, tmp166
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:158:   return (__m256) __builtin_ia32_andps256 ((__v8sf)__A, (__v8sf)__B);
	vandps	%ymm1, %ymm3, %ymm4	 # tmp146, x, tmp144
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:170:   return (__m256) __builtin_ia32_andnps256 ((__v8sf)__A, (__v8sf)__B);
	vandnps	%ymm3, %ymm1, %ymm1	 # x, tmp146, tmp147
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:569:   return (__m256i)__builtin_ia32_pmuludq256 ((__v8si)__A, (__v8si)__B);
	vpbroadcastd	%xmm5, %ymm5	 # tmp152, tmp152
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:789:   return (__m256i)__builtin_ia32_psrlqi256 ((__v4di)__A, __B);
	vpsrlq	$32, %ymm1, %ymm2	 #, tmp147, tmp154
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:569:   return (__m256i)__builtin_ia32_pmuludq256 ((__v8si)__A, (__v8si)__B);
	vpmuludq	%ymm5, %ymm1, %ymm0	 # tmp152, tmp147, tmp150
	vpmuludq	%ymm5, %ymm2, %ymm2	 # tmp152, tmp154, tmp155
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:37: KW __m256 avx2k_cbrt_ps  (__m256 x) { return avx2_cbrt_ps(x); }
	movq	%rcx, %rax	 # .result_ptr, .result_ptr
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vbroadcastss	.LC90(%rip), %ymm5	 #, tmp170
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:789:   return (__m256i)__builtin_ia32_psrlqi256 ((__v4di)__A, __B);
	vpsrlq	$33, %ymm0, %ymm0	 #, tmp150, tmp159
	vpsrlq	$33, %ymm2, %ymm2	 #, tmp155, tmp160
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:698:   return (__m256i)__builtin_ia32_psllqi256 ((__v4di)__A, __B);
	vpsllq	$32, %ymm2, %ymm2	 #, tmp160, tmp161
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:576:   return (__m256i) ((__v4du)__A | (__v4du)__B);
	vpor	%ymm2, %ymm0, %ymm0	 # tmp161, tmp159, _18
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:121:   return (__m256i) ((__v8su)__A + (__v8su)__B);
	vmovd	%edx, %xmm2	 # tmp166, tmp165
	vpbroadcastd	%xmm2, %ymm2	 # tmp165, tmp165
	vpaddd	%ymm2, %ymm0, %ymm0	 # tmp165, _18, _20
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vmovaps	%ymm5, %ymm2	 # tmp170, tmp168
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vmulps	%ymm0, %ymm0, %ymm6	 # _20, _20, _46
	vmulps	%ymm0, %ymm6, %ymm6	 # _20, _46, _45
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vfmadd132ps	%ymm1, %ymm6, %ymm2	 # tmp147, _45, tmp168
	vfmadd132ps	%ymm5, %ymm1, %ymm6	 # tmp170, tmp147, tmp171
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:227:   return (__m256) ((__v8sf)__A / (__v8sf)__B);
	vdivps	%ymm6, %ymm2, %ymm2	 # tmp171, tmp168, _51
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vmulps	%ymm0, %ymm2, %ymm2	 # _20, _51, _52
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vmovaps	%ymm5, %ymm0	 # tmp170, tmp176
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vmulps	%ymm2, %ymm2, %ymm6	 # _52, _52, _56
	vmulps	%ymm2, %ymm6, %ymm6	 # _52, _56, _57
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vfmadd132ps	%ymm6, %ymm1, %ymm5	 # _57, tmp147, tmp179
	vfmadd132ps	%ymm1, %ymm6, %ymm0	 # tmp147, _57, tmp176
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vcmpps	$3, %ymm3, %ymm3, %ymm6	 #, x, x, tmp193
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:227:   return (__m256) ((__v8sf)__A / (__v8sf)__B);
	vdivps	%ymm5, %ymm0, %ymm0	 # tmp179, tmp176, _60
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vxorps	%xmm5, %xmm5, %xmm5	 # tmp186
	vcmpps	$0, %ymm5, %ymm1, %ymm5	 #, tmp186, tmp147, tmp185
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vmulps	%ymm2, %ymm0, %ymm0	 # _52, _60, _61
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vbroadcastss	.LC55(%rip), %ymm2	 #, tmp189
	vcmpps	$0, %ymm2, %ymm1, %ymm1	 #, tmp189, tmp147, tmp187
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:316:   return (__m256) __builtin_ia32_orps256 ((__v8sf)__A, (__v8sf)__B);
	vorps	%ymm4, %ymm2, %ymm2	 # tmp144, tmp189, tmp190
	vorps	%ymm4, %ymm0, %ymm0	 # tmp144, _61, tmp184
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:37: KW __m256 avx2k_cbrt_ps  (__m256 x) { return avx2_cbrt_ps(x); }
	vblendvps	%ymm5, %ymm4, %ymm0, %ymm0	 # tmp185, tmp144, tmp184, tmp202
	vblendvps	%ymm1, %ymm2, %ymm0, %ymm0	 # tmp187, tmp190, tmp202, tmp198
	vblendvps	%ymm6, %ymm3, %ymm0, %ymm0	 # tmp193, x, tmp198, tmp194
	vmovups	%ymm0, (%rcx)	 # tmp194, <retval>
	vzeroupper
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:37: KW __m256 avx2k_cbrt_ps  (__m256 x) { return avx2_cbrt_ps(x); }
	vmovups	(%rsp), %xmm6	 #,
	addq	$24, %rsp	 #,
	ret	
	.seh_endproc
	.p2align 4
	.globl	avx2k_softplus_ps
	.def	avx2k_softplus_ps;	.scl	2;	.type	32;	.endef
	.seh_proc	avx2k_softplus_ps
avx2k_softplus_ps:
	subq	$136, %rsp	 #,
	.seh_stackalloc	136
	vmovups	%xmm6, (%rsp)	 #,
	.seh_savexmm	%xmm6, 0
	vmovups	%xmm7, 16(%rsp)	 #,
	.seh_savexmm	%xmm7, 16
	vmovups	%xmm8, 32(%rsp)	 #,
	.seh_savexmm	%xmm8, 32
	vmovups	%xmm9, 48(%rsp)	 #,
	.seh_savexmm	%xmm9, 48
	vmovups	%xmm10, 64(%rsp)	 #,
	.seh_savexmm	%xmm10, 64
	vmovups	%xmm11, 80(%rsp)	 #,
	.seh_savexmm	%xmm11, 80
	vmovups	%xmm12, 96(%rsp)	 #,
	.seh_savexmm	%xmm12, 96
	vmovups	%xmm13, 112(%rsp)	 #,
	.seh_savexmm	%xmm13, 112
	.seh_endprologue
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:280:   return (__m256) __builtin_ia32_maxps256 ((__v8sf)__A, (__v8sf)__B);
	vxorps	%xmm7, %xmm7, %xmm7	 # tmp186
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:170:   return (__m256) __builtin_ia32_andnps256 ((__v8sf)__A, (__v8sf)__B);
	vbroadcastss	.LC48(%rip), %ymm0	 #, tmp185
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vbroadcastss	.LC5(%rip), %ymm2	 #, tmp208
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:161:   return (__m256)__builtin_ia32_vfnmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vbroadcastss	.LC7(%rip), %ymm12	 #, tmp211
	vbroadcastss	.LC9(%rip), %ymm10	 #, tmp214
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vbroadcastss	.LC13(%rip), %ymm3	 #, tmp219
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:38: KW __m256 avx2k_softplus_ps(__m256 x){ return avx2_softplus_ps(x); }
	vmovups	(%rdx), %ymm6	 # x, x
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:817:   return (__m256i) ((__v8su)__A - (__v8su)__B);
	movl	$-127, %edx	 #, tmp265
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vbroadcastss	.LC21(%rip), %ymm11	 #, tmp231
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:133:   return (__m256) ((__v8sf)__A + (__v8sf)__B);
	vbroadcastss	.LC24(%rip), %ymm5	 #, tmp242
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:280:   return (__m256) __builtin_ia32_maxps256 ((__v8sf)__A, (__v8sf)__B);
	vcmpltps	%ymm6, %ymm7, %ymm1	 #, x, tmp186, tmp189
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:170:   return (__m256) __builtin_ia32_andnps256 ((__v8sf)__A, (__v8sf)__B);
	vandnps	%ymm6, %ymm0, %ymm0	 # x, tmp185, tmp183
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:352:   return (__m256) ((__v8sf)__A - (__v8sf)__B);
	vbroadcastss	.LC46(%rip), %ymm8	 #, tmp278
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vbroadcastss	.LC66(%rip), %ymm13	 #, tmp283
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:352:   return (__m256) ((__v8sf)__A - (__v8sf)__B);
	vsubps	%ymm0, %ymm7, %ymm0	 # tmp183, tmp186, _8
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:38: KW __m256 avx2k_softplus_ps(__m256 x){ return avx2_softplus_ps(x); }
	movq	%rcx, %rax	 # .result_ptr, .result_ptr
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:280:   return (__m256) __builtin_ia32_maxps256 ((__v8sf)__A, (__v8sf)__B);
	vandps	%ymm1, %ymm6, %ymm6	 # tmp189, x, _7
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:292:   return (__m256) __builtin_ia32_minps256 ((__v8sf)__A, (__v8sf)__B);
	vbroadcastss	.LC1(%rip), %ymm1	 #, tmp192
	vminps	%ymm1, %ymm0, %ymm0	 # tmp192, _8, _34
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:280:   return (__m256) __builtin_ia32_maxps256 ((__v8sf)__A, (__v8sf)__B);
	vbroadcastss	.LC3(%rip), %ymm1	 #, tmp199
	vmaxps	%ymm1, %ymm0, %ymm0	 # tmp199, _34, _36
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vbroadcastss	.LC11(%rip), %ymm1	 #, tmp217
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vmulps	%ymm2, %ymm0, %ymm2	 # tmp208, _36, _37
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:1010:   return (__m256) __builtin_ia32_roundps256 ((__v8sf)__V, __M);
	vroundps	$8, %ymm2, %ymm2	 #, _37, tmp205
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:161:   return (__m256)__builtin_ia32_vfnmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vfnmadd231ps	%ymm12, %ymm2, %ymm0	 # tmp211, tmp205, tmp209
	vfnmadd231ps	%ymm10, %ymm2, %ymm0	 # tmp214, tmp205, tmp212
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:443:   return (__m256i)__builtin_ia32_cvttps2dq256 ((__v8sf) __A);
	vcvttps2dq	%ymm2, %ymm2	 # tmp205, tmp234
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vfmadd132ps	%ymm0, %ymm3, %ymm1	 # tmp212, tmp219, tmp215
	vbroadcastss	.LC15(%rip), %ymm3	 #, tmp222
	vfmadd132ps	%ymm0, %ymm3, %ymm1	 # tmp212, tmp222, tmp220
	vbroadcastss	.LC17(%rip), %ymm3	 #, tmp225
	vfmadd132ps	%ymm0, %ymm3, %ymm1	 # tmp212, tmp225, tmp223
	vbroadcastss	.LC19(%rip), %ymm3	 #, tmp228
	vfmadd132ps	%ymm0, %ymm3, %ymm1	 # tmp212, tmp228, tmp226
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vmulps	%ymm0, %ymm0, %ymm3	 # tmp212, tmp212, _41
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vfmadd132ps	%ymm0, %ymm11, %ymm1	 # tmp212, tmp231, tmp229
	vfmadd132ps	%ymm3, %ymm0, %ymm1	 # _41, tmp212, tmp232
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:121:   return (__m256i) ((__v8su)__A + (__v8su)__B);
	vpcmpeqd	%ymm0, %ymm0, %ymm0	 # tmp239
	vpsrld	$25, %ymm0, %ymm0	 #, tmp239, tmp238
	vpaddd	%ymm0, %ymm2, %ymm2	 # tmp238, tmp234, _51
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:280:   return (__m256) __builtin_ia32_maxps256 ((__v8sf)__A, (__v8sf)__B);
	vbroadcastss	.LC57(%rip), %ymm0	 #, tmp248
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:684:   return (__m256i)__builtin_ia32_pslldi256 ((__v8si)__A, __B);
	vpslld	$23, %ymm2, %ymm2	 #, _51, tmp235
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:133:   return (__m256) ((__v8sf)__A + (__v8sf)__B);
	vaddps	%ymm5, %ymm1, %ymm1	 # tmp242, tmp232, _48
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vmulps	%ymm2, %ymm1, %ymm1	 # tmp235, _48, _55
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:158:   return (__m256) __builtin_ia32_andps256 ((__v8sf)__A, (__v8sf)__B);
	vbroadcastss	.LC59(%rip), %ymm2	 #, tmp257
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:133:   return (__m256) ((__v8sf)__A + (__v8sf)__B);
	vaddps	%ymm5, %ymm1, %ymm3	 # tmp242, _55, _12
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:280:   return (__m256) __builtin_ia32_maxps256 ((__v8sf)__A, (__v8sf)__B);
	vmaxps	%ymm0, %ymm3, %ymm0	 # tmp248, _12, _58
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vcmpps	$2, %ymm7, %ymm3, %ymm7	 #, tmp186, _12, tmp245
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:775:   return (__m256i)__builtin_ia32_psrldi256 ((__v8si)__A, __B);
	vpsrld	$23, %ymm0, %ymm4	 #, _58, tmp254
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:158:   return (__m256) __builtin_ia32_andps256 ((__v8sf)__A, (__v8sf)__B);
	vandps	%ymm2, %ymm0, %ymm0	 # tmp257, _58, tmp255
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:817:   return (__m256i) ((__v8su)__A - (__v8su)__B);
	vmovd	%edx, %xmm2	 # tmp265, tmp264
	vpbroadcastd	%xmm2, %ymm2	 # tmp264, tmp264
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:316:   return (__m256) __builtin_ia32_orps256 ((__v8sf)__A, (__v8sf)__B);
	vorps	%ymm11, %ymm0, %ymm0	 # tmp231, tmp255, tmp258
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:817:   return (__m256i) ((__v8su)__A - (__v8su)__B);
	vpaddd	%ymm2, %ymm4, %ymm4	 # tmp264, tmp254, _64
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vbroadcastss	.LC62(%rip), %ymm2	 #, tmp268
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:407:   return (__m256)__builtin_ia32_cvtdq2ps256 ((__v8si) __A);
	vcvtdq2ps	%ymm4, %ymm4	 # _64, tmp261
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:133:   return (__m256) ((__v8sf)__A + (__v8sf)__B);
	vaddps	%ymm5, %ymm4, %ymm4	 # tmp242, tmp261, _67
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vcmpps	$1, %ymm2, %ymm0, %ymm2	 #, tmp268, tmp258, tmp266
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:158:   return (__m256) __builtin_ia32_andps256 ((__v8sf)__A, (__v8sf)__B);
	vandps	%ymm2, %ymm0, %ymm9	 # tmp266, tmp258, tmp269
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:352:   return (__m256) ((__v8sf)__A - (__v8sf)__B);
	vaddps	%ymm8, %ymm0, %ymm0	 # tmp278, tmp258, _70
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:158:   return (__m256) __builtin_ia32_andps256 ((__v8sf)__A, (__v8sf)__B);
	vandps	%ymm2, %ymm5, %ymm2	 # tmp266, tmp242, tmp270
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:352:   return (__m256) ((__v8sf)__A - (__v8sf)__B);
	vsubps	%ymm2, %ymm4, %ymm4	 # tmp270, _67, _72
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vcmpps	$0, %ymm5, %ymm3, %ymm5	 #, tmp242, _12, tmp318
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vbroadcastss	.LC64(%rip), %ymm2	 #, tmp281
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:133:   return (__m256) ((__v8sf)__A + (__v8sf)__B);
	vaddps	%ymm9, %ymm0, %ymm0	 # tmp269, _70, _73
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vmulps	%ymm0, %ymm0, %ymm9	 # _73, _73, _74
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vfmadd132ps	%ymm0, %ymm13, %ymm2	 # _73, tmp283, tmp279
	vbroadcastss	.LC68(%rip), %ymm13	 #, tmp286
	vfmadd132ps	%ymm0, %ymm13, %ymm2	 # _73, tmp286, tmp284
	vbroadcastss	.LC70(%rip), %ymm13	 #, tmp289
	vfmadd132ps	%ymm0, %ymm13, %ymm2	 # _73, tmp289, tmp287
	vbroadcastss	.LC72(%rip), %ymm13	 #, tmp292
	vfmadd132ps	%ymm0, %ymm13, %ymm2	 # _73, tmp292, tmp290
	vbroadcastss	.LC74(%rip), %ymm13	 #, tmp295
	vfmadd132ps	%ymm0, %ymm13, %ymm2	 # _73, tmp295, tmp293
	vbroadcastss	.LC76(%rip), %ymm13	 #, tmp298
	vfmadd132ps	%ymm0, %ymm13, %ymm2	 # _73, tmp298, tmp296
	vbroadcastss	.LC78(%rip), %ymm13	 #, tmp301
	vfmadd132ps	%ymm0, %ymm13, %ymm2	 # _73, tmp301, tmp299
	vbroadcastss	.LC80(%rip), %ymm13	 #, tmp304
	vfmadd132ps	%ymm0, %ymm13, %ymm2	 # _73, tmp304, tmp302
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vmulps	%ymm2, %ymm0, %ymm2	 # tmp302, _73, _83
	vmulps	%ymm9, %ymm2, %ymm2	 # _74, _83, _84
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vfmadd132ps	%ymm4, %ymm2, %ymm10	 # _72, _84, tmp305
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vbroadcastss	.LC55(%rip), %ymm2	 #, tmp329
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:161:   return (__m256)__builtin_ia32_vfnmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vfnmadd132ps	%ymm11, %ymm10, %ymm9	 # tmp231, tmp305, tmp310
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vcmpps	$0, %ymm8, %ymm1, %ymm10	 #, tmp278, _55, tmp321
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:133:   return (__m256) ((__v8sf)__A + (__v8sf)__B);
	vaddps	%ymm9, %ymm0, %ymm0	 # tmp310, _73, _87
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vcmpps	$1, %ymm8, %ymm1, %ymm9	 #, tmp278, _55, tmp324
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vfmadd132ps	%ymm12, %ymm0, %ymm4	 # tmp211, _87, tmp313
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:352:   return (__m256) ((__v8sf)__A - (__v8sf)__B);
	vaddps	%ymm8, %ymm3, %ymm0	 # tmp278, _12, _14
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:227:   return (__m256) ((__v8sf)__A / (__v8sf)__B);
	vdivps	%ymm0, %ymm1, %ymm0	 # _14, _55, _15
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:316:   return (__m256) __builtin_ia32_orps256 ((__v8sf)__A, (__v8sf)__B);
	vorps	%ymm7, %ymm4, %ymm4	 # tmp245, tmp313, tmp317
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vcmpps	$0, %ymm2, %ymm1, %ymm7	 #, tmp329, _55, tmp327
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vmulps	%ymm4, %ymm0, %ymm0	 # tmp317, _15, _16
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:133:   return (__m256) ((__v8sf)__A + (__v8sf)__B);
	vblendvps	%ymm5, %ymm1, %ymm0, %ymm0	 # tmp318, _55, _16, tmp342
	vbroadcastss	.LC86(%rip), %ymm1	 #, tmp352
	vblendvps	%ymm10, %ymm1, %ymm0, %ymm0	 # tmp321, tmp352, tmp342, tmp338
	vbroadcastss	.LC88(%rip), %ymm1	 #, tmp354
	vblendvps	%ymm9, %ymm1, %ymm0, %ymm0	 # tmp324, tmp354, tmp338, tmp334
	vblendvps	%ymm7, %ymm2, %ymm0, %ymm0	 # tmp327, tmp329, tmp334, tmp330
	vaddps	%ymm6, %ymm0, %ymm0	 # _7, tmp330, _11
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:38: KW __m256 avx2k_softplus_ps(__m256 x){ return avx2_softplus_ps(x); }
	vmovups	%ymm0, (%rcx)	 # _11, <retval>
	vzeroupper
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:38: KW __m256 avx2k_softplus_ps(__m256 x){ return avx2_softplus_ps(x); }
	vmovups	(%rsp), %xmm6	 #,
	vmovups	16(%rsp), %xmm7	 #,
	vmovups	32(%rsp), %xmm8	 #,
	vmovups	48(%rsp), %xmm9	 #,
	vmovups	64(%rsp), %xmm10	 #,
	vmovups	80(%rsp), %xmm11	 #,
	vmovups	96(%rsp), %xmm12	 #,
	vmovups	112(%rsp), %xmm13	 #,
	addq	$136, %rsp	 #,
	ret	
	.seh_endproc
	.p2align 4
	.globl	avx2k_gelu_ps
	.def	avx2k_gelu_ps;	.scl	2;	.type	32;	.endef
	.seh_proc	avx2k_gelu_ps
avx2k_gelu_ps:
	subq	$88, %rsp	 #,
	.seh_stackalloc	88
	vmovups	%xmm6, (%rsp)	 #,
	.seh_savexmm	%xmm6, 0
	vmovups	%xmm7, 16(%rsp)	 #,
	.seh_savexmm	%xmm7, 16
	vmovups	%xmm8, 32(%rsp)	 #,
	.seh_savexmm	%xmm8, 32
	vmovups	%xmm9, 48(%rsp)	 #,
	.seh_savexmm	%xmm9, 48
	vmovups	%xmm10, 64(%rsp)	 #,
	.seh_savexmm	%xmm10, 64
	.seh_endprologue
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vbroadcastss	.LC24(%rip), %ymm4	 #, tmp155
	vbroadcastss	.LC108(%rip), %ymm1	 #, tmp152
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:170:   return (__m256) __builtin_ia32_andnps256 ((__v8sf)__A, (__v8sf)__B);
	vbroadcastss	.LC48(%rip), %ymm5	 #, tmp161
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:352:   return (__m256) ((__v8sf)__A - (__v8sf)__B);
	vbroadcastss	.LC90(%rip), %ymm2	 #, tmp166
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:292:   return (__m256) __builtin_ia32_minps256 ((__v8sf)__A, (__v8sf)__B);
	vbroadcastss	.LC1(%rip), %ymm7	 #, tmp169
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:39: KW __m256 avx2k_gelu_ps  (__m256 x) { return avx2_gelu_ps(x); }
	vmovups	(%rdx), %ymm3	 # x, x
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:161:   return (__m256)__builtin_ia32_vfnmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vbroadcastss	.LC7(%rip), %ymm8	 #, tmp188
	vbroadcastss	.LC9(%rip), %ymm9	 #, tmp191
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vmulps	%ymm3, %ymm3, %ymm0	 # x, x, _5
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:39: KW __m256 avx2k_gelu_ps  (__m256 x) { return avx2_gelu_ps(x); }
	movq	%rcx, %rax	 # .result_ptr, .result_ptr
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vfmadd132ps	%ymm0, %ymm4, %ymm1	 # _5, tmp155, tmp150
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vbroadcastss	.LC110(%rip), %ymm0	 #, tmp158
	vmulps	%ymm1, %ymm3, %ymm1	 # tmp150, x, _7
	vmulps	%ymm0, %ymm1, %ymm1	 # tmp158, _7, _8
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:352:   return (__m256) ((__v8sf)__A - (__v8sf)__B);
	vxorps	%xmm0, %xmm0, %xmm0	 # tmp167
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:170:   return (__m256) __builtin_ia32_andnps256 ((__v8sf)__A, (__v8sf)__B);
	vandnps	%ymm1, %ymm5, %ymm6	 # _8, tmp161, tmp159
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:158:   return (__m256) __builtin_ia32_andps256 ((__v8sf)__A, (__v8sf)__B);
	vandps	%ymm1, %ymm5, %ymm5	 # _8, tmp161, tmp162
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:352:   return (__m256) ((__v8sf)__A - (__v8sf)__B);
	vfnmadd231ps	%ymm2, %ymm6, %ymm0	 # tmp166, tmp159, _16
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:292:   return (__m256) __builtin_ia32_minps256 ((__v8sf)__A, (__v8sf)__B);
	vminps	%ymm7, %ymm0, %ymm0	 # tmp169, _16, _35
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:280:   return (__m256) __builtin_ia32_maxps256 ((__v8sf)__A, (__v8sf)__B);
	vbroadcastss	.LC3(%rip), %ymm7	 #, tmp176
	vmaxps	%ymm7, %ymm0, %ymm0	 # tmp176, _35, _37
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vbroadcastss	.LC5(%rip), %ymm7	 #, tmp185
	vmulps	%ymm7, %ymm0, %ymm7	 # tmp185, _37, _38
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:1010:   return (__m256) __builtin_ia32_roundps256 ((__v8sf)__V, __M);
	vroundps	$8, %ymm7, %ymm7	 #, _38, tmp182
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:161:   return (__m256)__builtin_ia32_vfnmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vfnmadd231ps	%ymm8, %ymm7, %ymm0	 # tmp188, tmp182, tmp186
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vbroadcastss	.LC13(%rip), %ymm8	 #, tmp196
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:161:   return (__m256)__builtin_ia32_vfnmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vfnmadd132ps	%ymm7, %ymm0, %ymm9	 # tmp182, tmp186, tmp189
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:443:   return (__m256i)__builtin_ia32_cvttps2dq256 ((__v8sf) __A);
	vcvttps2dq	%ymm7, %ymm7	 # tmp182, tmp211
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vbroadcastss	.LC11(%rip), %ymm0	 #, tmp194
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vmulps	%ymm9, %ymm9, %ymm10	 # tmp189, tmp189, _42
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vfmadd132ps	%ymm9, %ymm8, %ymm0	 # tmp189, tmp196, tmp192
	vbroadcastss	.LC15(%rip), %ymm8	 #, tmp199
	vfmadd132ps	%ymm9, %ymm8, %ymm0	 # tmp189, tmp199, tmp197
	vbroadcastss	.LC17(%rip), %ymm8	 #, tmp202
	vfmadd132ps	%ymm9, %ymm8, %ymm0	 # tmp189, tmp202, tmp200
	vbroadcastss	.LC19(%rip), %ymm8	 #, tmp205
	vfmadd132ps	%ymm9, %ymm8, %ymm0	 # tmp189, tmp205, tmp203
	vbroadcastss	.LC21(%rip), %ymm8	 #, tmp208
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vmulps	%ymm8, %ymm3, %ymm3	 # tmp208, x, _11
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vfmadd132ps	%ymm9, %ymm8, %ymm0	 # tmp189, tmp208, tmp206
	vfmadd132ps	%ymm10, %ymm9, %ymm0	 # _42, tmp189, tmp209
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:121:   return (__m256i) ((__v8su)__A + (__v8su)__B);
	vpcmpeqd	%ymm9, %ymm9, %ymm9	 # tmp216
	vpsrld	$25, %ymm9, %ymm9	 #, tmp216, tmp215
	vpaddd	%ymm9, %ymm7, %ymm7	 # tmp215, tmp211, _52
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vbroadcastss	.LC94(%rip), %ymm9	 #, tmp234
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:684:   return (__m256i)__builtin_ia32_pslldi256 ((__v8si)__A, __B);
	vpslld	$23, %ymm7, %ymm7	 #, _52, tmp212
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:133:   return (__m256) ((__v8sf)__A + (__v8sf)__B);
	vaddps	%ymm4, %ymm0, %ymm0	 # tmp155, tmp209, _49
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vmulps	%ymm7, %ymm0, %ymm0	 # tmp212, _49, _56
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:133:   return (__m256) ((__v8sf)__A + (__v8sf)__B);
	vaddps	%ymm4, %ymm0, %ymm7	 # tmp155, _56, _18
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:227:   return (__m256) ((__v8sf)__A / (__v8sf)__B);
	vdivps	%ymm7, %ymm0, %ymm0	 # _18, _56, _19
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vmulps	%ymm1, %ymm1, %ymm7	 # _8, _8, _22
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:161:   return (__m256)__builtin_ia32_vfnmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vfnmadd132ps	%ymm0, %ymm4, %ymm2	 # _19, tmp155, tmp220
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vbroadcastss	.LC92(%rip), %ymm0	 #, tmp232
	vfmadd132ps	%ymm7, %ymm9, %ymm0	 # _22, tmp234, tmp230
	vbroadcastss	.LC96(%rip), %ymm9	 #, tmp237
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:316:   return (__m256) __builtin_ia32_orps256 ((__v8sf)__A, (__v8sf)__B);
	vorps	%ymm5, %ymm2, %ymm2	 # tmp162, tmp220, tmp229
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vfmadd132ps	%ymm7, %ymm9, %ymm0	 # _22, tmp237, tmp235
	vbroadcastss	.LC98(%rip), %ymm9	 #, tmp240
	vfmadd132ps	%ymm7, %ymm9, %ymm0	 # _22, tmp240, tmp238
	vbroadcastss	.LC100(%rip), %ymm9	 #, tmp243
	vfmadd132ps	%ymm7, %ymm9, %ymm0	 # _22, tmp243, tmp241
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vmulps	%ymm0, %ymm7, %ymm7	 # tmp241, _22, _27
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vbroadcastss	.LC102(%rip), %ymm0	 #, tmp249
	vcmpps	$1, %ymm0, %ymm6, %ymm6	 #, tmp249, tmp159, tmp247
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vfmadd132ps	%ymm7, %ymm1, %ymm1	 # _27, _8, tmp244
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:316:   return (__m256) __builtin_ia32_orps256 ((__v8sf)__A, (__v8sf)__B);
	vorps	%ymm5, %ymm1, %ymm1	 # tmp162, tmp244, tmp246
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:133:   return (__m256) ((__v8sf)__A + (__v8sf)__B);
	vblendvps	%ymm6, %ymm1, %ymm2, %ymm2	 # tmp247, tmp246, tmp229, tmp250
	vaddps	%ymm4, %ymm2, %ymm2	 # tmp155, tmp250, _10
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vmulps	%ymm3, %ymm2, %ymm3	 # _11, _10, _12
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:39: KW __m256 avx2k_gelu_ps  (__m256 x) { return avx2_gelu_ps(x); }
	vmovups	%ymm3, (%rcx)	 # _12, <retval>
	vzeroupper
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:39: KW __m256 avx2k_gelu_ps  (__m256 x) { return avx2_gelu_ps(x); }
	vmovups	(%rsp), %xmm6	 #,
	vmovups	16(%rsp), %xmm7	 #,
	vmovups	32(%rsp), %xmm8	 #,
	vmovups	48(%rsp), %xmm9	 #,
	vmovups	64(%rsp), %xmm10	 #,
	addq	$88, %rsp	 #,
	ret	
	.seh_endproc
	.p2align 4
	.globl	avx2k_pow_ps
	.def	avx2k_pow_ps;	.scl	2;	.type	32;	.endef
	.seh_proc	avx2k_pow_ps
avx2k_pow_ps:
	subq	$104, %rsp	 #,
	.seh_stackalloc	104
	vmovups	%xmm6, (%rsp)	 #,
	.seh_savexmm	%xmm6, 0
	vmovups	%xmm7, 16(%rsp)	 #,
	.seh_savexmm	%xmm7, 16
	vmovups	%xmm8, 32(%rsp)	 #,
	.seh_savexmm	%xmm8, 32
	vmovups	%xmm9, 48(%rsp)	 #,
	.seh_savexmm	%xmm9, 48
	vmovups	%xmm10, 64(%rsp)	 #,
	.seh_savexmm	%xmm10, 64
	vmovups	%xmm11, 80(%rsp)	 #,
	.seh_savexmm	%xmm11, 80
	.seh_endprologue
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vxorps	%xmm5, %xmm5, %xmm5	 # tmp186
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:280:   return (__m256) __builtin_ia32_maxps256 ((__v8sf)__A, (__v8sf)__B);
	vbroadcastss	.LC57(%rip), %ymm0	 #, tmp188
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:158:   return (__m256) __builtin_ia32_andps256 ((__v8sf)__A, (__v8sf)__B);
	vbroadcastss	.LC59(%rip), %ymm1	 #, tmp197
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:316:   return (__m256) __builtin_ia32_orps256 ((__v8sf)__A, (__v8sf)__B);
	vbroadcastss	.LC21(%rip), %ymm6	 #, tmp200
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vbroadcastss	.LC62(%rip), %ymm9	 #, tmp208
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:40: KW __m256 avx2k_pow_ps   (__m256 a, __m256 b) { return avx2_pow_ps(a, b); }
	vmovups	(%rdx), %ymm2	 # a, a
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:817:   return (__m256i) ((__v8su)__A - (__v8su)__B);
	movl	$-127, %edx	 #, tmp205
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:352:   return (__m256) ((__v8sf)__A - (__v8sf)__B);
	vbroadcastss	.LC46(%rip), %ymm10	 #, tmp215
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vbroadcastss	.LC66(%rip), %ymm11	 #, tmp220
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:40: KW __m256 avx2k_pow_ps   (__m256 a, __m256 b) { return avx2_pow_ps(a, b); }
	vmovups	(%r8), %ymm3	 # b, b
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:280:   return (__m256) __builtin_ia32_maxps256 ((__v8sf)__A, (__v8sf)__B);
	vmaxps	%ymm0, %ymm2, %ymm0	 # tmp188, a, _63
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vcmpps	$2, %ymm5, %ymm2, %ymm8	 #, tmp186, a, tmp185
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:158:   return (__m256) __builtin_ia32_andps256 ((__v8sf)__A, (__v8sf)__B);
	vbroadcastss	.LC24(%rip), %ymm4	 #, tmp212
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:40: KW __m256 avx2k_pow_ps   (__m256 a, __m256 b) { return avx2_pow_ps(a, b); }
	movq	%rcx, %rax	 # .result_ptr, .result_ptr
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:775:   return (__m256i)__builtin_ia32_psrldi256 ((__v8si)__A, __B);
	vpsrld	$23, %ymm0, %ymm7	 #, _63, tmp194
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:158:   return (__m256) __builtin_ia32_andps256 ((__v8sf)__A, (__v8sf)__B);
	vandps	%ymm1, %ymm0, %ymm0	 # tmp197, _63, tmp195
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:817:   return (__m256i) ((__v8su)__A - (__v8su)__B);
	vmovd	%edx, %xmm1	 # tmp205, tmp204
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:316:   return (__m256) __builtin_ia32_orps256 ((__v8sf)__A, (__v8sf)__B);
	vorps	%ymm6, %ymm0, %ymm0	 # tmp200, tmp195, tmp198
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:817:   return (__m256i) ((__v8su)__A - (__v8su)__B);
	vpbroadcastd	%xmm1, %ymm1	 # tmp204, tmp204
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vcmpps	$1, %ymm9, %ymm0, %ymm9	 #, tmp208, tmp198, tmp206
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:817:   return (__m256i) ((__v8su)__A - (__v8su)__B);
	vpaddd	%ymm1, %ymm7, %ymm7	 # tmp204, tmp194, _69
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:407:   return (__m256)__builtin_ia32_cvtdq2ps256 ((__v8si) __A);
	vcvtdq2ps	%ymm7, %ymm7	 # _69, tmp201
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:133:   return (__m256) ((__v8sf)__A + (__v8sf)__B);
	vaddps	%ymm4, %ymm7, %ymm7	 # tmp212, tmp201, _72
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:158:   return (__m256) __builtin_ia32_andps256 ((__v8sf)__A, (__v8sf)__B);
	vandps	%ymm9, %ymm0, %ymm1	 # tmp206, tmp198, tmp209
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:352:   return (__m256) ((__v8sf)__A - (__v8sf)__B);
	vaddps	%ymm10, %ymm0, %ymm0	 # tmp215, tmp198, _75
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:158:   return (__m256) __builtin_ia32_andps256 ((__v8sf)__A, (__v8sf)__B);
	vandps	%ymm9, %ymm4, %ymm9	 # tmp206, tmp212, tmp210
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:352:   return (__m256) ((__v8sf)__A - (__v8sf)__B);
	vsubps	%ymm9, %ymm7, %ymm7	 # tmp210, _72, _77
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vcmpps	$1, %ymm5, %ymm3, %ymm9	 #, tmp186, b, tmp310
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:133:   return (__m256) ((__v8sf)__A + (__v8sf)__B);
	vaddps	%ymm1, %ymm0, %ymm0	 # tmp209, _75, _78
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vbroadcastss	.LC64(%rip), %ymm1	 #, tmp218
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vmulps	%ymm0, %ymm0, %ymm10	 # _78, _78, _79
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vfmadd132ps	%ymm0, %ymm11, %ymm1	 # _78, tmp220, tmp216
	vbroadcastss	.LC68(%rip), %ymm11	 #, tmp223
	vfmadd132ps	%ymm0, %ymm11, %ymm1	 # _78, tmp223, tmp221
	vbroadcastss	.LC70(%rip), %ymm11	 #, tmp226
	vfmadd132ps	%ymm0, %ymm11, %ymm1	 # _78, tmp226, tmp224
	vbroadcastss	.LC72(%rip), %ymm11	 #, tmp229
	vfmadd132ps	%ymm0, %ymm11, %ymm1	 # _78, tmp229, tmp227
	vbroadcastss	.LC74(%rip), %ymm11	 #, tmp232
	vfmadd132ps	%ymm0, %ymm11, %ymm1	 # _78, tmp232, tmp230
	vbroadcastss	.LC76(%rip), %ymm11	 #, tmp235
	vfmadd132ps	%ymm0, %ymm11, %ymm1	 # _78, tmp235, tmp233
	vbroadcastss	.LC78(%rip), %ymm11	 #, tmp238
	vfmadd132ps	%ymm0, %ymm11, %ymm1	 # _78, tmp238, tmp236
	vbroadcastss	.LC80(%rip), %ymm11	 #, tmp241
	vfmadd132ps	%ymm0, %ymm11, %ymm1	 # _78, tmp241, tmp239
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vmulps	%ymm1, %ymm0, %ymm1	 # tmp239, _78, _88
	vmulps	%ymm10, %ymm1, %ymm1	 # _79, _88, _89
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:161:   return (__m256)__builtin_ia32_vfnmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vfnmadd132ps	%ymm6, %ymm1, %ymm10	 # tmp200, _89, tmp242
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vbroadcastss	.LC5(%rip), %ymm1	 #, tmp250
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:133:   return (__m256) ((__v8sf)__A + (__v8sf)__B);
	vaddps	%ymm10, %ymm0, %ymm0	 # tmp242, _78, _91
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vcmpps	$3, %ymm3, %ymm3, %ymm10	 #, b, b, tmp314
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vfmadd132ps	%ymm1, %ymm7, %ymm0	 # tmp250, _77, tmp247
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:292:   return (__m256) __builtin_ia32_minps256 ((__v8sf)__A, (__v8sf)__B);
	vbroadcastss	.LC26(%rip), %ymm1	 #, tmp257
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:316:   return (__m256) __builtin_ia32_orps256 ((__v8sf)__A, (__v8sf)__B);
	vorps	%ymm8, %ymm0, %ymm0	 # tmp185, tmp247, tmp255
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vbroadcastss	.LC13(%rip), %ymm8	 #, tmp278
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vmulps	%ymm0, %ymm3, %ymm0	 # tmp255, b, _11
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vcmpps	$0, %ymm5, %ymm3, %ymm3	 #, tmp186, b, tmp320
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:292:   return (__m256) __builtin_ia32_minps256 ((__v8sf)__A, (__v8sf)__B);
	vminps	%ymm1, %ymm0, %ymm0	 # tmp257, _11, _40
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:280:   return (__m256) __builtin_ia32_maxps256 ((__v8sf)__A, (__v8sf)__B);
	vbroadcastss	.LC28(%rip), %ymm1	 #, tmp264
	vmaxps	%ymm1, %ymm0, %ymm0	 # tmp264, _40, _42
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vbroadcastss	.LC30(%rip), %ymm1	 #, tmp273
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:1010:   return (__m256) __builtin_ia32_roundps256 ((__v8sf)__V, __M);
	vroundps	$8, %ymm0, %ymm7	 #, _42, tmp270
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:352:   return (__m256) ((__v8sf)__A - (__v8sf)__B);
	vsubps	%ymm7, %ymm0, %ymm0	 # tmp270, _42, _44
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:443:   return (__m256i)__builtin_ia32_cvttps2dq256 ((__v8sf) __A);
	vcvttps2dq	%ymm7, %ymm7	 # tmp270, tmp293
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vmulps	%ymm1, %ymm0, %ymm0	 # tmp273, _44, _45
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vbroadcastss	.LC11(%rip), %ymm1	 #, tmp276
	vfmadd132ps	%ymm0, %ymm8, %ymm1	 # _45, tmp278, tmp274
	vbroadcastss	.LC15(%rip), %ymm8	 #, tmp281
	vfmadd132ps	%ymm0, %ymm8, %ymm1	 # _45, tmp281, tmp279
	vbroadcastss	.LC17(%rip), %ymm8	 #, tmp284
	vfmadd132ps	%ymm0, %ymm8, %ymm1	 # _45, tmp284, tmp282
	vbroadcastss	.LC19(%rip), %ymm8	 #, tmp287
	vfmadd132ps	%ymm0, %ymm8, %ymm1	 # _45, tmp287, tmp285
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vcmpps	$0, %ymm5, %ymm2, %ymm8	 #, tmp186, a, tmp312
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vfmadd132ps	%ymm0, %ymm6, %ymm1	 # _45, tmp200, tmp288
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vmulps	%ymm0, %ymm0, %ymm6	 # _45, _45, _46
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vfmadd231ps	%ymm6, %ymm1, %ymm0	 # _46, tmp288, tmp291
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vcmpps	$1, %ymm5, %ymm2, %ymm6	 #, tmp186, a, tmp299
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:121:   return (__m256i) ((__v8su)__A + (__v8su)__B);
	vpcmpeqd	%ymm1, %ymm1, %ymm1	 # tmp298
	vpsrld	$25, %ymm1, %ymm1	 #, tmp298, tmp297
	vpaddd	%ymm1, %ymm7, %ymm7	 # tmp297, tmp293, _56
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:213:   return (__m256) __builtin_ia32_blendvps256 ((__v8sf)__X,
	vpxor	%xmm1, %xmm1, %xmm1	 # tmp302
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:684:   return (__m256i)__builtin_ia32_pslldi256 ((__v8si)__A, __B);
	vpslld	$23, %ymm7, %ymm7	 #, _56, tmp294
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:40: KW __m256 avx2k_pow_ps   (__m256 a, __m256 b) { return avx2_pow_ps(a, b); }
	vpcmpgtd	%ymm3, %ymm1, %ymm3	 # tmp320, tmp302, tmp328
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:133:   return (__m256) ((__v8sf)__A + (__v8sf)__B);
	vaddps	%ymm4, %ymm0, %ymm0	 # tmp212, tmp291, _53
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:304:   return (__m256) ((__v8sf)__A * (__v8sf)__B);
	vmulps	%ymm7, %ymm0, %ymm0	 # tmp294, _53, _60
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:213:   return (__m256) __builtin_ia32_blendvps256 ((__v8sf)__X,
	vbroadcastss	.LC88(%rip), %ymm7	 #, tmp309
	vblendvps	%ymm6, %ymm7, %ymm0, %ymm0	 # tmp299, tmp309, _60, _16
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:378:   return (__m256) __builtin_ia32_cmpps256 ((__v8sf)__X, (__v8sf)__Y,
	vcmpps	$3, %ymm2, %ymm2, %ymm6	 #, a, a, tmp315
	vcmpps	$0, %ymm4, %ymm2, %ymm2	 #, tmp212, a, tmp317
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:316:   return (__m256) __builtin_ia32_orps256 ((__v8sf)__A, (__v8sf)__B);
	vorps	%ymm10, %ymm6, %ymm6	 # tmp314, tmp315, tmp316
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:40: KW __m256 avx2k_pow_ps   (__m256 a, __m256 b) { return avx2_pow_ps(a, b); }
	vpcmpgtd	%ymm2, %ymm1, %ymm2	 # tmp317, tmp302, tmp325
	vpcmpgtd	%ymm9, %ymm1, %ymm1	 # tmp310, tmp302, tmp341
	vpor	%ymm3, %ymm2, %ymm2	 # tmp328, tmp325, _37
	vbroadcastss	.LC55(%rip), %ymm3	 #, tmp343
	vandps	%ymm1, %ymm3, %ymm1	 # tmp341, tmp343, tmp338
	vblendvps	%ymm8, %ymm1, %ymm0, %ymm0	 # tmp312, tmp338, _16, tmp334
	vblendvps	%ymm6, %ymm7, %ymm0, %ymm0	 # tmp316, tmp309, tmp334, tmp330
	vblendvps	%ymm2, %ymm4, %ymm0, %ymm0	 # _37, tmp212, tmp330, tmp322
	vmovups	%ymm0, (%rcx)	 # tmp322, <retval>
	vzeroupper
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:40: KW __m256 avx2k_pow_ps   (__m256 a, __m256 b) { return avx2_pow_ps(a, b); }
	vmovups	(%rsp), %xmm6	 #,
	vmovups	16(%rsp), %xmm7	 #,
	vmovups	32(%rsp), %xmm8	 #,
	vmovups	48(%rsp), %xmm9	 #,
	vmovups	64(%rsp), %xmm10	 #,
	vmovups	80(%rsp), %xmm11	 #,
	addq	$104, %rsp	 #,
	ret	
	.seh_endproc
	.p2align 4
	.globl	avx2k_exp_pd
	.def	avx2k_exp_pd;	.scl	2;	.type	32;	.endef
	.seh_proc	avx2k_exp_pd
avx2k_exp_pd:
	subq	$56, %rsp	 #,
	.seh_stackalloc	56
	vmovups	%xmm6, (%rsp)	 #,
	.seh_savexmm	%xmm6, 0
	vmovups	%xmm7, 16(%rsp)	 #,
	.seh_savexmm	%xmm7, 16
	vmovups	%xmm8, 32(%rsp)	 #,
	.seh_savexmm	%xmm8, 32
	.seh_endprologue
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:371:   return (__m256d) __builtin_ia32_cmppd256 ((__v4df)__X, (__v4df)__Y,
	vbroadcastsd	.LC112(%rip), %ymm2	 #, tmp153
	vbroadcastsd	.LC114(%rip), %ymm1	 #, tmp156
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:49:   return (__m256d)__builtin_ia32_vfmaddpd256 ((__v4df)__A, (__v4df)__B,
	vbroadcastsd	.LC124(%rip), %ymm6	 #, tmp186
	vbroadcastsd	.LC126(%rip), %ymm8	 #, tmp189
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:43: KW __m256d avx2k_exp_pd  (__m256d x) { return avx2_exp_pd(x); }
	vmovupd	(%rdx), %ymm0	 # x, x
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:371:   return (__m256d) __builtin_ia32_cmppd256 ((__v4df)__X, (__v4df)__Y,
	vcmppd	$30, %ymm2, %ymm0, %ymm5	 #, tmp153, x, tmp151
	vcmppd	$17, %ymm1, %ymm0, %ymm4	 #, tmp156, x, tmp154
	vcmppd	$3, %ymm0, %ymm0, %ymm3	 #, x, x, tmp157
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:286:   return (__m256d) __builtin_ia32_minpd256 ((__v4df)__A, (__v4df)__B);
	vminpd	%ymm2, %ymm0, %ymm0	 # tmp153, x, _9
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:145:   return (__m256d)__builtin_ia32_vfnmaddpd256 ((__v4df)__A, (__v4df)__B,
	vbroadcastsd	.LC118(%rip), %ymm2	 #, tmp178
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:43: KW __m256d avx2k_exp_pd  (__m256d x) { return avx2_exp_pd(x); }
	movq	%rcx, %rax	 # .result_ptr, .result_ptr
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:274:   return (__m256d) __builtin_ia32_maxpd256 ((__v4df)__A, (__v4df)__B);
	vmaxpd	%ymm1, %ymm0, %ymm1	 # tmp156, _9, _11
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:298:   return (__m256d) ((__v4df)__A * (__v4df)__B);
	vbroadcastsd	.LC116(%rip), %ymm0	 #, tmp175
	vmulpd	%ymm0, %ymm1, %ymm0	 # tmp175, _11, _12
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:1004:   return (__m256d) __builtin_ia32_roundpd256 ((__v4df)__V, __M);
	vroundpd	$8, %ymm0, %ymm0	 #, _12, tmp172
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:145:   return (__m256d)__builtin_ia32_vfnmaddpd256 ((__v4df)__A, (__v4df)__B,
	vfnmadd132pd	%ymm0, %ymm1, %ymm2	 # tmp172, _11, tmp176
	vbroadcastsd	.LC120(%rip), %ymm1	 #, tmp181
	vfnmadd132pd	%ymm0, %ymm2, %ymm1	 # tmp172, tmp176, tmp179
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:437:   return (__m128i)__builtin_ia32_cvtpd2dq256 ((__v4df) __A);
	vcvtpd2dqy	%ymm0, %xmm0	 # tmp172, tmp208
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:49:   return (__m256d)__builtin_ia32_vfmaddpd256 ((__v4df)__A, (__v4df)__B,
	vbroadcastsd	.LC122(%rip), %ymm2	 #, tmp184
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:298:   return (__m256d) ((__v4df)__A * (__v4df)__B);
	vmulpd	%ymm1, %ymm1, %ymm7	 # tmp179, tmp179, _16
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:49:   return (__m256d)__builtin_ia32_vfmaddpd256 ((__v4df)__A, (__v4df)__B,
	vfmadd132pd	%ymm7, %ymm6, %ymm2	 # _16, tmp186, tmp182
	vbroadcastsd	.LC128(%rip), %ymm6	 #, tmp192
	vfmadd132pd	%ymm7, %ymm8, %ymm2	 # _16, tmp189, tmp187
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:298:   return (__m256d) ((__v4df)__A * (__v4df)__B);
	vmulpd	%ymm2, %ymm1, %ymm2	 # tmp187, tmp179, _19
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:49:   return (__m256d)__builtin_ia32_vfmaddpd256 ((__v4df)__A, (__v4df)__B,
	vbroadcastsd	.LC130(%rip), %ymm1	 #, tmp194
	vfmadd132pd	%ymm7, %ymm1, %ymm6	 # _16, tmp194, tmp190
	vbroadcastsd	.LC132(%rip), %ymm1	 #, tmp197
	vfmadd132pd	%ymm7, %ymm1, %ymm6	 # _16, tmp197, tmp195
	vbroadcastsd	.LC134(%rip), %ymm1	 #, tmp200
	vfmadd132pd	%ymm7, %ymm1, %ymm6	 # _16, tmp200, tmp198
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:128:   return (__m256i) ((__v4du)__A + (__v4du)__B);
	vpbroadcastq	.LC140(%rip), %ymm7	 #, tmp216
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:346:   return (__m256d) ((__v4df)__A - (__v4df)__B);
	vsubpd	%ymm2, %ymm6, %ymm6	 # _19, tmp198, _23
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:221:   return (__m256d) ((__v4df)__A / (__v4df)__B);
	vdivpd	%ymm6, %ymm2, %ymm2	 # _23, _19, _24
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:49:   return (__m256d)__builtin_ia32_vfmaddpd256 ((__v4df)__A, (__v4df)__B,
	vfmadd132pd	%ymm2, %ymm8, %ymm1	 # _24, tmp189, tmp201
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/emmintrin.h:1211:   return (__m128i)__builtin_ia32_psradi128 ((__v4si)__A, __B);
	vpsrad	$1, %xmm0, %xmm2	 #, tmp208, tmp209
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:477:   return (__m256i) __builtin_ia32_pmovsxdq256 ((__v4si)__X);
	vpmovsxdq	%xmm2, %ymm6	 # tmp209, _27
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/emmintrin.h:1121:   return (__m128i) ((__v4su)__A - (__v4su)__B);
	vpsubd	%xmm2, %xmm0, %xmm2	 # tmp209, tmp208, _30
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:128:   return (__m256i) ((__v4du)__A + (__v4du)__B);
	vpaddq	%ymm7, %ymm6, %ymm0	 # tmp216, _27, _35
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:477:   return (__m256i) __builtin_ia32_pmovsxdq256 ((__v4si)__X);
	vpmovsxdq	%xmm2, %ymm2	 # _30, _30
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:698:   return (__m256i)__builtin_ia32_psllqi256 ((__v4di)__A, __B);
	vpsllq	$52, %ymm0, %ymm0	 #, _35, tmp213
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:128:   return (__m256i) ((__v4du)__A + (__v4du)__B);
	vpaddq	%ymm7, %ymm2, %ymm2	 # tmp216, _30, _39
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:698:   return (__m256i)__builtin_ia32_psllqi256 ((__v4di)__A, __B);
	vpsllq	$52, %ymm2, %ymm2	 #, _39, tmp218
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:298:   return (__m256d) ((__v4df)__A * (__v4df)__B);
	vmulpd	%ymm0, %ymm1, %ymm0	 # tmp213, tmp201, _43
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:43: KW __m256d avx2k_exp_pd  (__m256d x) { return avx2_exp_pd(x); }
	vbroadcastsd	.LC137(%rip), %ymm1	 #, tmp238
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:298:   return (__m256d) ((__v4df)__A * (__v4df)__B);
	vmulpd	%ymm2, %ymm0, %ymm0	 # tmp218, _43, _45
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:43: KW __m256d avx2k_exp_pd  (__m256d x) { return avx2_exp_pd(x); }
	vblendvpd	%ymm5, %ymm1, %ymm0, %ymm0	 # tmp151, tmp238, _45, tmp231
	vxorpd	%xmm1, %xmm1, %xmm1	 # tmp239
	vblendvpd	%ymm4, %ymm1, %ymm0, %ymm0	 # tmp154, tmp239, tmp231, tmp227
	vbroadcastsd	.LC139(%rip), %ymm1	 #, tmp241
	vblendvpd	%ymm3, %ymm1, %ymm0, %ymm0	 # tmp157, tmp241, tmp227, tmp223
	vmovupd	%ymm0, (%rcx)	 # tmp223, <retval>
	vzeroupper
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:43: KW __m256d avx2k_exp_pd  (__m256d x) { return avx2_exp_pd(x); }
	vmovups	(%rsp), %xmm6	 #,
	vmovups	16(%rsp), %xmm7	 #,
	vmovups	32(%rsp), %xmm8	 #,
	addq	$56, %rsp	 #,
	ret	
	.seh_endproc
	.p2align 4
	.globl	avx2k_log_pd
	.def	avx2k_log_pd;	.scl	2;	.type	32;	.endef
	.seh_proc	avx2k_log_pd
avx2k_log_pd:
	subq	$104, %rsp	 #,
	.seh_stackalloc	104
	vmovups	%xmm6, (%rsp)	 #,
	.seh_savexmm	%xmm6, 0
	vmovups	%xmm7, 16(%rsp)	 #,
	.seh_savexmm	%xmm7, 16
	vmovups	%xmm8, 32(%rsp)	 #,
	.seh_savexmm	%xmm8, 32
	vmovups	%xmm9, 48(%rsp)	 #,
	.seh_savexmm	%xmm9, 48
	vmovups	%xmm10, 64(%rsp)	 #,
	.seh_savexmm	%xmm10, 64
	vmovups	%xmm11, 80(%rsp)	 #,
	.seh_savexmm	%xmm11, 80
	.seh_endprologue
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:371:   return (__m256d) __builtin_ia32_cmppd256 ((__v4df)__X, (__v4df)__Y,
	vxorpd	%xmm4, %xmm4, %xmm4	 # tmp168
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:205:   return (__m256d) __builtin_ia32_blendvpd256 ((__v4df)__X,
	vpxor	%xmm5, %xmm5, %xmm5	 # tmp178
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:298:   return (__m256d) ((__v4df)__A * (__v4df)__B);
	vbroadcastsd	.LC144(%rip), %ymm0	 #, tmp182
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:371:   return (__m256d) __builtin_ia32_cmppd256 ((__v4df)__X, (__v4df)__Y,
	vbroadcastsd	.LC142(%rip), %ymm10	 #, tmp176
	vbroadcastsd	.LC137(%rip), %ymm6	 #, tmp173
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:152:   return (__m256d) __builtin_ia32_andpd256 ((__v4df)__A, (__v4df)__B);
	vbroadcastsd	.LC150(%rip), %ymm9	 #, tmp203
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:44: KW __m256d avx2k_log_pd  (__m256d x) { return avx2_log_pd(x); }
	vmovupd	(%rdx), %ymm1	 # x, x
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:298:   return (__m256d) ((__v4df)__A * (__v4df)__B);
	vmulpd	%ymm0, %ymm1, %ymm0	 # tmp182, x, _10
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:371:   return (__m256d) __builtin_ia32_cmppd256 ((__v4df)__X, (__v4df)__Y,
	vcmppd	$17, %ymm10, %ymm1, %ymm10	 #, tmp176, x, tmp174
	vcmppd	$0, %ymm6, %ymm1, %ymm7	 #, tmp173, x, tmp171
	vcmppd	$3, %ymm1, %ymm1, %ymm8	 #, x, x, tmp166
	vcmppd	$17, %ymm4, %ymm1, %ymm3	 #, tmp168, x, tmp167
	vcmppd	$0, %ymm4, %ymm1, %ymm4	 #, tmp168, x, tmp169
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:44: KW __m256d avx2k_log_pd  (__m256d x) { return avx2_log_pd(x); }
	movq	%rcx, %rax	 # .result_ptr, .result_ptr
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:152:   return (__m256d) __builtin_ia32_andpd256 ((__v4df)__A, (__v4df)__B);
	vandpd	%ymm9, %ymm10, %ymm9	 # tmp203, tmp174, tmp201
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:205:   return (__m256d) __builtin_ia32_blendvpd256 ((__v4df)__X,
	vblendvpd	%ymm10, %ymm0, %ymm1, %ymm1	 # tmp174, _10, x, _13
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:44: KW __m256d avx2k_log_pd  (__m256d x) { return avx2_log_pd(x); }
	vpcmpgtq	%ymm3, %ymm5, %ymm3	 # tmp167, tmp178, tmp266
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:181:   return (__m256i) ((__v4du)__A & (__v4du)__B);
	vpbroadcastq	.LC187(%rip), %ymm0	 #, tmp185
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:346:   return (__m256d) ((__v4df)__A - (__v4df)__B);
	vbroadcastsd	.LC154(%rip), %ymm10	 #, tmp210
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:789:   return (__m256i)__builtin_ia32_psrlqi256 ((__v4di)__A, __B);
	vpsrlq	$52, %ymm1, %ymm2	 #, _13, tmp183
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:44: KW __m256d avx2k_log_pd  (__m256d x) { return avx2_log_pd(x); }
	vpcmpgtq	%ymm8, %ymm5, %ymm5	 # tmp166, tmp178, tmp269
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:181:   return (__m256i) ((__v4du)__A & (__v4du)__B);
	vpand	%ymm0, %ymm2, %ymm2	 # tmp185, tmp183, _17
	vbroadcastsd	.LC147(%rip), %ymm0	 #, tmp190
	vandpd	%ymm0, %ymm1, %ymm1	 # tmp190, _13, tmp188
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:1422:   return (__m128i) __builtin_ia32_si_si256 ((__v8si)__A);
	vmovdqa	%xmm2, %xmm0	 # _17, tmp195
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:1098:   return (__m128i) __builtin_ia32_extract128i256 ((__v4di)__X, __M);
	vextracti128	$0x1, %ymm2, %xmm2	 # _17, tmp196
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avx2intrin.h:576:   return (__m256i) ((__v4du)__A | (__v4du)__B);
	vpor	.LC148(%rip), %ymm1, %ymm1	 #, tmp188, _21
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/xmmintrin.h:794:   return (__m128) __builtin_ia32_shufps ((__v4sf)__A, (__v4sf)__B, __mask);
	vshufps	$136, %xmm2, %xmm0, %xmm0	 #, tmp196, tmp195, _28
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:401:   return (__m256d)__builtin_ia32_cvtdq2pd256 ((__v4si) __A);
	vcvtdq2pd	%xmm0, %ymm0	 # _28, tmp197
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:371:   return (__m256d) __builtin_ia32_cmppd256 ((__v4df)__X, (__v4df)__Y,
	vbroadcastsd	.LC152(%rip), %ymm2	 #, tmp206
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:44: KW __m256d avx2k_log_pd  (__m256d x) { return avx2_log_pd(x); }
	vpor	%ymm5, %ymm3, %ymm3	 # tmp269, tmp266, _68
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:371:   return (__m256d) __builtin_ia32_cmppd256 ((__v4df)__X, (__v4df)__Y,
	vcmppd	$17, %ymm2, %ymm1, %ymm2	 #, tmp206, _21, tmp204
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:152:   return (__m256d) __builtin_ia32_andpd256 ((__v4df)__A, (__v4df)__B);
	vandpd	%ymm1, %ymm2, %ymm11	 # _21, tmp204, tmp207
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:346:   return (__m256d) ((__v4df)__A - (__v4df)__B);
	vaddpd	%ymm1, %ymm10, %ymm1	 # _21, tmp210, _36
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:152:   return (__m256d) __builtin_ia32_andpd256 ((__v4df)__A, (__v4df)__B);
	vbroadcastsd	.LC126(%rip), %ymm10	 #, tmp213
	vandpd	%ymm10, %ymm2, %ymm2	 # tmp213, tmp204, tmp211
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:346:   return (__m256d) ((__v4df)__A - (__v4df)__B);
	vbroadcastsd	.LC156(%rip), %ymm10	 #, tmp216
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:127:   return (__m256d) ((__v4df)__A + (__v4df)__B);
	vaddpd	%ymm11, %ymm1, %ymm1	 # tmp207, _36, _37
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:49:   return (__m256d)__builtin_ia32_vfmaddpd256 ((__v4df)__A, (__v4df)__B,
	vbroadcastsd	.LC172(%rip), %ymm11	 #, tmp240
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:346:   return (__m256d) ((__v4df)__A - (__v4df)__B);
	vaddpd	%ymm10, %ymm0, %ymm0	 # tmp216, tmp197, _31
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:49:   return (__m256d)__builtin_ia32_vfmaddpd256 ((__v4df)__A, (__v4df)__B,
	vbroadcastsd	.LC160(%rip), %ymm10	 #, tmp222
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:346:   return (__m256d) ((__v4df)__A - (__v4df)__B);
	vsubpd	%ymm9, %ymm0, %ymm0	 # tmp201, _31, _33
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:298:   return (__m256d) ((__v4df)__A * (__v4df)__B);
	vmulpd	%ymm1, %ymm1, %ymm9	 # _37, _37, _40
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:346:   return (__m256d) ((__v4df)__A - (__v4df)__B);
	vsubpd	%ymm2, %ymm0, %ymm0	 # tmp211, _33, _39
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:49:   return (__m256d)__builtin_ia32_vfmaddpd256 ((__v4df)__A, (__v4df)__B,
	vbroadcastsd	.LC158(%rip), %ymm2	 #, tmp220
	vfmadd132pd	%ymm1, %ymm10, %ymm2	 # _37, tmp222, tmp218
	vbroadcastsd	.LC162(%rip), %ymm10	 #, tmp225
	vfmadd132pd	%ymm1, %ymm10, %ymm2	 # _37, tmp225, tmp223
	vbroadcastsd	.LC164(%rip), %ymm10	 #, tmp228
	vfmadd132pd	%ymm1, %ymm10, %ymm2	 # _37, tmp228, tmp226
	vbroadcastsd	.LC166(%rip), %ymm10	 #, tmp231
	vfmadd132pd	%ymm1, %ymm10, %ymm2	 # _37, tmp231, tmp229
	vbroadcastsd	.LC168(%rip), %ymm10	 #, tmp234
	vfmadd231pd	%ymm1, %ymm2, %ymm10	 # _37, tmp229, tmp232
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:127:   return (__m256d) ((__v4df)__A + (__v4df)__B);
	vbroadcastsd	.LC170(%rip), %ymm2	 #, tmp238
	vaddpd	%ymm2, %ymm1, %ymm2	 # tmp238, _37, _46
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:49:   return (__m256d)__builtin_ia32_vfmaddpd256 ((__v4df)__A, (__v4df)__B,
	vfmadd132pd	%ymm1, %ymm11, %ymm2	 # _37, tmp240, tmp235
	vbroadcastsd	.LC174(%rip), %ymm11	 #, tmp243
	vfmadd132pd	%ymm1, %ymm11, %ymm2	 # _37, tmp243, tmp241
	vbroadcastsd	.LC176(%rip), %ymm11	 #, tmp246
	vfmadd132pd	%ymm1, %ymm11, %ymm2	 # _37, tmp246, tmp244
	vbroadcastsd	.LC178(%rip), %ymm11	 #, tmp249
	vfmadd132pd	%ymm1, %ymm11, %ymm2	 # _37, tmp249, tmp247
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:221:   return (__m256d) ((__v4df)__A / (__v4df)__B);
	vdivpd	%ymm2, %ymm10, %ymm2	 # tmp247, tmp232, _51
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:49:   return (__m256d)__builtin_ia32_vfmaddpd256 ((__v4df)__A, (__v4df)__B,
	vbroadcastsd	.LC180(%rip), %ymm10	 #, tmp252
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:298:   return (__m256d) ((__v4df)__A * (__v4df)__B);
	vmulpd	%ymm9, %ymm2, %ymm2	 # _40, _51, _52
	vmulpd	%ymm1, %ymm2, %ymm2	 # _37, _52, _53
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:49:   return (__m256d)__builtin_ia32_vfmaddpd256 ((__v4df)__A, (__v4df)__B,
	vfmadd231pd	%ymm10, %ymm0, %ymm2	 # tmp252, _39, tmp250
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:145:   return (__m256d)__builtin_ia32_vfnmaddpd256 ((__v4df)__A, (__v4df)__B,
	vbroadcastsd	.LC182(%rip), %ymm10	 #, tmp258
	vfnmadd132pd	%ymm10, %ymm2, %ymm9	 # tmp258, tmp250, tmp256
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:49:   return (__m256d)__builtin_ia32_vfmaddpd256 ((__v4df)__A, (__v4df)__B,
	vbroadcastsd	.LC184(%rip), %ymm2	 #, tmp261
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/avxintrin.h:127:   return (__m256d) ((__v4df)__A + (__v4df)__B);
	vaddpd	%ymm9, %ymm1, %ymm1	 # tmp256, _37, _56
 # C:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/fmaintrin.h:49:   return (__m256d)__builtin_ia32_vfmaddpd256 ((__v4df)__A, (__v4df)__B,
	vfmadd132pd	%ymm2, %ymm1, %ymm0	 # tmp261, _56, tmp259
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:44: KW __m256d avx2k_log_pd  (__m256d x) { return avx2_log_pd(x); }
	vbroadcastsd	.LC186(%rip), %ymm1	 #, tmp282
	vblendvpd	%ymm7, %ymm6, %ymm0, %ymm0	 # tmp171, tmp173, tmp259, tmp275
	vblendvpd	%ymm4, %ymm1, %ymm0, %ymm0	 # tmp169, tmp282, tmp275, tmp271
	vbroadcastsd	.LC139(%rip), %ymm1	 #, tmp284
	vblendvpd	%ymm3, %ymm1, %ymm0, %ymm0	 # _68, tmp284, tmp271, tmp263
	vmovupd	%ymm0, (%rcx)	 # tmp263, <retval>
	vzeroupper
 # C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c:44: KW __m256d avx2k_log_pd  (__m256d x) { return avx2_log_pd(x); }
	vmovups	(%rsp), %xmm6	 #,
	vmovups	16(%rsp), %xmm7	 #,
	vmovups	32(%rsp), %xmm8	 #,
	vmovups	48(%rsp), %xmm9	 #,
	vmovups	64(%rsp), %xmm10	 #,
	vmovups	80(%rsp), %xmm11	 #,
	addq	$104, %rsp	 #,
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
	.set	.LC90,.LC134+4
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
	.align 4
.LC104:
	.long	1069547520
	.align 4
.LC108:
	.long	1027024659
	.align 4
.LC110:
	.long	1061962282
	.align 8
.LC112:
	.long	-17155601
	.long	1082535490
	.align 8
.LC114:
	.long	-718458799
	.long	-1064875760
	.align 8
.LC116:
	.long	1697350398
	.long	1073157447
	.align 8
.LC118:
	.long	0
	.long	1072049728
	.align 8
.LC120:
	.long	-814109750
	.long	1052243921
	.align 8
.LC122:
	.long	-706458648
	.long	1059097037
	.align 8
.LC124:
	.long	214576254
	.long	1067386577
	.align 8
.LC126:
	.long	0
	.long	1072693248
	.align 8
.LC128:
	.long	-1137287264
	.long	1053372086
	.align 8
.LC130:
	.long	-1257720128
	.long	1063562809
	.align 8
.LC132:
	.long	-1735925644
	.long	1070405385
	.align 8
.LC134:
	.long	0
	.long	1073741824
	.align 8
.LC137:
	.long	0
	.long	2146435072
	.align 8
.LC139:
	.long	0
	.long	2146959360
	.align 8
.LC140:
	.quad	1023
	.align 8
.LC142:
	.long	0
	.long	1048576
	.align 8
.LC144:
	.long	0
	.long	1129316352
	.align 8
.LC147:
	.long	-1
	.long	1048575
	.align 32
.LC148:
	.quad	4602678819172646912
	.quad	4602678819172646912
	.quad	4602678819172646912
	.quad	4602678819172646912
	.align 8
.LC150:
	.long	0
	.long	1078657024
	.align 8
.LC152:
	.long	1719614413
	.long	1072079006
	.align 8
.LC154:
	.long	0
	.long	-1074790400
	.align 8
.LC156:
	.long	0
	.long	-1064308736
	.align 8
.LC158:
	.long	-1815929936
	.long	1058714818
	.align 8
.LC160:
	.long	1062621938
	.long	1071634165
	.align 8
.LC162:
	.long	-309171951
	.long	1074975418
	.align 8
.LC164:
	.long	-968955090
	.long	1076690802
	.align 8
.LC166:
	.long	-1840527283
	.long	1077014486
	.align 8
.LC168:
	.long	2105466104
	.long	1075762531
	.align 8
.LC170:
	.long	-1365774450
	.long	1076269856
	.align 8
.LC172:
	.long	1310310451
	.long	1078369580
	.align 8
.LC174:
	.long	-1557742147
	.long	1079295795
	.align 8
.LC176:
	.long	-346116575
	.long	1079101922
	.align 8
.LC178:
	.long	-1642125902
	.long	1077354506
	.align 8
.LC180:
	.long	1549864104
	.long	-1087647728
	.set	.LC182,.LC148
	.align 8
.LC184:
	.long	0
	.long	1072050176
	.align 8
.LC186:
	.long	0
	.long	-1048576
	.align 8
.LC187:
	.quad	2047
	.ident	"GCC: (Rev8, Built by MSYS2 project) 15.2.0"
