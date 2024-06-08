# RISC-V Compiler and Processor

This repository contains a RISC-V Compiler and Processor implemented in C++ and Verilog respectively.

## Structure

The repository is divided into three main parts:

1. **RISC-V-Compiler**: A compiler that converts assembly code into machine code (only works for R-type and I-type instructions).
2. **RISC-V-Processor**: A RISC-V Processor implemented in Verilog (only works for R-type and I-type instructions).
3. **Example-RISC-V**: Contains example Verilog modules and testbenches (not done by me).

## RISC-V-Compiler

The compiler is implemented in C++ and reads assembly code from `assembly_code.txt`, converts it into machine code, and writes the output to `machine_code.txt`.

### Usage

To compile and run the compiler, use the provided Makefile:

```sh
make compiler