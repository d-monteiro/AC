
## RISC-V-Assembler

The assembler is implemented in C++ and reads assembly code from `assembly_code.txt`, converts it into machine code, and writes the output to `machine_code.txt`.

It trims comments and other unwanted characters.

### Usage

To compile and run, use the provided Makefile:

```sh
make compiler
```

To clean up, use:

```sh
make clear
```