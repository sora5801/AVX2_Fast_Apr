# avx2_math - fast AVX2 + FMA exp/log approximations
#
# Usage:
#   make            build test, bench, and demo into build/
#   make test       build and run the accuracy test
#   make bench      build and run the throughput benchmark
#   make demo       build and run the usage demo
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

# Windows executables need the .exe suffix to run cleanly under MSYS/cmd.
ifeq ($(OS),Windows_NT)
EXE := .exe
else
EXE :=
endif

TEST  := $(BUILD)/test_accuracy$(EXE)
BENCH := $(BUILD)/bench$(EXE)
DEMO  := $(BUILD)/demo$(EXE)

.PHONY: all test bench demo clean
all: $(TEST) $(BENCH) $(DEMO)

$(BUILD):
	mkdir -p $(BUILD)

$(TEST): test/test_accuracy.c $(SRC) include/avx2_math.h | $(BUILD)
	$(CC) $(CFLAGS) $< $(SRC) -o $@ $(LDLIBS)

$(BENCH): bench/bench.c $(SRC) include/avx2_math.h | $(BUILD)
	$(CC) $(CFLAGS) $< $(SRC) -o $@ $(LDLIBS)

$(DEMO): examples/demo.c $(SRC) include/avx2_math.h | $(BUILD)
	$(CC) $(CFLAGS) $< $(SRC) -o $@ $(LDLIBS)

test: $(TEST)
	./$(TEST)

bench: $(BENCH)
	./$(BENCH)

demo: $(DEMO)
	./$(DEMO)

clean:
	rm -rf $(BUILD)
