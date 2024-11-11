FUNDAMENTALS OF HEX ADECIMAL : 

Bits: Each hexa decimal digit represents 4 bits1. For example:
0 = 0000
F = 1111
Bytes: A byte (8 bits) is represented by two hexadecimal digits3. For instance:
00 = 00000000
FF = 11111111
This system allows for efficient representation of binary data:
1 hex digit = 4 bits (half a byte or a nibble)
2 hex digits = 8 bits (1 byte)
4 hex digits = 16 bits (2 bytes)
8 hex digits = 32 bits (4 bytes)

*** WE WILL ALWAYS BE WORKING IN HEXADECIMAL AND ALWAYS KEEP THAT IN MIND

## BASIC INTRODUCTION AND OVERVIEW OF THE REGISTERS : 

The ARM processor has 16 main registers (R0-R15), each 32 bits wide. Here's a brief overview of their typical uses:
R0-R12: General-purpose registers for data storage and manipulation.
R13 (SP): Stack Pointer, holds the address of the top of the stack. [ALWAYS TELLING US THE ADDRESS OF THE NEXT AVAILABLE MEMORY ON THE STACK]
[THE NEXT ADDRESS IS ALWAYS GOING TO BE 4 LARGER, AND ALWAYS REMEMBER THAT WE ARE COUNTING IN HEXADECIMAL, SO KEEP THAT IN MIND WHILE COUNTING AND ANALYZING]
R14 (LR): Link Register, stores the return address when calling functions. [STORES LOCATION]
R15 (PC): Program Counter, contains the address of the next instruction to be executed. [KEEPS TRACK OF LOCATION]
Some key points:
R0-R3 are often used for passing parameters to functions and returning results.
R4-R11 are typically used for local variables within functions.
R12 is sometimes used as a scratch register or for special purposes.
The ARM also has a 17th register called the Current Program Status Register (CPSR), which stores processor status and control bits1.


## cpsr register is used to store information about a program, some example is the difference of 2 numbers
and the difference of 2 numbers can be a negative number and to store this negative number we need to use the 2s 
complement to store it in the binary format. cpsr sets a flag in the memory and through that if the result is a negative
number and then when we take a look into it later then we can decide that okay it was/is a negative number. 
Some examples are carrier, overflow, flags and many more and that will be learned later on. 

## spsr :

The SPSR (Saved Program Status Register) is closely related to the CPSR (Current Program Status Register) in ARM architecture. Here's an explanation of the SPSR:
The SPSR is a register that stores a copy of the CPSR when an exception occurs. Its primary purpose is to preserve the processor state before entering an exception handler.
Key points about the SPSR include:
Exception handling: When an exception (like an interrupt) occurs, the current CPSR is automatically saved to the SPSR of the exception mode1.
State preservation: It maintains the processor state (flags, mode bits, etc.) that existed before the exception, allowing for proper return to the previous state.
Multiple instances: Each exception mode (e.g., FIQ, IRQ, Abort) has its own SPSR1.
Restoration: When returning from an exception, the SPSR is used to restore the CPSR, ensuring the processor returns to its pre-exception state.
Content: Like the CPSR, it contains condition flags (N, Z, C, V), interrupt disable bits, and the processor mode bits1.
Accessibility: The SPSR is only accessible in privileged modes, not in User mode1.
Context switching: It plays a crucial role in context switching, allowing the processor to switch between different tasks or handle interrupts without losing the previous execution context.
The SPSR is essential for maintaining program flow and state during exception handling, ensuring that the processor can correctly resume normal operation after handling exceptions or interrupts.

The first program written from the tutorial : 

.global _start
_start:
	
	MOV R0,#30
	
	MOV R7,#1
	SWI 0

explanation :

The .global _start directive and _start: label define the entry point of your program1
. This is where execution begins when the program is run.

Register Operations
MOV R0, #30: This instruction moves the immediate value 30 into register R01
. In ARM assembly, the # symbol denotes an immediate value.
MOV R7, #1: This instruction moves the immediate value 1 into register R7

SYSTEM CALL : 

SWI 0: This is a software interrupt instruction, which is used to make a system call1
. In ARM assembly, system calls are typically made by:
Placing the system call number in R7
Putting any arguments in other registers (R0-R6)
Executing the SWI (Software Interrupt) instruction

Crucial Concepts:

Registers: ARM processors have a set of general-purpose registers (R0-R12) that can be used for various operations1
. R0-R6 are often used for passing arguments to functions or system calls.
Special Registers:
R7 is conventionally used to hold the system call number1
.
R15 is the Program Counter (PC)
R14 is the Link Register (LR)
R13 is the Stack Pointer (SP)

Immediate Values: In ARM assembly, immediate values are preceded by # and represent constant values that can be directly used in instructions1
.
System Calls: These are requests to the operating system to perform operations like input/output or program termination1
. In this case, the system call number 1 typically represents the "exit" system call.
Instruction Syntax: ARM instructions generally follow the format: INSTRUCTION DESTINATION, SOURCE, where the destination is usually the first operand

ADDRESSING, SAMPLE CODE : 

.global _start
_start:
	LDR R0,=list
	LDR R1, [R0]
	LDR R2,[R0],#4
.data
list:
	.word 4,5,-9,0,2,-3

EXPLANATION AND CRUCIAL CONCEPTS : 

Data Section
The .data directive indicates the start of the data section, where you define your variables and constants

Label and Data Definition :
list:
    .word 4,5,-9,0,2,-3
This creates a label list and defines an array of 6 32-bit words

Loading Address : 
LDR R0,=list
This loads the address of list into R0. The = is a pseudo-instruction that tells the assembler to load the address, not the value at that address

INDIRECT ADDRESSING : 
LDR R1, [R0]
This loads the value at the address stored in R0 into R1. The brackets [] indicate indirect addressing4

POST-INCREMENT ADDRESSING : 
LDR R2,[R0],#4
This is an example of post-increment addressing. It loads the value at the address in R0 into R2, then increments R0 by 4 bytes

Pre-Increment vs Post-Increment

Pre-Increment:
Syntax: LDR Rx, [Ry, #n]!
The base register (Ry) is incremented before the memory access.
Example: LDR R2, [R0, #4]! would increment R0 by 4, then load the value at the new address into R2.

Post-Increment:
Syntax: LDR Rx, [Ry], #n
The base register (Ry) is incremented after the memory access.
Your code uses this: LDR R2,[R0],#4 loads the value at R0 into R2, then increments R0 by 4.


Crucial Concepts to Understand:

Addressing Modes: ARM provides various addressing modes for flexible memory access210.
Register Indirect Addressing: Using registers to hold memory addresses for data access10.
Pseudo-Instructions: Some assembly instructions (like LDR Rx,=label) are translated by the assembler into one or more actual machine instructions9.
Word Alignment: ARM typically works with 4-byte (32-bit) aligned data, which is why the increment is often 4 bytes4.
Load/Store Architecture: ARM uses a load-store model, where data must be loaded into registers before being operated on


ARITHMETIC AND CPSR SAMPLE CODE :

.global _start
_start:
	MOV R0, #0xFFFFFFFFFFFFFF
	MOV R1, #3
	ADC R2,R0,R1//R2=R0+R1+CARRY

EXPLANATION : 

The first line sets up the entry point of the program.
MOV R0, #0xFFFFFFFFFFFFFF loads a large hexadecimal value into R0.
MOV R1, #3 loads the value 3 into R1.
ADC R2, R0, R1 performs addition with carry: R2 = R0 + R1 + Carry Flag.


Key Concepts:

ADC Instruction
ADC (Add with Carry) adds three values: the two operands and the carry flag4. It's used for multi-precision arithmetic or when you need to include a previous carry in your calculation.


CPSR (Current Program Status Register)
The CPSR contains important flags that reflect the result of arithmetic and logical operations2:
N (Negative): Set if the result is negative.
Z (Zero): Set if the result is zero.
C (Carry): Set if there's a carry out from the most significant bit.
V (Overflow): Set if there's a signed overflow.

Carry Flag
The carry flag is particularly important for the ADC instruction. It allows for chaining multiple additions for larger numbers than can fit in a single register


Important Points to Remember
Immediate Values: In ARM, immediate values (like #3) are constants embedded in the instruction.
Flag Setting: Not all instructions set flags by default. You can append 'S' to many instructions to update the CPSR flags (e.g., ADDS, ADCS)6.
Hexadecimal Notation: ARM assembly uses '#' to denote immediate values, including hexadecimal numbers.
Register Usage: R0-R12 are general-purpose registers. R13-R15 have special purposes (stack pointer, link register, program counter).
Arithmetic Operations: ARM provides various arithmetic instructions like ADD, SUB, MUL, etc., each with specific uses and effects on flags6.
Conditional Execution: ARM allows for conditional execution of instructions based on CPSR flags, enhancing code efficiency5



LOGICAL OPERATIONS : 

AND (Bitwise AND) : 

MOV R0, #0xFF       ; R0 = 0xFF (11111111 in binary)
MOV R1, #0xA5       ; R1 = 0xA5 (10100101 in binary)
AND R2, R0, R1      ; R2 = R0 AND R1 (10100101 = 0xA5)


ORR (Bitwise OR):

MOV R0, #0x0F       ; R0 = 0x0F (00001111 in binary)
MOV R1, #0xF0       ; R1 = 0xF0 (11110000 in binary)
ORR R2, R0, R1      ; R2 = R0 OR R1 (11111111 = 0xFF)


EOR (Bitwise XOR):

MOV R0, #0xAA       ; R0 = 0xAA (10101010 in binary)
MOV R1, #0x55       ; R1 = 0x55 (01010101 in binary)
EOR R2, R0, R1      ; R2 = R0 XOR R1 (11111111 = 0xFF)


BIC (Bit Clear):

MOV R0, #0xFF       ; R0 = 0xFF (11111111 in binary)
MOV R1, #0xF0       ; R1 = 0xF0 (11110000 in binary)
BIC R2, R0, R1      ; R2 = R0 AND (NOT R1) (00001111 = 0x0F)


MVN (Bitwise NOT):

MOV R0, #0xAA       ; R0 = 0xAA (10101010 in binary)
MVN R1, R0          ; R1 = NOT R0 (01010101 = 0x55)

EXPLANATION AND KEY POINTS TO KEEP IN MIND : 

Immediate Values: Use '#' before immediate values (e.g., #0xFF).
Register Operands: When using registers as operands, don't use '#' (e.g., AND R2, R0, R1).
MVN (Move Negative): This performs a bitwise NOT operation.
BIC (Bit Clear): Clears specific bits. It's equivalent to AND with the complement of the second operand.
Flags: These instructions don't typically affect the condition flags unless you add 'S' to the mnemonic (e.g., ANDS, ORRS).
Versatility: These operations can be used for various purposes beyond simple logic, such as masking bits or toggling specific bit patterns.
Combining Operations: You can often combine logical operations to achieve more complex bit manipulations.
Zero and Ones: Remember that AND with 0 clears bits, OR with 1 sets bits, and XOR with 1 inverts bits.

EXPLANATION OF THIS PART :  R2 = R0 AND R1 (10100101 = 0xA5)

Operands:
R0 contains 0xFF (11111111 in binary)
R1 contains 0xA5 (10100101 in binary)

AND Operation:
The AND operation compares each bit of R0 with the corresponding bit of R1:

R0: 1 1 1 1 1 1 1 1
R1: 1 0 1 0 0 1 0 1
------------------
R2: 1 0 1 0 0 1 0 1

Result:
The result in R2 is 10100101 in binary
This binary number equals 0xA5 in hexadecimal

THIS IS HOW THE OTHER OPERATIONS ARE ALSO DONE 
