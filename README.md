# Half&Half Implementation on LLVM Compiler for X86 Machines

Half&Half is a software-only solution to branch predictor isolation that requires no changes to the hardware or ISA, and only requires minor modifications to be supported in existing compilers.

**Paper**: Half&Half: Demystifying Intel's Directional Branch Predictors for Fast, Secure Partitioned Execution

**Authors**: Hosein Yavarzadeh, Mohammadkazem Taram, Shravan Narayan, Deian Stefan, Dean Tullsen

**Conference**: IEEE Symposium on Security and Privacy (IEEE S&P), May 2023.

**Website**: https://halfandhalf.cpusec.org/

Also, you can find the paper here: https://ieeexplore.ieee.org/document/10179415

## How To Build the Compiler

```bash
git clone https://github.com/hoseinyavarzadeh/HalfHalf-LLVM.git
cd HalfHalf-LLVM
git branch -v -a
git checkout halfhalf
cmake -S llvm -B build -G Ninja -DCMAKE_BUILD_TYPE=Release -DLLVM_ENABLE_PROJECTS=clang
cmake --build build -j32
```

## Half&Half Examples

To compile code so that all its conditional branches have bit 5 set to 0, use the following command:

```bash
build/bin/clang++ -o something.o something.cpp -mllvm --x86-align-branch-boundary=64 -mllvm --x86-align-skew=0 -mllvm --x86-align-branch=fused+jcc 
```

To set bit 5 to 1 for all conditional branches, use this command:

```bash
build/bin/clang++ -o something.o something.cpp -mllvm --x86-align-branch-boundary=64 -mllvm --x86-align-skew=32 -mllvm --x86-align-branch=fused+jcc 
```

## Description of Compiler Runtime Parameters

1. **--x86-align-branch-boundary** : This parameter specifies the bit in the branch address that you want to pin. To set bit `n`, you should provide `2^(n+1)` as the value. For example, to pin bit `5`, you would provide `64`.
   
2. **--x86-align-skew** : This parameter determines whether bit n will be set to 0 or 1. To set the bit to 0, provide `0` as the value; to set it to 1, provide `2^n`.
   
3. **--x86-align-branch** : This parameter specifies the types of branches to align. Possible options include `jcc`, `fused`, `jmp`, `call`, `ret`, and `indirect`. For Half&Half purposes, only conditional branches are aligned, so you would use `--x86-align-branch=fused+jcc`.
   
5. **--x86-branch-before-nops** : This option controls whether a jump instruction is emitted before padding with NOP instructions, which optimizes the process by jumping over the NOPs. The default value is `17`.
