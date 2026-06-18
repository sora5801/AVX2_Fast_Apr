<#
.SYNOPSIS
  Build and (optionally) run the avx2_math test / bench / demo on Windows.

.DESCRIPTION
  Reliable Windows build path that does not depend on `make` or a POSIX shell.
  Uses gcc/clang directly with -O3 -mavx2 -mfma.

.PARAMETER Target
  One of: all (default), test, bench, demo, clean.

.PARAMETER CC
  Compiler to use (default: gcc).

.EXAMPLE
  .\build.ps1 test
  .\build.ps1 bench -CC clang
#>
param(
  [ValidateSet('all', 'test', 'bench', 'demo', 'clean')]
  [string]$Target = 'all',
  [string]$CC = 'gcc'
)

$ErrorActionPreference = 'Stop'
$root  = $PSScriptRoot
$build = Join-Path $root 'build'
$cflags = @('-std=c11', '-Wall', '-Wextra', '-O3', '-mavx2', '-mfma', "-I$root\include")
$src    = Join-Path $root 'src\avx2_math.c'

function Invoke-Build([string]$name, [string]$mainFile) {
  if (-not (Test-Path $build)) { New-Item -ItemType Directory -Path $build | Out-Null }
  $out = Join-Path $build "$name.exe"
  $args = $cflags + @($mainFile, $src, '-o', $out, '-lm')
  Write-Host "[$CC] $name" -ForegroundColor Cyan
  & $CC @args
  if ($LASTEXITCODE -ne 0) { throw "build failed: $name" }
  return $out
}

switch ($Target) {
  'clean' {
    if (Test-Path $build) { Remove-Item -Recurse -Force $build }
    Write-Host 'cleaned.' -ForegroundColor Green
  }
  'test' {
    $exe = Invoke-Build 'test_accuracy' (Join-Path $root 'test\test_accuracy.c')
    & $exe
  }
  'bench' {
    $exe = Invoke-Build 'bench' (Join-Path $root 'bench\bench.c')
    & $exe
  }
  'demo' {
    $exe = Invoke-Build 'demo' (Join-Path $root 'examples\demo.c')
    & $exe
  }
  'all' {
    Invoke-Build 'test_accuracy' (Join-Path $root 'test\test_accuracy.c') | Out-Null
    Invoke-Build 'bench'         (Join-Path $root 'bench\bench.c')         | Out-Null
    Invoke-Build 'demo'          (Join-Path $root 'examples\demo.c')       | Out-Null
    Write-Host 'built: build\test_accuracy.exe, build\bench.exe, build\demo.exe' -ForegroundColor Green
  }
}
