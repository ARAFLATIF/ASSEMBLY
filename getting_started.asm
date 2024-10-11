FUNDAMENTALS OF HEXADECIMAL : 

Bits: Each hexadecimal digit represents 4 bits1. For example:
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
