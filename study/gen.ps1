<#
.SYNOPSIS
  Generate the assembly / machine-code study artifacts for avx2_math.

.DESCRIPTION
  Compiles study/kernels.c (which instantiates every kernel as its own symbol)
  and emits, into study/:
    avx2_math.intel.s    - assembly, Intel syntax, with -fverbose-asm comments
    avx2_math.att.s      - assembly, AT&T syntax (GDB / default objdump style)
    avx2_math.o          - the assembled object file (native COFF on Windows)
    avx2_math.disasm.txt - objdump disassembly WITH machine-code bytes per insn
    avx2_math.text.hex   - raw hex dump of the .text section (the machine code)
    avx2_math.ll         - LLVM IR (clang only): the typed SSA "intermediate
                           representation" - the nearest analogue to "byte code"
                           for ahead-of-time-compiled C.

  These let you line up: C intrinsic  ->  LLVM IR  ->  assembly mnemonic  ->  machine bytes.

.PARAMETER CC
  Compiler (default gcc). clang also works.
#>
param([string]$CC = 'gcc')

$ErrorActionPreference = 'Stop'
$root  = Split-Path $PSScriptRoot -Parent
$study = $PSScriptRoot
$src   = Join-Path $study 'kernels.c'
$inc   = Join-Path $root 'include'
$cf    = @('-O3', '-mavx2', '-mfma', "-I$inc")

# objdump lives next to the compiler in MSYS2; fall back to PATH.
$objdump = (Get-Command objdump -ErrorAction SilentlyContinue).Source
if (-not $objdump) { $objdump = 'objdump' }

Write-Host "[$CC] Intel-syntax assembly -> avx2_math.intel.s" -ForegroundColor Cyan
& $CC @cf -S -masm=intel -fverbose-asm $src -o (Join-Path $study 'avx2_math.intel.s')

Write-Host "[$CC] AT&T-syntax assembly  -> avx2_math.att.s" -ForegroundColor Cyan
& $CC @cf -S -fverbose-asm $src -o (Join-Path $study 'avx2_math.att.s')

Write-Host "[$CC] object file           -> avx2_math.o" -ForegroundColor Cyan
& $CC @cf -c $src -o (Join-Path $study 'avx2_math.o')

Write-Host "[objdump] disassembly+bytes -> avx2_math.disasm.txt" -ForegroundColor Cyan
# objdump -d prints the machine-code bytes next to each instruction by default.
& $objdump -d -M intel (Join-Path $study 'avx2_math.o') |
    Out-File -Encoding ascii (Join-Path $study 'avx2_math.disasm.txt')

Write-Host "[objdump] .text hex dump    -> avx2_math.text.hex" -ForegroundColor Cyan
& $objdump -s -j .text (Join-Path $study 'avx2_math.o') |
    Out-File -Encoding ascii (Join-Path $study 'avx2_math.text.hex')

# LLVM IR is a clang feature; emit it whenever clang is available (even if the
# main compiler chosen above is gcc), since it is valuable study material.
$clang = (Get-Command clang -ErrorAction SilentlyContinue).Source
if ($clang) {
    Write-Host "[clang] LLVM IR             -> avx2_math.ll" -ForegroundColor Cyan
    & $clang @cf -S -emit-llvm $src -o (Join-Path $study 'avx2_math.ll')
} else {
    Write-Host "(clang not found; skipping avx2_math.ll)" -ForegroundColor DarkYellow
}

Write-Host "done." -ForegroundColor Green
