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
