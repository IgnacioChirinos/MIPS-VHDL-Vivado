# MIPS-VHDL-Vivado
<a name="br1"></a>The next project has the objective of the creation of a MIPS processor using XILINX and
VHDL. The final objective for the processor is to perform a matrix multiplication.

Each part of the MIPS processor architecture works together to execute instructions. The
instruction is fetched from the instruction memory and sent to the instruction decoder. The
instruction decoder determines the operation to be performed and the registers involved, and
sends control signals to the other parts of the processor. The register file and data memory
are used to store and retrieve data during program execution. The ALU performs arithmetic
and logical operations on the data stored in the registers. Finally, the control unit generates
control signals that coordinate the operation of the different parts of the processor.

● Instruction Memory (IM): The instruction memory contains the instructions to be

executed by the processor. The program counter (PC) points to the next instruction to
be executed, and the instruction memory returns the corresponding instruction to the
instruction decoder.

● Instruction Decoder (ID): The instruction decoder decodes the instruction fetched

from the instruction memory and generates control signals for the other parts of the
processor. It identifies the type of instruction and determines the operands and
operations to be performed.

● Register File (RF): The register file contains 32 registers, each 32 bits wide. The

instruction decoder specifies which registers to read or write, and the register file
provides the values stored in the specified registers.

● ALU: The arithmetic logic unit (ALU) performs arithmetic and logical operations on

the input operands received from the register file or immediate values from the
instruction decoder. It generates a result and status flags, such as overflow or carry,
which are used by subsequent parts of the processor.

● Data Memory (DM): The data memory stores data values that are read or written by

the processor. It receives addresses and data from the ALU or register file, and
returns data values to be stored in the register file or written back to memory.

● Control Unit (CU): The control unit generates control signals based on the current

instruction being executed and the status flags generated by the ALU. It controls the
flow of data and instructions through the processor, as well as the operation of
various other parts of the processor.

● PC Update: The PC update unit increments the program counter to point to the next

instruction in memory. It may also modify the program counter based on branch or
jump instructions.
