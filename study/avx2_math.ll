; ModuleID = 'C:\Users\sora5\AVX2_Fast_Apr\study\kernels.c'
source_filename = "C:\\Users\\sora5\\AVX2_Fast_Apr\\study\\kernels.c"
target datalayout = "e-m:w-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-w64-windows-gnu"

; Function Attrs: mustprogress nofree noinline norecurse nosync nounwind willreturn memory(none) uwtable
define dso_local <8 x float> @avx2k_exp_ps(<8 x float> noundef %0) local_unnamed_addr #0 {
  %2 = tail call <8 x float> @llvm.x86.avx.min.ps.256(<8 x float> %0, <8 x float> splat (float 0x40561814A0000000))
  %3 = tail call <8 x float> @llvm.x86.avx.max.ps.256(<8 x float> %2, <8 x float> splat (float 0xC0561814A0000000))
  %4 = fmul <8 x float> %3, splat (float 0x3FF7154760000000)
  %5 = tail call <8 x float> @llvm.x86.avx.round.ps.256(<8 x float> %4, i32 8)
  %6 = fneg <8 x float> %5
  %7 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %6, <8 x float> splat (float 0x3FE6300000000000), <8 x float> %3)
  %8 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %6, <8 x float> splat (float 0xBF2BD01060000000), <8 x float> %7)
  %9 = fmul <8 x float> %8, %8
  %10 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %8, <8 x float> splat (float 0x3F2A0D2CE0000000), <8 x float> splat (float 0x3F56E879C0000000))
  %11 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %10, <8 x float> %8, <8 x float> splat (float 0x3F81112100000000))
  %12 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %11, <8 x float> %8, <8 x float> splat (float 0x3FA5553820000000))
  %13 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %12, <8 x float> %8, <8 x float> splat (float 0x3FC5555540000000))
  %14 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %13, <8 x float> %8, <8 x float> splat (float 5.000000e-01))
  %15 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %14, <8 x float> %9, <8 x float> %8)
  %16 = fadd <8 x float> %15, splat (float 1.000000e+00)
  %17 = tail call <8 x i32> @llvm.x86.avx.cvtt.ps2dq.256(<8 x float> %5)
  %18 = shl <8 x i32> %17, splat (i32 23)
  %19 = add <8 x i32> %18, splat (i32 1065353216)
  %20 = bitcast <8 x i32> %19 to <8 x float>
  %21 = fmul <8 x float> %16, %20
  ret <8 x float> %21
}

; Function Attrs: mustprogress nofree noinline norecurse nosync nounwind willreturn memory(none) uwtable
define dso_local <8 x float> @avx2k_exp2_ps(<8 x float> noundef %0) local_unnamed_addr #0 {
  %2 = tail call <8 x float> @llvm.x86.avx.min.ps.256(<8 x float> %0, <8 x float> splat (float 1.270000e+02))
  %3 = tail call <8 x float> @llvm.x86.avx.max.ps.256(<8 x float> %2, <8 x float> splat (float -1.270000e+02))
  %4 = tail call <8 x float> @llvm.x86.avx.round.ps.256(<8 x float> %3, i32 8)
  %5 = fsub <8 x float> %3, %4
  %6 = fmul <8 x float> %5, splat (float 0x3FE62E4300000000)
  %7 = fmul <8 x float> %6, %6
  %8 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %6, <8 x float> splat (float 0x3F2A0D2CE0000000), <8 x float> splat (float 0x3F56E879C0000000))
  %9 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %8, <8 x float> %6, <8 x float> splat (float 0x3F81112100000000))
  %10 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %9, <8 x float> %6, <8 x float> splat (float 0x3FA5553820000000))
  %11 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %10, <8 x float> %6, <8 x float> splat (float 0x3FC5555540000000))
  %12 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %11, <8 x float> %6, <8 x float> splat (float 5.000000e-01))
  %13 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %12, <8 x float> %7, <8 x float> %6)
  %14 = fadd <8 x float> %13, splat (float 1.000000e+00)
  %15 = tail call <8 x i32> @llvm.x86.avx.cvtt.ps2dq.256(<8 x float> %4)
  %16 = shl <8 x i32> %15, splat (i32 23)
  %17 = add <8 x i32> %16, splat (i32 1065353216)
  %18 = bitcast <8 x i32> %17 to <8 x float>
  %19 = fmul <8 x float> %14, %18
  ret <8 x float> %19
}

; Function Attrs: mustprogress nofree noinline norecurse nosync nounwind willreturn memory(none) uwtable
define dso_local <8 x float> @avx2k_exp10_ps(<8 x float> noundef %0) local_unnamed_addr #0 {
  %2 = tail call <8 x float> @llvm.x86.avx.min.ps.256(<8 x float> %0, <8 x float> splat (float 3.800000e+01))
  %3 = tail call <8 x float> @llvm.x86.avx.max.ps.256(<8 x float> %2, <8 x float> splat (float -3.700000e+01))
  %4 = fmul <8 x float> %3, splat (float 0x400A934F00000000)
  %5 = tail call <8 x float> @llvm.x86.avx.round.ps.256(<8 x float> %4, i32 8)
  %6 = fneg <8 x float> %5
  %7 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %6, <8 x float> splat (float 0x3FD3440000000000), <8 x float> %3)
  %8 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %6, <8 x float> splat (float 0x3ED3509F80000000), <8 x float> %7)
  %9 = fmul <8 x float> %8, splat (float 0x40026BB1C0000000)
  %10 = fmul <8 x float> %9, %9
  %11 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %9, <8 x float> splat (float 0x3F2A0D2CE0000000), <8 x float> splat (float 0x3F56E879C0000000))
  %12 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %11, <8 x float> %9, <8 x float> splat (float 0x3F81112100000000))
  %13 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %12, <8 x float> %9, <8 x float> splat (float 0x3FA5553820000000))
  %14 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %13, <8 x float> %9, <8 x float> splat (float 0x3FC5555540000000))
  %15 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %14, <8 x float> %9, <8 x float> splat (float 5.000000e-01))
  %16 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %15, <8 x float> %10, <8 x float> %9)
  %17 = fadd <8 x float> %16, splat (float 1.000000e+00)
  %18 = tail call <8 x i32> @llvm.x86.avx.cvtt.ps2dq.256(<8 x float> %5)
  %19 = shl <8 x i32> %18, splat (i32 23)
  %20 = add <8 x i32> %19, splat (i32 1065353216)
  %21 = bitcast <8 x i32> %20 to <8 x float>
  %22 = fmul <8 x float> %17, %21
  ret <8 x float> %22
}

; Function Attrs: mustprogress nofree noinline norecurse nosync nounwind willreturn memory(none) uwtable
define dso_local <8 x float> @avx2k_expm1_ps(<8 x float> noundef %0) local_unnamed_addr #0 {
  %2 = tail call <8 x float> @llvm.x86.avx.min.ps.256(<8 x float> %0, <8 x float> splat (float 0x40562E4300000000))
  %3 = fmul <8 x float> %2, splat (float 0x3FF7154760000000)
  %4 = tail call <8 x float> @llvm.x86.avx.round.ps.256(<8 x float> %3, i32 8)
  %5 = fneg <8 x float> %4
  %6 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %5, <8 x float> splat (float 0x3FE6300000000000), <8 x float> %2)
  %7 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %5, <8 x float> splat (float 0xBF2BD01060000000), <8 x float> %6)
  %8 = fmul <8 x float> %7, %7
  %9 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %7, <8 x float> splat (float 0x3F2A0D2CE0000000), <8 x float> splat (float 0x3F56E879C0000000))
  %10 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %9, <8 x float> %7, <8 x float> splat (float 0x3F81112100000000))
  %11 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %10, <8 x float> %7, <8 x float> splat (float 0x3FA5553820000000))
  %12 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %11, <8 x float> %7, <8 x float> splat (float 0x3FC5555540000000))
  %13 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %12, <8 x float> %7, <8 x float> splat (float 5.000000e-01))
  %14 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %13, <8 x float> %8, <8 x float> %7)
  %15 = tail call <8 x i32> @llvm.x86.avx.cvtt.ps2dq.256(<8 x float> %4)
  %16 = shl <8 x i32> %15, splat (i32 23)
  %17 = add <8 x i32> %16, splat (i32 1065353216)
  %18 = bitcast <8 x i32> %17 to <8 x float>
  %19 = fadd <8 x float> %18, splat (float -1.000000e+00)
  %20 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %18, <8 x float> %14, <8 x float> %19)
  %21 = ashr <8 x i32> %15, splat (i32 1)
  %22 = sub <8 x i32> %15, %21
  %23 = shl <8 x i32> %22, splat (i32 23)
  %24 = add <8 x i32> %23, splat (i32 1065353216)
  %25 = bitcast <8 x i32> %24 to <8 x float>
  %26 = shl <8 x i32> %21, splat (i32 23)
  %27 = add <8 x i32> %26, splat (i32 1065353216)
  %28 = bitcast <8 x i32> %27 to <8 x float>
  %29 = fadd <8 x float> %14, splat (float 1.000000e+00)
  %30 = fmul <8 x float> %29, %25
  %31 = fmul <8 x float> %30, %28
  %32 = fadd <8 x float> %31, splat (float -1.000000e+00)
  %33 = icmp sgt <8 x i32> %15, splat (i32 63)
  %34 = select <8 x i1> %33, <8 x float> %32, <8 x float> %20
  %35 = tail call <8 x float> @llvm.fabs.v8f32(<8 x float> %0)
  %36 = fcmp olt <8 x float> %35, splat (float 0x3E80000000000000)
  %37 = select <8 x i1> %36, <8 x float> %0, <8 x float> %34
  %38 = fcmp olt <8 x float> %0, splat (float 0xC031542460000000)
  %39 = select <8 x i1> %38, <8 x float> splat (float -1.000000e+00), <8 x float> %37
  %40 = fcmp ogt <8 x float> %0, splat (float 0x40562E4300000000)
  %41 = select <8 x i1> %40, <8 x float> splat (float 0x7FF0000000000000), <8 x float> %39
  %42 = fcmp uno <8 x float> %0, zeroinitializer
  %43 = select <8 x i1> %42, <8 x float> %0, <8 x float> %41
  ret <8 x float> %43
}

; Function Attrs: mustprogress nofree noinline norecurse nosync nounwind willreturn memory(none) uwtable
define dso_local <8 x float> @avx2k_log_ps(<8 x float> noundef %0) local_unnamed_addr #0 {
  %2 = fcmp ole <8 x float> %0, zeroinitializer
  %3 = tail call <8 x float> @llvm.x86.avx.max.ps.256(<8 x float> %0, <8 x float> splat (float 0x3810000000000000))
  %4 = bitcast <8 x float> %3 to <8 x i32>
  %5 = lshr <8 x i32> %4, splat (i32 23)
  %6 = and <8 x i32> %4, splat (i32 -2139095041)
  %7 = or disjoint <8 x i32> %6, splat (i32 1056964608)
  %8 = bitcast <8 x i32> %7 to <8 x float>
  %9 = add nsw <8 x i32> %5, splat (i32 -126)
  %10 = sitofp <8 x i32> %9 to <8 x float>
  %11 = fcmp olt <8 x float> %8, splat (float 0x3FE6A09E60000000)
  %12 = select <8 x i1> %11, <8 x float> %8, <8 x float> zeroinitializer
  %13 = fadd <8 x float> %8, splat (float -1.000000e+00)
  %14 = select <8 x i1> %11, <8 x float> splat (float 1.000000e+00), <8 x float> zeroinitializer
  %15 = fsub <8 x float> %10, %14
  %16 = fadd <8 x float> %13, %12
  %17 = fmul <8 x float> %16, %16
  %18 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %16, <8 x float> splat (float 0x3FB2043760000000), <8 x float> splat (float 0xBFBD7A3700000000))
  %19 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %18, <8 x float> %16, <8 x float> splat (float 0x3FBDE4A340000000))
  %20 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %19, <8 x float> %16, <8 x float> splat (float 0xBFBFCBA9E0000000))
  %21 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %20, <8 x float> %16, <8 x float> splat (float 0x3FC23D37E0000000))
  %22 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %21, <8 x float> %16, <8 x float> splat (float 0xBFC555CA00000000))
  %23 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %22, <8 x float> %16, <8 x float> splat (float 0x3FC999D580000000))
  %24 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %23, <8 x float> %16, <8 x float> splat (float 0xBFCFFFFF80000000))
  %25 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %24, <8 x float> %16, <8 x float> splat (float 0x3FD5555540000000))
  %26 = fmul <8 x float> %16, %25
  %27 = fmul <8 x float> %17, %26
  %28 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %15, <8 x float> splat (float 0xBF2BD01060000000), <8 x float> %27)
  %29 = fneg <8 x float> %17
  %30 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %29, <8 x float> splat (float 5.000000e-01), <8 x float> %28)
  %31 = fadd <8 x float> %16, %30
  %32 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %15, <8 x float> splat (float 0x3FE6300000000000), <8 x float> %31)
  %33 = select <8 x i1> %2, <8 x float> splat (float 0xFFFFFFFFE0000000), <8 x float> %32
  ret <8 x float> %33
}

; Function Attrs: mustprogress nofree noinline norecurse nosync nounwind willreturn memory(none) uwtable
define dso_local <8 x float> @avx2k_log2_ps(<8 x float> noundef %0) local_unnamed_addr #0 {
  %2 = fcmp ole <8 x float> %0, zeroinitializer
  %3 = tail call <8 x float> @llvm.x86.avx.max.ps.256(<8 x float> %0, <8 x float> splat (float 0x3810000000000000))
  %4 = bitcast <8 x float> %3 to <8 x i32>
  %5 = lshr <8 x i32> %4, splat (i32 23)
  %6 = and <8 x i32> %4, splat (i32 -2139095041)
  %7 = or disjoint <8 x i32> %6, splat (i32 1056964608)
  %8 = bitcast <8 x i32> %7 to <8 x float>
  %9 = add nsw <8 x i32> %5, splat (i32 -126)
  %10 = sitofp <8 x i32> %9 to <8 x float>
  %11 = fcmp olt <8 x float> %8, splat (float 0x3FE6A09E60000000)
  %12 = select <8 x i1> %11, <8 x float> %8, <8 x float> zeroinitializer
  %13 = fadd <8 x float> %8, splat (float -1.000000e+00)
  %14 = select <8 x i1> %11, <8 x float> splat (float 1.000000e+00), <8 x float> zeroinitializer
  %15 = fsub <8 x float> %10, %14
  %16 = fadd <8 x float> %13, %12
  %17 = fmul <8 x float> %16, %16
  %18 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %16, <8 x float> splat (float 0x3FB2043760000000), <8 x float> splat (float 0xBFBD7A3700000000))
  %19 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %18, <8 x float> %16, <8 x float> splat (float 0x3FBDE4A340000000))
  %20 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %19, <8 x float> %16, <8 x float> splat (float 0xBFBFCBA9E0000000))
  %21 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %20, <8 x float> %16, <8 x float> splat (float 0x3FC23D37E0000000))
  %22 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %21, <8 x float> %16, <8 x float> splat (float 0xBFC555CA00000000))
  %23 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %22, <8 x float> %16, <8 x float> splat (float 0x3FC999D580000000))
  %24 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %23, <8 x float> %16, <8 x float> splat (float 0xBFCFFFFF80000000))
  %25 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %24, <8 x float> %16, <8 x float> splat (float 0x3FD5555540000000))
  %26 = fmul <8 x float> %16, %25
  %27 = fmul <8 x float> %17, %26
  %28 = fneg <8 x float> %17
  %29 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %28, <8 x float> splat (float 5.000000e-01), <8 x float> %27)
  %30 = fadd <8 x float> %16, %29
  %31 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %30, <8 x float> splat (float 0x3FF7154760000000), <8 x float> %15)
  %32 = select <8 x i1> %2, <8 x float> splat (float 0xFFFFFFFFE0000000), <8 x float> %31
  ret <8 x float> %32
}

; Function Attrs: mustprogress nofree noinline norecurse nosync nounwind willreturn memory(none) uwtable
define dso_local <8 x float> @avx2k_log10_ps(<8 x float> noundef %0) local_unnamed_addr #0 {
  %2 = fcmp ole <8 x float> %0, zeroinitializer
  %3 = tail call <8 x float> @llvm.x86.avx.max.ps.256(<8 x float> %0, <8 x float> splat (float 0x3810000000000000))
  %4 = bitcast <8 x float> %3 to <8 x i32>
  %5 = lshr <8 x i32> %4, splat (i32 23)
  %6 = and <8 x i32> %4, splat (i32 -2139095041)
  %7 = or disjoint <8 x i32> %6, splat (i32 1056964608)
  %8 = bitcast <8 x i32> %7 to <8 x float>
  %9 = add nsw <8 x i32> %5, splat (i32 -126)
  %10 = sitofp <8 x i32> %9 to <8 x float>
  %11 = fcmp olt <8 x float> %8, splat (float 0x3FE6A09E60000000)
  %12 = select <8 x i1> %11, <8 x float> %8, <8 x float> zeroinitializer
  %13 = fadd <8 x float> %8, splat (float -1.000000e+00)
  %14 = select <8 x i1> %11, <8 x float> splat (float 1.000000e+00), <8 x float> zeroinitializer
  %15 = fsub <8 x float> %10, %14
  %16 = fadd <8 x float> %13, %12
  %17 = fmul <8 x float> %16, %16
  %18 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %16, <8 x float> splat (float 0x3FB2043760000000), <8 x float> splat (float 0xBFBD7A3700000000))
  %19 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %18, <8 x float> %16, <8 x float> splat (float 0x3FBDE4A340000000))
  %20 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %19, <8 x float> %16, <8 x float> splat (float 0xBFBFCBA9E0000000))
  %21 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %20, <8 x float> %16, <8 x float> splat (float 0x3FC23D37E0000000))
  %22 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %21, <8 x float> %16, <8 x float> splat (float 0xBFC555CA00000000))
  %23 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %22, <8 x float> %16, <8 x float> splat (float 0x3FC999D580000000))
  %24 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %23, <8 x float> %16, <8 x float> splat (float 0xBFCFFFFF80000000))
  %25 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %24, <8 x float> %16, <8 x float> splat (float 0x3FD5555540000000))
  %26 = fmul <8 x float> %16, %25
  %27 = fmul <8 x float> %17, %26
  %28 = fneg <8 x float> %17
  %29 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %28, <8 x float> splat (float 5.000000e-01), <8 x float> %27)
  %30 = fadd <8 x float> %16, %29
  %31 = fmul <8 x float> %30, splat (float 0x3FDBCB7B20000000)
  %32 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %15, <8 x float> splat (float 0x3FD3441360000000), <8 x float> %31)
  %33 = select <8 x i1> %2, <8 x float> splat (float 0xFFFFFFFFE0000000), <8 x float> %32
  ret <8 x float> %33
}

; Function Attrs: mustprogress nofree noinline norecurse nosync nounwind willreturn memory(none) uwtable
define dso_local <8 x float> @avx2k_log1p_ps(<8 x float> noundef %0) local_unnamed_addr #0 {
  %2 = fadd <8 x float> %0, splat (float 1.000000e+00)
  %3 = fcmp ole <8 x float> %2, zeroinitializer
  %4 = tail call <8 x float> @llvm.x86.avx.max.ps.256(<8 x float> %2, <8 x float> splat (float 0x3810000000000000))
  %5 = bitcast <8 x float> %4 to <8 x i32>
  %6 = lshr <8 x i32> %5, splat (i32 23)
  %7 = and <8 x i32> %5, splat (i32 -2139095041)
  %8 = or disjoint <8 x i32> %7, splat (i32 1056964608)
  %9 = bitcast <8 x i32> %8 to <8 x float>
  %10 = add nsw <8 x i32> %6, splat (i32 -126)
  %11 = sitofp <8 x i32> %10 to <8 x float>
  %12 = fcmp olt <8 x float> %9, splat (float 0x3FE6A09E60000000)
  %13 = select <8 x i1> %12, <8 x float> %9, <8 x float> zeroinitializer
  %14 = fadd <8 x float> %9, splat (float -1.000000e+00)
  %15 = select <8 x i1> %12, <8 x float> splat (float 1.000000e+00), <8 x float> zeroinitializer
  %16 = fsub <8 x float> %11, %15
  %17 = fadd <8 x float> %14, %13
  %18 = fmul <8 x float> %17, %17
  %19 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %17, <8 x float> splat (float 0x3FB2043760000000), <8 x float> splat (float 0xBFBD7A3700000000))
  %20 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %19, <8 x float> %17, <8 x float> splat (float 0x3FBDE4A340000000))
  %21 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %20, <8 x float> %17, <8 x float> splat (float 0xBFBFCBA9E0000000))
  %22 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %21, <8 x float> %17, <8 x float> splat (float 0x3FC23D37E0000000))
  %23 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %22, <8 x float> %17, <8 x float> splat (float 0xBFC555CA00000000))
  %24 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %23, <8 x float> %17, <8 x float> splat (float 0x3FC999D580000000))
  %25 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %24, <8 x float> %17, <8 x float> splat (float 0xBFCFFFFF80000000))
  %26 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %25, <8 x float> %17, <8 x float> splat (float 0x3FD5555540000000))
  %27 = fmul <8 x float> %17, %26
  %28 = fmul <8 x float> %18, %27
  %29 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %16, <8 x float> splat (float 0xBF2BD01060000000), <8 x float> %28)
  %30 = fneg <8 x float> %18
  %31 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %30, <8 x float> splat (float 5.000000e-01), <8 x float> %29)
  %32 = fadd <8 x float> %17, %31
  %33 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %16, <8 x float> splat (float 0x3FE6300000000000), <8 x float> %32)
  %34 = select <8 x i1> %3, <8 x float> splat (float 0xFFFFFFFFE0000000), <8 x float> %33
  %35 = fadd <8 x float> %2, splat (float -1.000000e+00)
  %36 = fdiv <8 x float> %0, %35
  %37 = fmul <8 x float> %36, %34
  %38 = fcmp oeq <8 x float> %2, splat (float 1.000000e+00)
  %39 = select <8 x i1> %38, <8 x float> %0, <8 x float> %37
  %40 = fcmp oeq <8 x float> %0, splat (float -1.000000e+00)
  %41 = select <8 x i1> %40, <8 x float> splat (float 0xFFF0000000000000), <8 x float> %39
  %42 = fcmp olt <8 x float> %0, splat (float -1.000000e+00)
  %43 = select <8 x i1> %42, <8 x float> splat (float 0x7FF8000000000000), <8 x float> %41
  %44 = fcmp oeq <8 x float> %0, splat (float 0x7FF0000000000000)
  %45 = select <8 x i1> %44, <8 x float> splat (float 0x7FF0000000000000), <8 x float> %43
  ret <8 x float> %45
}

; Function Attrs: mustprogress nofree noinline norecurse nosync nounwind willreturn memory(none) uwtable
define dso_local <8 x float> @avx2k_tanh_ps(<8 x float> noundef %0) local_unnamed_addr #0 {
  %2 = bitcast <8 x float> %0 to <8 x i32>
  %3 = tail call <8 x float> @llvm.fabs.v8f32(<8 x float> %0)
  %4 = and <8 x i32> %2, splat (i32 -2147483648)
  %5 = fmul <8 x float> %3, splat (float 2.000000e+00)
  %6 = fsub <8 x float> zeroinitializer, %5
  %7 = tail call <8 x float> @llvm.x86.avx.min.ps.256(<8 x float> %6, <8 x float> splat (float 0x40561814A0000000))
  %8 = tail call <8 x float> @llvm.x86.avx.max.ps.256(<8 x float> %7, <8 x float> splat (float 0xC0561814A0000000))
  %9 = fmul <8 x float> %8, splat (float 0x3FF7154760000000)
  %10 = tail call <8 x float> @llvm.x86.avx.round.ps.256(<8 x float> %9, i32 8)
  %11 = fneg <8 x float> %10
  %12 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %11, <8 x float> splat (float 0x3FE6300000000000), <8 x float> %8)
  %13 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %11, <8 x float> splat (float 0xBF2BD01060000000), <8 x float> %12)
  %14 = fmul <8 x float> %13, %13
  %15 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %13, <8 x float> splat (float 0x3F2A0D2CE0000000), <8 x float> splat (float 0x3F56E879C0000000))
  %16 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %15, <8 x float> %13, <8 x float> splat (float 0x3F81112100000000))
  %17 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %16, <8 x float> %13, <8 x float> splat (float 0x3FA5553820000000))
  %18 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %17, <8 x float> %13, <8 x float> splat (float 0x3FC5555540000000))
  %19 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %18, <8 x float> %13, <8 x float> splat (float 5.000000e-01))
  %20 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %19, <8 x float> %14, <8 x float> %13)
  %21 = fadd <8 x float> %20, splat (float 1.000000e+00)
  %22 = tail call <8 x i32> @llvm.x86.avx.cvtt.ps2dq.256(<8 x float> %10)
  %23 = shl <8 x i32> %22, splat (i32 23)
  %24 = add <8 x i32> %23, splat (i32 1065353216)
  %25 = bitcast <8 x i32> %24 to <8 x float>
  %26 = fmul <8 x float> %21, %25
  %27 = fadd <8 x float> %26, splat (float 1.000000e+00)
  %28 = fdiv <8 x float> %26, %27
  %29 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %28, <8 x float> splat (float -2.000000e+00), <8 x float> splat (float 1.000000e+00))
  %30 = fmul <8 x float> %0, %0
  %31 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %30, <8 x float> splat (float 0xBF775E1D40000000), <8 x float> splat (float 0x3F952269C0000000))
  %32 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %31, <8 x float> %30, <8 x float> splat (float 0xBFAB83C5A0000000))
  %33 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %32, <8 x float> %30, <8 x float> splat (float 0x3FC1107260000000))
  %34 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %33, <8 x float> %30, <8 x float> splat (float 0xBFD5555320000000))
  %35 = fmul <8 x float> %30, %34
  %36 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %35, <8 x float> %0, <8 x float> %0)
  %37 = fcmp olt <8 x float> %3, splat (float 6.250000e-01)
  %38 = select <8 x i1> %37, <8 x float> %36, <8 x float> %29
  %39 = bitcast <8 x float> %38 to <8 x i32>
  %40 = or <8 x i32> %4, %39
  %41 = bitcast <8 x i32> %40 to <8 x float>
  ret <8 x float> %41
}

; Function Attrs: mustprogress nofree noinline norecurse nosync nounwind willreturn memory(none) uwtable
define dso_local <8 x float> @avx2k_sigmoid_ps(<8 x float> noundef %0) local_unnamed_addr #0 {
  %2 = tail call <8 x float> @llvm.fabs.v8f32(<8 x float> %0)
  %3 = fcmp olt <8 x float> %0, zeroinitializer
  %4 = fsub <8 x float> zeroinitializer, %2
  %5 = tail call <8 x float> @llvm.x86.avx.min.ps.256(<8 x float> %4, <8 x float> splat (float 0x40561814A0000000))
  %6 = tail call <8 x float> @llvm.x86.avx.max.ps.256(<8 x float> %5, <8 x float> splat (float 0xC0561814A0000000))
  %7 = fmul <8 x float> %6, splat (float 0x3FF7154760000000)
  %8 = tail call <8 x float> @llvm.x86.avx.round.ps.256(<8 x float> %7, i32 8)
  %9 = fneg <8 x float> %8
  %10 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %9, <8 x float> splat (float 0x3FE6300000000000), <8 x float> %6)
  %11 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %9, <8 x float> splat (float 0xBF2BD01060000000), <8 x float> %10)
  %12 = fmul <8 x float> %11, %11
  %13 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %11, <8 x float> splat (float 0x3F2A0D2CE0000000), <8 x float> splat (float 0x3F56E879C0000000))
  %14 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %13, <8 x float> %11, <8 x float> splat (float 0x3F81112100000000))
  %15 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %14, <8 x float> %11, <8 x float> splat (float 0x3FA5553820000000))
  %16 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %15, <8 x float> %11, <8 x float> splat (float 0x3FC5555540000000))
  %17 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %16, <8 x float> %11, <8 x float> splat (float 5.000000e-01))
  %18 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %17, <8 x float> %12, <8 x float> %11)
  %19 = fadd <8 x float> %18, splat (float 1.000000e+00)
  %20 = tail call <8 x i32> @llvm.x86.avx.cvtt.ps2dq.256(<8 x float> %8)
  %21 = shl <8 x i32> %20, splat (i32 23)
  %22 = add <8 x i32> %21, splat (i32 1065353216)
  %23 = bitcast <8 x i32> %22 to <8 x float>
  %24 = fmul <8 x float> %19, %23
  %25 = fadd <8 x float> %24, splat (float 1.000000e+00)
  %26 = fdiv <8 x float> %24, %25
  %27 = fsub <8 x float> splat (float 1.000000e+00), %26
  %28 = select <8 x i1> %3, <8 x float> %26, <8 x float> %27
  ret <8 x float> %28
}

; Function Attrs: mustprogress nofree noinline norecurse nosync nounwind willreturn memory(none) uwtable
define dso_local <8 x float> @avx2k_rsqrt_ps(<8 x float> noundef %0) local_unnamed_addr #0 {
  %2 = tail call <8 x float> @llvm.x86.avx.rsqrt.ps.256(<8 x float> %0)
  %3 = fmul <8 x float> %0, splat (float 5.000000e-01)
  %4 = fneg <8 x float> %2
  %5 = fmul <8 x float> %3, %4
  %6 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %5, <8 x float> %2, <8 x float> splat (float 1.500000e+00))
  %7 = fmul <8 x float> %2, %6
  %8 = fneg <8 x float> %7
  %9 = fmul <8 x float> %3, %8
  %10 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %9, <8 x float> %7, <8 x float> splat (float 1.500000e+00))
  %11 = fmul <8 x float> %7, %10
  %12 = fcmp oeq <8 x float> %0, zeroinitializer
  %13 = select <8 x i1> %12, <8 x float> splat (float 0x7FF0000000000000), <8 x float> %11
  %14 = fcmp oeq <8 x float> %0, splat (float 0x7FF0000000000000)
  %15 = select <8 x i1> %14, <8 x float> zeroinitializer, <8 x float> %13
  %16 = fcmp olt <8 x float> %0, zeroinitializer
  %17 = select <8 x i1> %16, <8 x float> splat (float 0x7FF8000000000000), <8 x float> %15
  ret <8 x float> %17
}

; Function Attrs: mustprogress nofree noinline norecurse nosync nounwind willreturn memory(none) uwtable
define dso_local noundef <8 x float> @avx2k_sqrt_ps(<8 x float> noundef %0) local_unnamed_addr #0 {
  %2 = tail call noundef <8 x float> @llvm.sqrt.v8f32(<8 x float> %0)
  ret <8 x float> %2
}

; Function Attrs: mustprogress nofree noinline norecurse nosync nounwind willreturn memory(none) uwtable
define dso_local <8 x float> @avx2k_cbrt_ps(<8 x float> noundef %0) local_unnamed_addr #0 {
  %2 = tail call <8 x float> @llvm.fabs.v8f32(<8 x float> %0)
  %3 = bitcast <8 x float> %2 to <4 x i64>
  %4 = and <4 x i64> %3, splat (i64 4294967295)
  %5 = mul nuw <4 x i64> %4, splat (i64 2863311531)
  %6 = lshr <4 x i64> %3, splat (i64 32)
  %7 = mul nuw <4 x i64> %6, splat (i64 2863311531)
  %8 = lshr <4 x i64> %5, splat (i64 33)
  %9 = lshr <4 x i64> %7, splat (i64 1)
  %10 = and <4 x i64> %9, splat (i64 9223372032559808512)
  %11 = or disjoint <4 x i64> %10, %8
  %12 = bitcast <4 x i64> %11 to <8 x i32>
  %13 = add <8 x i32> %12, splat (i32 709967975)
  %14 = bitcast <8 x i32> %13 to <8 x float>
  %15 = fmul <8 x float> %14, %14
  %16 = fmul <8 x float> %15, %14
  %17 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %2, <8 x float> splat (float 2.000000e+00), <8 x float> %16)
  %18 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %16, <8 x float> splat (float 2.000000e+00), <8 x float> %2)
  %19 = fdiv <8 x float> %17, %18
  %20 = fmul <8 x float> %19, %14
  %21 = fmul <8 x float> %20, %20
  %22 = fmul <8 x float> %20, %21
  %23 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %2, <8 x float> splat (float 2.000000e+00), <8 x float> %22)
  %24 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %22, <8 x float> splat (float 2.000000e+00), <8 x float> %2)
  %25 = fdiv <8 x float> %23, %24
  %26 = fmul <8 x float> %20, %25
  %27 = bitcast <8 x float> %0 to <8 x i32>
  %28 = and <8 x i32> %27, splat (i32 -2147483648)
  %29 = bitcast <8 x float> %26 to <8 x i32>
  %30 = fcmp oeq <8 x float> %0, zeroinitializer
  %31 = select <8 x i1> %30, <8 x i32> zeroinitializer, <8 x i32> %29
  %32 = or <8 x i32> %31, %28
  %33 = bitcast <8 x i32> %32 to <8 x float>
  %34 = tail call <8 x float> @llvm.copysign.v8f32(<8 x float> splat (float 0x7FF0000000000000), <8 x float> %0)
  %35 = fcmp oeq <8 x float> %2, splat (float 0x7FF0000000000000)
  %36 = select <8 x i1> %35, <8 x float> %34, <8 x float> %33
  %37 = fcmp uno <8 x float> %0, zeroinitializer
  %38 = select <8 x i1> %37, <8 x float> %0, <8 x float> %36
  ret <8 x float> %38
}

; Function Attrs: mustprogress nofree noinline norecurse nosync nounwind willreturn memory(none) uwtable
define dso_local <8 x float> @avx2k_softplus_ps(<8 x float> noundef %0) local_unnamed_addr #0 {
  %2 = tail call <8 x float> @llvm.fabs.v8f32(<8 x float> %0)
  %3 = tail call <8 x float> @llvm.x86.avx.max.ps.256(<8 x float> %0, <8 x float> zeroinitializer)
  %4 = fsub <8 x float> zeroinitializer, %2
  %5 = tail call <8 x float> @llvm.x86.avx.min.ps.256(<8 x float> %4, <8 x float> splat (float 0x40561814A0000000))
  %6 = tail call <8 x float> @llvm.x86.avx.max.ps.256(<8 x float> %5, <8 x float> splat (float 0xC0561814A0000000))
  %7 = fmul <8 x float> %6, splat (float 0x3FF7154760000000)
  %8 = tail call <8 x float> @llvm.x86.avx.round.ps.256(<8 x float> %7, i32 8)
  %9 = fneg <8 x float> %8
  %10 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %9, <8 x float> splat (float 0x3FE6300000000000), <8 x float> %6)
  %11 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %9, <8 x float> splat (float 0xBF2BD01060000000), <8 x float> %10)
  %12 = fmul <8 x float> %11, %11
  %13 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %11, <8 x float> splat (float 0x3F2A0D2CE0000000), <8 x float> splat (float 0x3F56E879C0000000))
  %14 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %13, <8 x float> %11, <8 x float> splat (float 0x3F81112100000000))
  %15 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %14, <8 x float> %11, <8 x float> splat (float 0x3FA5553820000000))
  %16 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %15, <8 x float> %11, <8 x float> splat (float 0x3FC5555540000000))
  %17 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %16, <8 x float> %11, <8 x float> splat (float 5.000000e-01))
  %18 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %17, <8 x float> %12, <8 x float> %11)
  %19 = fadd <8 x float> %18, splat (float 1.000000e+00)
  %20 = tail call <8 x i32> @llvm.x86.avx.cvtt.ps2dq.256(<8 x float> %8)
  %21 = shl <8 x i32> %20, splat (i32 23)
  %22 = add <8 x i32> %21, splat (i32 1065353216)
  %23 = bitcast <8 x i32> %22 to <8 x float>
  %24 = fmul <8 x float> %19, %23
  %25 = fadd <8 x float> %24, splat (float 1.000000e+00)
  %26 = fcmp ole <8 x float> %25, zeroinitializer
  %27 = tail call <8 x float> @llvm.x86.avx.max.ps.256(<8 x float> %25, <8 x float> splat (float 0x3810000000000000))
  %28 = bitcast <8 x float> %27 to <8 x i32>
  %29 = lshr <8 x i32> %28, splat (i32 23)
  %30 = and <8 x i32> %28, splat (i32 -2139095041)
  %31 = or disjoint <8 x i32> %30, splat (i32 1056964608)
  %32 = bitcast <8 x i32> %31 to <8 x float>
  %33 = add nsw <8 x i32> %29, splat (i32 -126)
  %34 = sitofp <8 x i32> %33 to <8 x float>
  %35 = fcmp olt <8 x float> %32, splat (float 0x3FE6A09E60000000)
  %36 = select <8 x i1> %35, <8 x float> %32, <8 x float> zeroinitializer
  %37 = fadd <8 x float> %32, splat (float -1.000000e+00)
  %38 = select <8 x i1> %35, <8 x float> splat (float 1.000000e+00), <8 x float> zeroinitializer
  %39 = fsub <8 x float> %34, %38
  %40 = fadd <8 x float> %37, %36
  %41 = fmul <8 x float> %40, %40
  %42 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %40, <8 x float> splat (float 0x3FB2043760000000), <8 x float> splat (float 0xBFBD7A3700000000))
  %43 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %42, <8 x float> %40, <8 x float> splat (float 0x3FBDE4A340000000))
  %44 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %43, <8 x float> %40, <8 x float> splat (float 0xBFBFCBA9E0000000))
  %45 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %44, <8 x float> %40, <8 x float> splat (float 0x3FC23D37E0000000))
  %46 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %45, <8 x float> %40, <8 x float> splat (float 0xBFC555CA00000000))
  %47 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %46, <8 x float> %40, <8 x float> splat (float 0x3FC999D580000000))
  %48 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %47, <8 x float> %40, <8 x float> splat (float 0xBFCFFFFF80000000))
  %49 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %48, <8 x float> %40, <8 x float> splat (float 0x3FD5555540000000))
  %50 = fmul <8 x float> %40, %49
  %51 = fmul <8 x float> %41, %50
  %52 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %39, <8 x float> splat (float 0xBF2BD01060000000), <8 x float> %51)
  %53 = fneg <8 x float> %41
  %54 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %53, <8 x float> splat (float 5.000000e-01), <8 x float> %52)
  %55 = fadd <8 x float> %40, %54
  %56 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %39, <8 x float> splat (float 0x3FE6300000000000), <8 x float> %55)
  %57 = select <8 x i1> %26, <8 x float> splat (float 0xFFFFFFFFE0000000), <8 x float> %56
  %58 = fadd <8 x float> %25, splat (float -1.000000e+00)
  %59 = fdiv <8 x float> %24, %58
  %60 = fmul <8 x float> %59, %57
  %61 = fcmp oeq <8 x float> %25, splat (float 1.000000e+00)
  %62 = select <8 x i1> %61, <8 x float> %24, <8 x float> %60
  %63 = fcmp oeq <8 x float> %24, splat (float -1.000000e+00)
  %64 = select <8 x i1> %63, <8 x float> splat (float 0xFFF0000000000000), <8 x float> %62
  %65 = fcmp olt <8 x float> %24, splat (float -1.000000e+00)
  %66 = select <8 x i1> %65, <8 x float> splat (float 0x7FF8000000000000), <8 x float> %64
  %67 = fcmp oeq <8 x float> %24, splat (float 0x7FF0000000000000)
  %68 = select <8 x i1> %67, <8 x float> splat (float 0x7FF0000000000000), <8 x float> %66
  %69 = fadd <8 x float> %3, %68
  ret <8 x float> %69
}

; Function Attrs: mustprogress nofree noinline norecurse nosync nounwind willreturn memory(none) uwtable
define dso_local <8 x float> @avx2k_gelu_ps(<8 x float> noundef %0) local_unnamed_addr #0 {
  %2 = fmul <8 x float> %0, %0
  %3 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %2, <8 x float> splat (float 0x3FA6E4E260000000), <8 x float> splat (float 1.000000e+00))
  %4 = fmul <8 x float> %0, %3
  %5 = fmul <8 x float> %4, splat (float 0x3FE9884540000000)
  %6 = bitcast <8 x float> %5 to <8 x i32>
  %7 = tail call <8 x float> @llvm.fabs.v8f32(<8 x float> %5)
  %8 = and <8 x i32> %6, splat (i32 -2147483648)
  %9 = fmul <8 x float> %7, splat (float 2.000000e+00)
  %10 = fsub <8 x float> zeroinitializer, %9
  %11 = tail call <8 x float> @llvm.x86.avx.min.ps.256(<8 x float> %10, <8 x float> splat (float 0x40561814A0000000))
  %12 = tail call <8 x float> @llvm.x86.avx.max.ps.256(<8 x float> %11, <8 x float> splat (float 0xC0561814A0000000))
  %13 = fmul <8 x float> %12, splat (float 0x3FF7154760000000)
  %14 = tail call <8 x float> @llvm.x86.avx.round.ps.256(<8 x float> %13, i32 8)
  %15 = fneg <8 x float> %14
  %16 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %15, <8 x float> splat (float 0x3FE6300000000000), <8 x float> %12)
  %17 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %15, <8 x float> splat (float 0xBF2BD01060000000), <8 x float> %16)
  %18 = fmul <8 x float> %17, %17
  %19 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %17, <8 x float> splat (float 0x3F2A0D2CE0000000), <8 x float> splat (float 0x3F56E879C0000000))
  %20 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %19, <8 x float> %17, <8 x float> splat (float 0x3F81112100000000))
  %21 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %20, <8 x float> %17, <8 x float> splat (float 0x3FA5553820000000))
  %22 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %21, <8 x float> %17, <8 x float> splat (float 0x3FC5555540000000))
  %23 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %22, <8 x float> %17, <8 x float> splat (float 5.000000e-01))
  %24 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %23, <8 x float> %18, <8 x float> %17)
  %25 = fadd <8 x float> %24, splat (float 1.000000e+00)
  %26 = tail call <8 x i32> @llvm.x86.avx.cvtt.ps2dq.256(<8 x float> %14)
  %27 = shl <8 x i32> %26, splat (i32 23)
  %28 = add <8 x i32> %27, splat (i32 1065353216)
  %29 = bitcast <8 x i32> %28 to <8 x float>
  %30 = fmul <8 x float> %25, %29
  %31 = fadd <8 x float> %30, splat (float 1.000000e+00)
  %32 = fdiv <8 x float> %30, %31
  %33 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %32, <8 x float> splat (float -2.000000e+00), <8 x float> splat (float 1.000000e+00))
  %34 = fmul <8 x float> %5, %5
  %35 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %34, <8 x float> splat (float 0xBF775E1D40000000), <8 x float> splat (float 0x3F952269C0000000))
  %36 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %35, <8 x float> %34, <8 x float> splat (float 0xBFAB83C5A0000000))
  %37 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %36, <8 x float> %34, <8 x float> splat (float 0x3FC1107260000000))
  %38 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %37, <8 x float> %34, <8 x float> splat (float 0xBFD5555320000000))
  %39 = fmul <8 x float> %34, %38
  %40 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %39, <8 x float> %5, <8 x float> %5)
  %41 = fcmp olt <8 x float> %7, splat (float 6.250000e-01)
  %42 = select <8 x i1> %41, <8 x float> %40, <8 x float> %33
  %43 = bitcast <8 x float> %42 to <8 x i32>
  %44 = or <8 x i32> %8, %43
  %45 = bitcast <8 x i32> %44 to <8 x float>
  %46 = fmul <8 x float> %0, splat (float 5.000000e-01)
  %47 = fadd <8 x float> %45, splat (float 1.000000e+00)
  %48 = fmul <8 x float> %46, %47
  ret <8 x float> %48
}

; Function Attrs: mustprogress nofree noinline norecurse nosync nounwind willreturn memory(none) uwtable
define dso_local <8 x float> @avx2k_sin_ps(<8 x float> noundef %0) local_unnamed_addr #0 {
  %2 = bitcast <8 x float> %0 to <8 x i32>
  %3 = tail call <8 x float> @llvm.fabs.v8f32(<8 x float> %0)
  %4 = fmul <8 x float> %3, splat (float 0x3FF45F3060000000)
  %5 = tail call <8 x i32> @llvm.x86.avx.cvtt.ps2dq.256(<8 x float> %4)
  %6 = add <8 x i32> %5, splat (i32 1)
  %7 = and <8 x i32> %6, splat (i32 -2)
  %8 = sitofp <8 x i32> %7 to <8 x float>
  %9 = shl <8 x i32> %6, splat (i32 29)
  %10 = and <8 x i32> %6, splat (i32 2)
  %11 = icmp eq <8 x i32> %10, zeroinitializer
  %12 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %8, <8 x float> splat (float 0xBFE9200000000000), <8 x float> %3)
  %13 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %8, <8 x float> splat (float 0xBF2FB40000000000), <8 x float> %12)
  %14 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %8, <8 x float> splat (float 0xBE64442D20000000), <8 x float> %13)
  %15 = xor <8 x i32> %9, %2
  %16 = and <8 x i32> %15, splat (i32 -2147483648)
  %17 = fmul <8 x float> %14, %14
  %18 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %17, <8 x float> splat (float 0x3EF99EB9C0000000), <8 x float> splat (float 0xBF56C0C340000000))
  %19 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %18, <8 x float> %17, <8 x float> splat (float 0x3FA55554A0000000))
  %20 = fmul <8 x float> %17, %19
  %21 = fmul <8 x float> %17, %20
  %22 = fneg <8 x float> %17
  %23 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %22, <8 x float> splat (float 5.000000e-01), <8 x float> %21)
  %24 = fadd <8 x float> %23, splat (float 1.000000e+00)
  %25 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %17, <8 x float> splat (float 0xBF29943F20000000), <8 x float> splat (float 0x3F811073C0000000))
  %26 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %25, <8 x float> %17, <8 x float> splat (float 0xBFC5555460000000))
  %27 = fmul <8 x float> %17, %26
  %28 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %27, <8 x float> %14, <8 x float> %14)
  %29 = select <8 x i1> %11, <8 x float> %28, <8 x float> %24
  %30 = bitcast <8 x float> %29 to <8 x i32>
  %31 = xor <8 x i32> %16, %30
  %32 = bitcast <8 x i32> %31 to <8 x float>
  ret <8 x float> %32
}

; Function Attrs: mustprogress nofree noinline norecurse nosync nounwind willreturn memory(none) uwtable
define dso_local <8 x float> @avx2k_cos_ps(<8 x float> noundef %0) local_unnamed_addr #0 {
  %2 = tail call <8 x float> @llvm.fabs.v8f32(<8 x float> %0)
  %3 = fmul <8 x float> %2, splat (float 0x3FF45F3060000000)
  %4 = tail call <8 x i32> @llvm.x86.avx.cvtt.ps2dq.256(<8 x float> %3)
  %5 = add <8 x i32> %4, splat (i32 1)
  %6 = and <8 x i32> %5, splat (i32 -2)
  %7 = sitofp <8 x i32> %6 to <8 x float>
  %8 = and <8 x i32> %5, splat (i32 2)
  %9 = icmp eq <8 x i32> %8, zeroinitializer
  %10 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %7, <8 x float> splat (float 0xBFE9200000000000), <8 x float> %2)
  %11 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %7, <8 x float> splat (float 0xBF2FB40000000000), <8 x float> %10)
  %12 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %7, <8 x float> splat (float 0xBE64442D20000000), <8 x float> %11)
  %13 = shl <8 x i32> %4, splat (i32 29)
  %14 = add <8 x i32> %13, splat (i32 -536870912)
  %15 = fmul <8 x float> %12, %12
  %16 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %15, <8 x float> splat (float 0x3EF99EB9C0000000), <8 x float> splat (float 0xBF56C0C340000000))
  %17 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %16, <8 x float> %15, <8 x float> splat (float 0x3FA55554A0000000))
  %18 = fmul <8 x float> %15, %17
  %19 = fmul <8 x float> %15, %18
  %20 = fneg <8 x float> %15
  %21 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %20, <8 x float> splat (float 5.000000e-01), <8 x float> %19)
  %22 = fadd <8 x float> %21, splat (float 1.000000e+00)
  %23 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %15, <8 x float> splat (float 0xBF29943F20000000), <8 x float> splat (float 0x3F811073C0000000))
  %24 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %23, <8 x float> %15, <8 x float> splat (float 0xBFC5555460000000))
  %25 = fmul <8 x float> %15, %24
  %26 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %25, <8 x float> %12, <8 x float> %12)
  %27 = select <8 x i1> %9, <8 x float> %22, <8 x float> %26
  %28 = bitcast <8 x float> %27 to <8 x i32>
  %29 = and <8 x i32> %14, splat (i32 -2147483648)
  %30 = xor <8 x i32> %29, %28
  %31 = xor <8 x i32> %30, splat (i32 -2147483648)
  %32 = bitcast <8 x i32> %31 to <8 x float>
  ret <8 x float> %32
}

; Function Attrs: mustprogress nofree noinline norecurse nosync nounwind willreturn memory(argmem: write) uwtable
define dso_local void @avx2k_sincos_ps(<8 x float> noundef %0, ptr nocapture noundef writeonly initializes((0, 32)) %1, ptr nocapture noundef writeonly initializes((0, 32)) %2) local_unnamed_addr #1 {
  %4 = bitcast <8 x float> %0 to <8 x i32>
  %5 = tail call <8 x float> @llvm.fabs.v8f32(<8 x float> %0)
  %6 = fmul <8 x float> %5, splat (float 0x3FF45F3060000000)
  %7 = tail call <8 x i32> @llvm.x86.avx.cvtt.ps2dq.256(<8 x float> %6)
  %8 = add <8 x i32> %7, splat (i32 1)
  %9 = and <8 x i32> %8, splat (i32 -2)
  %10 = sitofp <8 x i32> %9 to <8 x float>
  %11 = shl <8 x i32> %8, splat (i32 29)
  %12 = and <8 x i32> %8, splat (i32 2)
  %13 = icmp eq <8 x i32> %12, zeroinitializer
  %14 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %10, <8 x float> splat (float 0xBFE9200000000000), <8 x float> %5)
  %15 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %10, <8 x float> splat (float 0xBF2FB40000000000), <8 x float> %14)
  %16 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %10, <8 x float> splat (float 0xBE64442D20000000), <8 x float> %15)
  %17 = shl <8 x i32> %7, splat (i32 29)
  %18 = add <8 x i32> %17, splat (i32 -536870912)
  %19 = xor <8 x i32> %11, %4
  %20 = and <8 x i32> %19, splat (i32 -2147483648)
  %21 = fmul <8 x float> %16, %16
  %22 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %21, <8 x float> splat (float 0x3EF99EB9C0000000), <8 x float> splat (float 0xBF56C0C340000000))
  %23 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %22, <8 x float> %21, <8 x float> splat (float 0x3FA55554A0000000))
  %24 = fmul <8 x float> %21, %23
  %25 = fmul <8 x float> %21, %24
  %26 = fneg <8 x float> %21
  %27 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %26, <8 x float> splat (float 5.000000e-01), <8 x float> %25)
  %28 = fadd <8 x float> %27, splat (float 1.000000e+00)
  %29 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %21, <8 x float> splat (float 0xBF29943F20000000), <8 x float> splat (float 0x3F811073C0000000))
  %30 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %29, <8 x float> %21, <8 x float> splat (float 0xBFC5555460000000))
  %31 = fmul <8 x float> %21, %30
  %32 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %31, <8 x float> %16, <8 x float> %16)
  %33 = select <8 x i1> %13, <8 x float> %32, <8 x float> %28
  %34 = select <8 x i1> %13, <8 x float> %28, <8 x float> %32
  %35 = bitcast <8 x float> %33 to <8 x i32>
  %36 = xor <8 x i32> %20, %35
  store <8 x i32> %36, ptr %1, align 32, !tbaa !5
  %37 = bitcast <8 x float> %34 to <8 x i32>
  %38 = and <8 x i32> %18, splat (i32 -2147483648)
  %39 = xor <8 x i32> %38, %37
  %40 = xor <8 x i32> %39, splat (i32 -2147483648)
  store <8 x i32> %40, ptr %2, align 32, !tbaa !5
  ret void
}

; Function Attrs: mustprogress nofree noinline norecurse nosync nounwind willreturn memory(none) uwtable
define dso_local <8 x float> @avx2k_pow_ps(<8 x float> noundef %0, <8 x float> noundef %1) local_unnamed_addr #0 {
  %3 = fcmp ole <8 x float> %0, zeroinitializer
  %4 = tail call <8 x float> @llvm.x86.avx.max.ps.256(<8 x float> %0, <8 x float> splat (float 0x3810000000000000))
  %5 = bitcast <8 x float> %4 to <8 x i32>
  %6 = lshr <8 x i32> %5, splat (i32 23)
  %7 = and <8 x i32> %5, splat (i32 -2139095041)
  %8 = or disjoint <8 x i32> %7, splat (i32 1056964608)
  %9 = bitcast <8 x i32> %8 to <8 x float>
  %10 = add nsw <8 x i32> %6, splat (i32 -126)
  %11 = sitofp <8 x i32> %10 to <8 x float>
  %12 = fcmp olt <8 x float> %9, splat (float 0x3FE6A09E60000000)
  %13 = select <8 x i1> %12, <8 x float> %9, <8 x float> zeroinitializer
  %14 = fadd <8 x float> %9, splat (float -1.000000e+00)
  %15 = select <8 x i1> %12, <8 x float> splat (float 1.000000e+00), <8 x float> zeroinitializer
  %16 = fsub <8 x float> %11, %15
  %17 = fadd <8 x float> %14, %13
  %18 = fmul <8 x float> %17, %17
  %19 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %17, <8 x float> splat (float 0x3FB2043760000000), <8 x float> splat (float 0xBFBD7A3700000000))
  %20 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %19, <8 x float> %17, <8 x float> splat (float 0x3FBDE4A340000000))
  %21 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %20, <8 x float> %17, <8 x float> splat (float 0xBFBFCBA9E0000000))
  %22 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %21, <8 x float> %17, <8 x float> splat (float 0x3FC23D37E0000000))
  %23 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %22, <8 x float> %17, <8 x float> splat (float 0xBFC555CA00000000))
  %24 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %23, <8 x float> %17, <8 x float> splat (float 0x3FC999D580000000))
  %25 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %24, <8 x float> %17, <8 x float> splat (float 0xBFCFFFFF80000000))
  %26 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %25, <8 x float> %17, <8 x float> splat (float 0x3FD5555540000000))
  %27 = fmul <8 x float> %17, %26
  %28 = fmul <8 x float> %18, %27
  %29 = fneg <8 x float> %18
  %30 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %29, <8 x float> splat (float 5.000000e-01), <8 x float> %28)
  %31 = fadd <8 x float> %17, %30
  %32 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %31, <8 x float> splat (float 0x3FF7154760000000), <8 x float> %16)
  %33 = select <8 x i1> %3, <8 x float> splat (float 0xFFFFFFFFE0000000), <8 x float> %32
  %34 = fmul <8 x float> %1, %33
  %35 = tail call <8 x float> @llvm.x86.avx.min.ps.256(<8 x float> %34, <8 x float> splat (float 1.270000e+02))
  %36 = tail call <8 x float> @llvm.x86.avx.max.ps.256(<8 x float> %35, <8 x float> splat (float -1.270000e+02))
  %37 = tail call <8 x float> @llvm.x86.avx.round.ps.256(<8 x float> %36, i32 8)
  %38 = fsub <8 x float> %36, %37
  %39 = fmul <8 x float> %38, splat (float 0x3FE62E4300000000)
  %40 = fmul <8 x float> %39, %39
  %41 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %39, <8 x float> splat (float 0x3F2A0D2CE0000000), <8 x float> splat (float 0x3F56E879C0000000))
  %42 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %41, <8 x float> %39, <8 x float> splat (float 0x3F81112100000000))
  %43 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %42, <8 x float> %39, <8 x float> splat (float 0x3FA5553820000000))
  %44 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %43, <8 x float> %39, <8 x float> splat (float 0x3FC5555540000000))
  %45 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %44, <8 x float> %39, <8 x float> splat (float 5.000000e-01))
  %46 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %45, <8 x float> %40, <8 x float> %39)
  %47 = fadd <8 x float> %46, splat (float 1.000000e+00)
  %48 = tail call <8 x i32> @llvm.x86.avx.cvtt.ps2dq.256(<8 x float> %37)
  %49 = shl <8 x i32> %48, splat (i32 23)
  %50 = add <8 x i32> %49, splat (i32 1065353216)
  %51 = bitcast <8 x i32> %50 to <8 x float>
  %52 = fmul <8 x float> %47, %51
  %53 = fcmp olt <8 x float> %0, zeroinitializer
  %54 = select <8 x i1> %53, <8 x float> splat (float 0x7FF8000000000000), <8 x float> %52
  %55 = fcmp olt <8 x float> %1, zeroinitializer
  %56 = select <8 x i1> %55, <8 x float> splat (float 0x7FF0000000000000), <8 x float> zeroinitializer
  %57 = fcmp oeq <8 x float> %0, zeroinitializer
  %58 = select <8 x i1> %57, <8 x float> %56, <8 x float> %54
  %59 = fcmp uno <8 x float> %0, %1
  %60 = select <8 x i1> %59, <8 x float> splat (float 0x7FF8000000000000), <8 x float> %58
  %61 = fcmp oeq <8 x float> %0, splat (float 1.000000e+00)
  %62 = fcmp oeq <8 x float> %1, zeroinitializer
  %63 = or <8 x i1> %61, %62
  %64 = select <8 x i1> %63, <8 x float> splat (float 1.000000e+00), <8 x float> %60
  ret <8 x float> %64
}

; Function Attrs: mustprogress nofree noinline norecurse nosync nounwind willreturn memory(none) uwtable
define dso_local <4 x double> @avx2k_exp_pd(<4 x double> noundef %0) local_unnamed_addr #0 {
  %2 = fcmp ogt <4 x double> %0, splat (double 0x40862E42FEFA39EF)
  %3 = fcmp olt <4 x double> %0, splat (double 0xC0874910D52D3051)
  %4 = fcmp uno <4 x double> %0, zeroinitializer
  %5 = tail call <4 x double> @llvm.x86.avx.min.pd.256(<4 x double> %0, <4 x double> splat (double 0x40862E42FEFA39EF))
  %6 = tail call <4 x double> @llvm.x86.avx.max.pd.256(<4 x double> %5, <4 x double> splat (double 0xC0874910D52D3051))
  %7 = fmul <4 x double> %6, splat (double 0x3FF71547652B82FE)
  %8 = tail call <4 x double> @llvm.x86.avx.round.pd.256(<4 x double> %7, i32 8)
  %9 = fneg <4 x double> %8
  %10 = tail call <4 x double> @llvm.fma.v4f64(<4 x double> %9, <4 x double> splat (double 0x3FE62E4000000000), <4 x double> %6)
  %11 = tail call <4 x double> @llvm.fma.v4f64(<4 x double> %9, <4 x double> splat (double 0x3EB7F7D1CF79ABCA), <4 x double> %10)
  %12 = fmul <4 x double> %11, %11
  %13 = tail call <4 x double> @llvm.fma.v4f64(<4 x double> %12, <4 x double> splat (double 0x3F2089CDD5E44BE8), <4 x double> splat (double 0x3F9F06D10CCA2C7E))
  %14 = tail call <4 x double> @llvm.fma.v4f64(<4 x double> %13, <4 x double> %12, <4 x double> splat (double 1.000000e+00))
  %15 = fmul <4 x double> %11, %14
  %16 = tail call <4 x double> @llvm.fma.v4f64(<4 x double> %12, <4 x double> splat (double 0x3EC92EB6BC365FA0), <4 x double> splat (double 0x3F64AE39B508B6C0))
  %17 = tail call <4 x double> @llvm.fma.v4f64(<4 x double> %16, <4 x double> %12, <4 x double> splat (double 0x3FCD17099887E074))
  %18 = tail call <4 x double> @llvm.fma.v4f64(<4 x double> %17, <4 x double> %12, <4 x double> splat (double 2.000000e+00))
  %19 = fsub <4 x double> %18, %15
  %20 = fdiv <4 x double> %15, %19
  %21 = tail call <4 x double> @llvm.fma.v4f64(<4 x double> %20, <4 x double> splat (double 2.000000e+00), <4 x double> splat (double 1.000000e+00))
  %22 = tail call <4 x i32> @llvm.x86.avx.cvt.pd2dq.256(<4 x double> %8)
  %23 = ashr <4 x i32> %22, splat (i32 1)
  %24 = sub <4 x i32> %22, %23
  %25 = zext <4 x i32> %24 to <4 x i64>
  %26 = add nsw <4 x i32> %23, splat (i32 1023)
  %27 = zext <4 x i32> %26 to <4 x i64>
  %28 = shl <4 x i64> %27, splat (i64 52)
  %29 = shl <4 x i64> %25, splat (i64 52)
  %30 = add <4 x i64> %29, splat (i64 4607182418800017408)
  %31 = bitcast <4 x i64> %28 to <4 x double>
  %32 = fmul <4 x double> %21, %31
  %33 = bitcast <4 x i64> %30 to <4 x double>
  %34 = fmul <4 x double> %32, %33
  %35 = select <4 x i1> %2, <4 x double> splat (double 0x7FF0000000000000), <4 x double> %34
  %36 = select <4 x i1> %3, <4 x double> zeroinitializer, <4 x double> %35
  %37 = select <4 x i1> %4, <4 x double> splat (double 0x7FF8000000000000), <4 x double> %36
  ret <4 x double> %37
}

; Function Attrs: mustprogress nofree noinline norecurse nosync nounwind willreturn memory(none) uwtable
define dso_local <4 x double> @avx2k_log_pd(<4 x double> noundef %0) local_unnamed_addr #0 {
  %2 = fcmp oeq <4 x double> %0, zeroinitializer
  %3 = fcmp oeq <4 x double> %0, splat (double 0x7FF0000000000000)
  %4 = fcmp olt <4 x double> %0, splat (double 0x10000000000000)
  %5 = fmul <4 x double> %0, splat (double 0x4350000000000000)
  %6 = select <4 x i1> %4, <4 x double> %5, <4 x double> %0
  %7 = bitcast <4 x double> %6 to <4 x i64>
  %8 = lshr <4 x i64> %7, splat (i64 52)
  %9 = and <4 x i64> %8, splat (i64 2047)
  %10 = and <4 x i64> %7, splat (i64 4503599627370495)
  %11 = or disjoint <4 x i64> %10, splat (i64 4602678819172646912)
  %12 = bitcast <4 x i64> %11 to <4 x double>
  %13 = bitcast <4 x i64> %9 to <8 x float>
  %14 = shufflevector <8 x float> %13, <8 x float> poison, <4 x i32> <i32 0, i32 poison, i32 2, i32 poison>
  %15 = bitcast <4 x i64> %9 to <8 x float>
  %16 = shufflevector <8 x float> %15, <8 x float> poison, <4 x i32> <i32 4, i32 poison, i32 6, i32 poison>
  %17 = shufflevector <4 x float> %14, <4 x float> %16, <4 x i32> <i32 0, i32 2, i32 4, i32 6>
  %18 = bitcast <4 x float> %17 to <4 x i32>
  %19 = sitofp <4 x i32> %18 to <4 x double>
  %20 = fadd <4 x double> %19, splat (double -1.022000e+03)
  %21 = select <4 x i1> %4, <4 x double> splat (double 5.400000e+01), <4 x double> zeroinitializer
  %22 = fsub <4 x double> %20, %21
  %23 = fcmp olt <4 x double> %12, splat (double 0x3FE6A09E667F3BCD)
  %24 = select <4 x i1> %23, <4 x double> %12, <4 x double> zeroinitializer
  %25 = fadd <4 x double> %12, splat (double -1.000000e+00)
  %26 = fadd <4 x double> %25, %24
  %27 = select <4 x i1> %23, <4 x double> splat (double 1.000000e+00), <4 x double> zeroinitializer
  %28 = fsub <4 x double> %22, %27
  %29 = fmul <4 x double> %26, %26
  %30 = tail call <4 x double> @llvm.fma.v4f64(<4 x double> %26, <4 x double> splat (double 0x3F1AB4C293C31BB0), <4 x double> splat (double 0x3FDFD6F53F5652F2))
  %31 = tail call <4 x double> @llvm.fma.v4f64(<4 x double> %30, <4 x double> %26, <4 x double> splat (double 0x4012D2BAED926911))
  %32 = tail call <4 x double> @llvm.fma.v4f64(<4 x double> %31, <4 x double> %26, <4 x double> splat (double 0x402CFF72C63EEB2E))
  %33 = tail call <4 x double> @llvm.fma.v4f64(<4 x double> %32, <4 x double> %26, <4 x double> splat (double 0x4031EFD6924BC84D))
  %34 = tail call <4 x double> @llvm.fma.v4f64(<4 x double> %33, <4 x double> %26, <4 x double> splat (double 0x401ED5637D7EDCF8))
  %35 = fadd <4 x double> %26, splat (double 0x40269320AE97EF8E)
  %36 = tail call <4 x double> @llvm.fma.v4f64(<4 x double> %35, <4 x double> %26, <4 x double> splat (double 0x40469D2C4E19C033))
  %37 = tail call <4 x double> @llvm.fma.v4f64(<4 x double> %36, <4 x double> %26, <4 x double> splat (double 0x4054BF33A326BDBD))
  %38 = tail call <4 x double> @llvm.fma.v4f64(<4 x double> %37, <4 x double> %26, <4 x double> splat (double 0x4051C9E2EB5EAE21))
  %39 = tail call <4 x double> @llvm.fma.v4f64(<4 x double> %38, <4 x double> %26, <4 x double> splat (double 0x4037200A9E1F25B2))
  %40 = fdiv <4 x double> %34, %39
  %41 = fmul <4 x double> %29, %40
  %42 = fmul <4 x double> %26, %41
  %43 = tail call <4 x double> @llvm.fma.v4f64(<4 x double> %28, <4 x double> splat (double 0xBF2BD0105C610CA8), <4 x double> %42)
  %44 = fneg <4 x double> %29
  %45 = tail call <4 x double> @llvm.fma.v4f64(<4 x double> %44, <4 x double> splat (double 5.000000e-01), <4 x double> %43)
  %46 = fadd <4 x double> %26, %45
  %47 = tail call <4 x double> @llvm.fma.v4f64(<4 x double> %28, <4 x double> splat (double 0x3FE6300000000000), <4 x double> %46)
  %48 = select <4 x i1> %3, <4 x double> splat (double 0x7FF0000000000000), <4 x double> %47
  %49 = select <4 x i1> %2, <4 x double> splat (double 0xFFF0000000000000), <4 x double> %48
  %50 = fcmp ult <4 x double> %0, zeroinitializer
  %51 = select <4 x i1> %50, <4 x double> splat (double 0x7FF8000000000000), <4 x double> %49
  ret <4 x double> %51
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(none)
declare <8 x float> @llvm.x86.avx.round.ps.256(<8 x float>, i32 immarg) #2

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(none)
declare <8 x float> @llvm.x86.avx.min.ps.256(<8 x float>, <8 x float>) #2

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(none)
declare <8 x float> @llvm.x86.avx.max.ps.256(<8 x float>, <8 x float>) #2

; Function Attrs: mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <8 x float> @llvm.fma.v8f32(<8 x float>, <8 x float>, <8 x float>) #3

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(none)
declare <8 x i32> @llvm.x86.avx.cvtt.ps2dq.256(<8 x float>) #2

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(none)
declare <8 x float> @llvm.x86.avx.rsqrt.ps.256(<8 x float>) #2

; Function Attrs: mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <8 x float> @llvm.sqrt.v8f32(<8 x float>) #3

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(none)
declare <4 x double> @llvm.x86.avx.round.pd.256(<4 x double>, i32 immarg) #2

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(none)
declare <4 x double> @llvm.x86.avx.min.pd.256(<4 x double>, <4 x double>) #2

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(none)
declare <4 x double> @llvm.x86.avx.max.pd.256(<4 x double>, <4 x double>) #2

; Function Attrs: mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <4 x double> @llvm.fma.v4f64(<4 x double>, <4 x double>, <4 x double>) #3

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(none)
declare <4 x i32> @llvm.x86.avx.cvt.pd2dq.256(<4 x double>) #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <8 x float> @llvm.fabs.v8f32(<8 x float>) #4

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <8 x float> @llvm.copysign.v8f32(<8 x float>, <8 x float>) #4

attributes #0 = { mustprogress nofree noinline norecurse nosync nounwind willreturn memory(none) uwtable "min-legal-vector-width"="256" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+avx,+avx2,+cmov,+crc32,+cx8,+fma,+fxsr,+mmx,+popcnt,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+ssse3,+x87,+xsave" "tune-cpu"="generic" }
attributes #1 = { mustprogress nofree noinline norecurse nosync nounwind willreturn memory(argmem: write) uwtable "min-legal-vector-width"="256" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+avx,+avx2,+cmov,+crc32,+cx8,+fma,+fxsr,+mmx,+popcnt,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+ssse3,+x87,+xsave" "tune-cpu"="generic" }
attributes #2 = { mustprogress nocallback nofree nosync nounwind willreturn memory(none) }
attributes #3 = { mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #4 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 2}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"uwtable", i32 2}
!3 = !{i32 1, !"MaxTLSAlign", i32 65536}
!4 = !{!"clang version 20.1.8"}
!5 = !{!6, !6, i64 0}
!6 = !{!"omnipotent char", !7, i64 0}
!7 = !{!"Simple C/C++ TBAA"}
