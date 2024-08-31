#!/bin/bash

mkdir -p bin
mkdir -p asm

cd ..

build/bin/clang++ -o ./test/bin/test_base.o ./test/test.cpp
objdump -D ./test/bin/test_base.o > ./test/asm/test_base.nasm

build/bin/clang++ -o ./test/bin/test_pc50.o ./test/test.cpp -mllvm --x86-align-branch-boundary=64 -mllvm --x86-align-branch=fused+jcc -mllvm --x86-align-skew=0
objdump -D ./test/bin/test_pc50.o > ./test/asm/test_pc50.nasm

build/bin/clang++ -o ./test/bin/test_pc51.o ./test/test.cpp -mllvm --x86-align-branch-boundary=64 -mllvm --x86-align-branch=fused+jcc -mllvm --x86-align-skew=32
objdump -D ./test/bin/test_pc51.o > ./test/asm/test_pc51.nasm

