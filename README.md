# 16-bit MIPS-style Processor Datapath (VHDL)

VHDL modules for a simplified 16-bit MIPS-like processor, written in Vivado for a Computer Architecture lab at the Technical University of Cluj-Napoca.

> **Status:** these are the building blocks of the datapath. The top-level module and the pipeline registers are **not** included, so this is not a complete pipelined CPU yet.

## Modules

| File | Role |
|---|---|
| `inst_fetch.vhd` | Program counter, 256 x 16-bit instruction ROM, PC+1 adder, branch and jump multiplexers |
| `instr_decode.vhd` | Instruction decoding, destination-register selection and register-file access (8 x 16-bit registers) |
| `main_control.vhd` | Control unit: decodes the 3-bit opcode into `reg_dst`, `ext_op`, `alu_src`, `branch`, `jump`, `alu_op`, `mem_write`, `mem_to_reg`, `reg_write` |
| `REG_file.vhd` | Register file: 8 x 16-bit registers, two read ports, one write port |
| `exec_unit.vhd` | ALU control, ALU, second-operand multiplexer, branch target address and zero flag |
| `mem_unit.vhd`, `ram.vhd` | Data memory access |

## Instruction format

16-bit instructions. R-type is `opcode(3) rs(3) rt(3) rd(3) sa(1) func(3)`.

- **R-type** (opcode `000`): `ADD`, `SUB`, `SLL`, `SRL`, `AND`, `OR`, `NOR`, `XOR`, selected by `func`.
- **I-type**: `ADDI`, `LW`, `SW`, `BEQ`, `BGEZ`, `BLTZ`.
- **J-type** (opcode `111`): jump.

The ROM in `inst_fetch.vhd` contains a short test program (add, sub, shift left, shift right).

## Use

Open the sources in Vivado, add the files under `Lab6.srcs/sources_1/new/` and simulate the modules with your own testbench.
