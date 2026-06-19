# avx2_math - fast AVX2 + FMA exp/log approximations
#
# Usage:
#   make            build test, bench, and demo into build/
#   make test       build and run the accuracy test
#   make bench      build and run the throughput benchmark
#   make demo       build and run the usage demo
#   make asm        (re)generate the study/ assembly + machine-code artifacts
#   make clean      remove build artifacts
#
# On Windows with MSYS2/mingw, invoke with `mingw32-make`.

CC      ?= cc
CSTD    ?= -std=c11
WARN    ?= -Wall -Wextra
OPT     ?= -O3
ARCH    ?= -mavx2 -mfma
CFLAGS  ?= $(CSTD) $(WARN) $(OPT) $(ARCH) -Iinclude
LDLIBS  ?= -lm

BUILD   := build
SRC     := src/avx2_math.c
HEADERS := include/avx2_math.h include/avx2_math_f32.h include/avx2_math_f64.h

# Windows executables need the .exe suffix to run cleanly under MSYS/cmd.
ifeq ($(OS),Windows_NT)
EXE := .exe
else
EXE :=
endif

TEST  := $(BUILD)/test_accuracy$(EXE)
BENCH := $(BUILD)/bench$(EXE)
DEMO  := $(BUILD)/demo$(EXE)

OBJDUMP ?= objdump
STUDY   := study

.PHONY: all test bench demo asm clean
all: $(TEST) $(BENCH) $(DEMO)

$(BUILD):
	mkdir -p $(BUILD)

$(TEST): test/test_accuracy.c $(SRC) $(HEADERS) | $(BUILD)
	$(CC) $(CFLAGS) $< $(SRC) -o $@ $(LDLIBS)

$(BENCH): bench/bench.c $(SRC) $(HEADERS) | $(BUILD)
	$(CC) $(CFLAGS) $< $(SRC) -o $@ $(LDLIBS)

$(DEMO): examples/demo.c $(SRC) $(HEADERS) | $(BUILD)
	$(CC) $(CFLAGS) $< $(SRC) -o $@ $(LDLIBS)

test: $(TEST)
	./$(TEST)

bench: $(BENCH)
	./$(BENCH)

demo: $(DEMO)
	./$(DEMO)

# Regenerate the study/ artifacts: assembly (Intel + AT&T), the object file,
# the disassembly-with-bytes, and a .text hex dump. See study/README.md.
asm: $(STUDY)/kernels.c $(HEADERS)
	$(CC) $(CSTD) $(OPT) $(ARCH) -Iinclude -S -masm=intel -fverbose-asm $(STUDY)/kernels.c -o $(STUDY)/avx2_math.intel.s
	$(CC) $(CSTD) $(OPT) $(ARCH) -Iinclude -S -fverbose-asm            $(STUDY)/kernels.c -o $(STUDY)/avx2_math.att.s
	$(CC) $(CSTD) $(OPT) $(ARCH) -Iinclude -c                          $(STUDY)/kernels.c -o $(STUDY)/avx2_math.o
	$(OBJDUMP) -d -M intel $(STUDY)/avx2_math.o > $(STUDY)/avx2_math.disasm.txt
	$(OBJDUMP) -s -j .text $(STUDY)/avx2_math.o > $(STUDY)/avx2_math.text.hex
	@command -v clang >/dev/null 2>&1 && { \
	  echo "clang -S -emit-llvm -> $(STUDY)/avx2_math.ll"; \
	  clang $(CSTD) $(OPT) $(ARCH) -Iinclude -S -emit-llvm $(STUDY)/kernels.c -o $(STUDY)/avx2_math.ll; \
	} || echo "(clang not found; skipping avx2_math.ll)"

clean:
	rm -rf $(BUILD)
