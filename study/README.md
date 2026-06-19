# study/ — learning materials

A self-contained course on how the AVX2+FMA kernels work, from the
floating-point theory down to the machine-code bytes.

## Start here

- **[notes/00-START-HERE.md](notes/00-START-HERE.md)** — the guided course
  (7 chapters: SIMD & AVX2, range reduction, IEEE-754 bit tricks, iterative
  refinement, accuracy/ULP, an instruction glossary, and reading machine
  code + IR).
- **[WALKTHROUGH.md](WALKTHROUGH.md)** — line-by-line tour of `exp_ps`
  (C → assembly → machine-code bytes).
- **[annotated/](annotated/)** — hand-annotated disassembly with per-instruction
  commentary:
  [`rsqrt_ps`](annotated/rsqrt_ps.annotated.s) (Newton-Raphson) and
  [`cbrt_ps`](annotated/cbrt_ps.annotated.s) (the integer `/3` bit-trick + Halley).

## Generated artifacts

Regenerate any time with:

```sh
make asm                 # POSIX / MSYS (uses gcc + objdump)
```
```powershell
.\study\gen.ps1          # Windows; .\study\gen.ps1 -CC clang for clang
```

Both compile [`kernels.c`](kernels.c) — which instantiates each `static inline`
kernel as its own non-inlined symbol (`avx2k_exp_ps`, `avx2k_log_pd`, …) — so
every function shows up as one cleanly-labeled block instead of being smeared
across the call sites that would normally inline it.

## What each file is

| file | what it is | how to read it |
|---|---|---|
| `kernels.c` | the instantiation TU (source of all artifacts) | one wrapper per kernel |
| `avx2_math.intel.s` | **assembly, Intel syntax** (`dst, src`), with `-fverbose-asm` comments tying lines back to C variables | human-readable; closest to how you'd write asm by hand |
| `avx2_math.att.s` | **assembly, AT&T syntax** (`src, dst`, `%`/`$` sigils) — GDB's and objdump's default | same code, the syntax most Unix tools print |
| `avx2_math.o` | the **assembled object file** (native format: COFF on Windows, ELF on Linux) | binary; feed to objdump / a disassembler |
| `avx2_math.disasm.txt` | **disassembly with machine-code bytes** — each instruction shown next to the exact bytes it assembled to | the bridge between mnemonics and raw bytes |
| `avx2_math.text.hex` | **raw hex dump of the `.text` section** — the machine code as a flat byte stream | `offset: bytes  ascii`, à la `objdump -s` |
| `avx2_math.ll` | **LLVM IR** (clang only) — the typed SSA intermediate, the nearest analogue to "byte code" for AOT-compiled C | see notes/07 |

## "Assembly vs machine code vs byte code"

A quick note on the terms, since the request mentioned all three:

- **Assembly** (`.s`) is the human-readable mnemonic form: `vfmadd132ps ymm0, ymm3, ymm2`.
- **Machine code** is what the CPU actually executes: the bytes `c4 e2 65 98 c2`
  that encode that instruction. You can see assembly and machine code side by
  side in `avx2_math.disasm.txt`, and the bytes alone in `avx2_math.text.hex`.
- **Byte code** in the Java/Python/WASM sense does **not** exist here: C is
  compiled ahead-of-time straight to native machine code for this specific CPU
  (x86-64 + AVX2 + FMA). There is no intermediate VM bytecode. The nearest
  analogue — the portable intermediate the compiler uses internally — is LLVM IR,
  which `make asm` / `gen.ps1` emit to `avx2_math.ll` (when clang is available).
  [notes/07](notes/07-reading-machine-code-and-ir.md) reads it in detail.

## Reading tips

- Match a source line to its instructions using the `-fverbose-asm` comments in
  `avx2_math.intel.s` (they name the C temporaries).
- In `avx2_math.disasm.txt`, the leftmost column is the byte offset within the
  function; the next column is the instruction's bytes; AVX instructions start
  with a VEX prefix (`c4`/`c5`), which is why most lines here begin with one of
  those.
- The artifacts are platform-specific (the build host's OS/ABI). The committed
  copies are from a Windows x64 gcc build; yours may differ in ABI glue (how
  arguments arrive) while the vector math in the middle stays the same.
