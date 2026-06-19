# 7 — Reading machine code and IR

You have the assembly. This note is about the layers *around* it: the raw bytes
below assembly, and the LLVM IR above it. Plus the honest answer to "where's the
byte code?"

## Reading an objdump line

A line of [`../avx2_math.disasm.txt`](../avx2_math.disasm.txt) looks like:

```
  46:   c4 e2 75 bc c2          vfnmadd231ps ymm0,ymm1,ymm2
  └┬─┘  └────────┬───────┘     └──────────────┬─────────────┘
 offset      machine-code bytes            instruction (Intel syntax)
```

- **offset** — byte position of this instruction *within the function*.
- **bytes** — the actual machine code the CPU fetches and decodes.
- **instruction** — objdump's human-readable rendering.

The instruction stream is *variable length*: this one is 5 bytes, the next might
be 4 or 7. The first bytes tell the decoder how long it is.

## Decoding `c4 e2 75 bc c2` by hand

This is `vfnmadd231ps ymm0, ymm1, ymm2` — the very FMA that computes `x − fx·C1`
in `exp`. AVX instructions start with a **VEX prefix** (`c4` = 3-byte form, `c5`
= 2-byte form). Here:

```
 c4 ── 3-byte VEX prefix follows
 e2 = 1110 0010
      │││ └┴┴┴┴── mmmmm = 00010  → opcode map 0F 38
      ││└──────── B̄ = 1 (so B=0)
      │└───────── X̄ = 1 (so X=0)
      └────────── R̄ = 1 (so R=0)     (R/X/B extend register numbers to r8..r15)
 75 = 0111 0101
      │ │││└┴── pp = 01      → implied 0x66 prefix (mandatory for these ops)
      │ ││└──── L  = 1       → 256-bit (YMM). L=0 would mean 128-bit (XMM)
      │ └┴───── v̄v̄v̄v̄ = 1110 → 2nd source = ~1110 = 0001 = ymm1
      └──────── W  = 0
 bc ── opcode = VFNMADD231PS
 c2 = 1100 0010   (ModRM)
      ││ │││└┴┴── r/m = 010 = ymm2   (3rd source)
      ││ └┴┴──── reg = 000 = ymm0    (destination / 1st source)
      └┴──────── mod = 11            = register-direct (no memory operand)
```

So: dest `ymm0`, sources `ymm1` (from VEX.vvvv) and `ymm2` (from ModRM.r/m). The
`231` form means `dest = −(src1·src2) + dest` = `ymm0 − ymm1·ymm2`. With
`ymm0=x`, `ymm1=fx`, `ymm2=C1`, that's `x − fx·C1`. The bytes, the mnemonic, and
the C `_mm256_fnmadd_ps(fx, C1, x)` are three views of one operation.

You rarely need to decode by hand — but doing it once makes the disassembly stop
looking like noise.

## The `.text` hex dump

[`../avx2_math.text.hex`](../avx2_math.text.hex) (`objdump -s -j .text`) is the
same machine code as a flat stream:

```
 Contents of section .text:
  0000 c4e27d18 0d000000 00c4e27d 1815...   ...}.......}..
  └─┬─┘ └──────────┬─────────┘     └──┬──┘
 offset      16 bytes per row         ASCII (mostly unprintable here)
```

This is what actually lands in memory and executes. Cross-reference an offset
here with the same offset in the disassembly to see which bytes are which
instruction. (The committed object is Windows COFF; on Linux it'd be ELF — same
idea, different container.)

## LLVM IR — the layer above assembly

[`../avx2_math.ll`](../avx2_math.ll) (clang `-emit-llvm`) is the compiler's
**intermediate representation**: typed, in SSA form (every value assigned once),
target-ish-independent, *before* register allocation and instruction selection.
Here's `rsqrt` in IR:

```llvm
define <8 x float> @avx2k_rsqrt_ps(<8 x float> %0) {
  %2 = tail call <8 x float> @llvm.x86.avx.rsqrt.ps.256(<8 x float> %0)   ; vrsqrtps seed
  %3 = fmul <8 x float> %0, splat (float 5.000000e-01)                    ; xhalf = 0.5*x
  %4 = fneg <8 x float> %2
  %5 = fmul <8 x float> %3, %4
  %6 = tail call <8 x float> @llvm.fma.v8f32(<8 x float> %5, <8 x float> %2,
                                             <8 x float> splat (float 1.5)) ; 1.5 − xhalf*y²
  %7 = fmul <8 x float> %2, %6                                            ; y after step 1
  ... (step 2) ...
  %12 = fcmp oeq <8 x float> %0, zeroinitializer                          ; x == 0 ?
  %13 = select <8 x i1> %12, <8 x float> splat (0x7FF0…), <8 x float> %11  ; → +inf
  ...
  ret <8 x float> %17
}
```

Things to notice, and how IR differs from the two neighbours:

- **Types are explicit**: `<8 x float>` is the 8-lane vector; `<8 x i1>` is an
  8-lane boolean mask. Assembly has no types — just registers.
- **SSA**: `%2, %3, …` are each assigned once. The compiler later maps these
  onto the 16 physical YMM registers (that's *register allocation*, an assembly-
  level concern that doesn't exist in IR — which is why IR can have unlimited
  "registers").
- **`llvm.fma.v8f32`** is the portable spelling of the FMA; it becomes
  `vfnmadd…ps`/`vfmadd…ps` at the assembly stage.
- **`select`** is the portable `blendv`; **`fcmp oeq`** is the portable compare.
- **ABI-free**: the value is passed `<8 x float> %0` by value. The Windows
  pointer-in-`rcx` glue (note 1) is added *below* IR, during lowering — so the IR
  looks the same on Windows and Linux even though the assembly doesn't.

IR is a great middle layer for study: more readable than assembly, but it still
shows exactly which intrinsics fired and how the masks/selects are structured.

## "Where's the byte code?"

There isn't one, and that's the right answer. **Byte code** (Java `.class`,
Python `.pyc`, WebAssembly) is a portable instruction set for a *virtual
machine* that's interpreted or JIT-compiled at run time. C here is compiled
**ahead of time, straight to native x86-64 machine code** for this exact CPU —
no VM, no interpreter, no portable bytecode in between. The closest analogues are:

- **LLVM IR** (`avx2_math.ll`) — the compiler's internal portable form, shown
  above. This is the layer people usually mean when they reach for "bytecode" in
  a C context.
- The **machine code bytes** themselves (`disasm.txt`, `text.hex`) — native, not
  portable.

So the study set deliberately gives you both ends — IR above, raw bytes below —
with the assembly in the middle.

## The four views, side by side

| layer | file | `1.5 − xhalf·y²` appears as |
|---|---|---|
| C intrinsic | `include/avx2_math_f32.h` | `_mm256_fnmadd_ps(_mm256_mul_ps(xhalf,y), y, three_halves)` |
| LLVM IR | `avx2_math.ll` | `call @llvm.fma.v8f32(%5, %2, splat 1.5)` |
| assembly | `avx2_math.intel.s` | `vfnmadd132ps ymm…` |
| machine code | `avx2_math.text.hex` | bytes `c4 e2 .. 9c ..` |

Being able to slide between these four is the whole skill. Start from the C in
the header, find it in the IR, then in the assembly, then in the bytes — and back.

---
Back to the [start](00-START-HERE.md).
