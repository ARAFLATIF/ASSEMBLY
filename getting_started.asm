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


LSL, LSR AND ROR : 


Logical Shift Left (LSL) for Multiplication
LSL multiplies a number by 2^n, where n is the shift amount.

MOV R0, #5        ; R0 = 5
LSL R1, R0, #2    ; R1 = R0 * 2^2 = 5 * 4 = 20

LSL R1, R0, #2    ; R1 = R0 * 2^2 = 5 * 4 = 20

How it works:
Shifting left by 1 multiplies by 2
Shifting left by 2 multiplies by 4
Shifting left by 3 multiplies by 8, and so on



Logical Shift Right (LSR) for Division
LSR divides a number by 2^n, where n is the shift amount.

MOV R0, #20       ; R0 = 20
LSR R1, R0, #2    ; R1 = R0 / 2^2 = 20 / 4 = 5


How it works:
Shifting right by 1 divides by 2
Shifting right by 2 divides by 4
Shifting right by 3 divides by 8, and so on


Key Points to Remember
Efficiency: Shift operations are much faster than actual multiplication or division instructions.
Precision: LSR for division works precisely only for even numbers. Odd numbers will be rounded down.
Signed vs. Unsigned: LSR always treats the number as unsigned. For signed numbers, use ASR (Arithmetic Shift Right).
Overflow: Be cautious of overflow when using LSL for large numbers or shift amounts.
Zero Shift: LSL #0 is valid and doesn't change the value, often used as a no-op or for flag setting.



Sample Code Demonstrating Various Shifts : 

.global _start
_start:
    ; Multiplication by shifts
    MOV R0, #5
    LSL R1, R0, #1    ; R1 = 5 * 2 = 10
    LSL R2, R0, #3    ; R2 = 5 * 8 = 40

    ; Division by shifts
    MOV R3, #64
    LSR R4, R3, #3    ; R4 = 64 / 8 = 8

    ; Combining shifts
    MOV R5, #15
    LSL R6, R5, #4    ; R6 = 15 * 16 = 240
    LSR R7, R6, #2    ; R7 = 240 / 4 = 60

    ; Shift with register
    MOV R8, #2
    LSL R9, R5, R8    ; R9 = 15 * 4 = 60


Practical Applications
Fast multiplication/division: For multiplying or dividing by powers of 2.
Bit manipulation: For setting, clearing, or testing specific bits.
Efficient power calculations: For calculating 2^n quickly.
Packing/unpacking data: For working with bit fields or flags.



CONDITIONS AND BRANCHES :

SAMPLE CODE : 

.global _start
_start:
	MOV R0,#1
	MOV R1,#2
	
	CMP R0,R1
	
	BGT greater
	BAL default
	
greater:
	mov R2, #1

default:
	MOV R2,#2

CODE EXPLANATION : 

The code initializes R0 with 1 and R1 with 2.
It then compares R0 and R1 using the CMP instruction.
Based on the comparison, it uses conditional branches:
BGT (Branch if Greater Than) to the 'greater' label
BAL (Branch Always) to the 'default' label
The 'greater' and 'default' labels set R2 to different values.



Key Concepts
Comparison (CMP):
CMP R0, R1 subtracts R1 from R0 and sets condition flags but doesn't store the result.
Condition Flags:
N (Negative), Z (Zero), C (Carry), V (Overflow)
Set based on the result of arithmetic and logical operations.
Conditional Branches:
Execute based on the state of condition flags.


Common Branch Conditions
B: Branch always
BEQ: Branch if Equal (Z set)
BNE: Branch if Not Equal (Z clear)
BGT: Branch if Greater Than (Z clear AND N == V)
BLT: Branch if Less Than (N != V)
BGE: Branch if Greater Than or Equal (N == V)
BLE: Branch if Less Than or Equal (Z set OR N != V)
BHI: Branch if Higher (unsigned, C set AND Z clear)
BLS: Branch if Lower or Same (unsigned, C clear OR Z set)



Study Notes
Comparison and Flags:
CMP sets flags without changing register values.
Use these flags for conditional execution.
Branch Instructions:
Change program flow based on conditions.
Use meaningful labels for clarity.
Conditional Execution:
Most ARM instructions can be conditionally executed.
Add condition codes to instructions (e.g., MOVEQ, ADDNE).
Optimization:
Use conditional execution to reduce branches and improve performance.
Common Patterns:
Compare then branch for if-else structures.
Use loops with conditional branches for while/for loops.
Link Register:
BL (Branch with Link) stores return address in LR (R14).
Used for function calls.
Range Limitations:
Branch instructions have a limited range (±32MB).
For longer jumps, use indirect branching through registers.



LOOPS WITH BRANCHES :

SAMPLE CODE : 

.global _start
.equ endlist, 0xaaaaaaaa
_start:
    LDR R0,=list
    LDR R3,=endlist
    LDR R1,[R0]
    ADD R2,R2,R1
loop:
    LDR R1,[R0,#4]!
    CMP R1,R3
    BEQ exit
    ADD R2,R2,R1
    BAL loop
    
exit:

.data
list:
    .word 1,2,3,4,5,6,7,8,9,10


CODE EXPLANATION : 

The code defines a constant endlist with value 0xaaaaaaaa.
It loads the address of list into R0 and endlist into R3.
The first element of the list is loaded into R1 and added to R2.
The loop starts by loading the next element into R1.
It compares the loaded value with the end marker (R3).
If equal, it branches to exit.
Otherwise, it adds the value to R2 and loops back.


Otherwise, it adds the value to R2 and loops back.
Key Concepts
Loop Implementation:
Uses a combination of loading, comparing, and branching.
Continues until a specific condition is met.
Memory Access:
LDR R1,[R0,#4]! loads a value and updates the address (post-indexed addressing).
Conditional Branching:
BEQ exit branches if the comparison result is equal.
BAL loop always branches back to the loop start.
Data Section:
.data section contains the list of numbers to be processed.



Common Branch Instructions
B: Branch always
BEQ: Branch if Equal
BNE: Branch if Not Equal
BGT: Branch if Greater Than
BLT: Branch if Less Than
BGE: Branch if Greater Than or Equal
BLE: Branch if Less Than or Equal
BAL: Branch Always (unconditional)


Study Notes
Loop Structure:
Initialization before the loop
Condition check at the beginning or end
Body of the loop
Update of loop variables
Memory Addressing:
Use of base register (R0) with offset for array access
Pre-indexed and post-indexed addressing modes
Comparison and Branching:
CMP sets flags for conditional execution
Branch instructions use these flags
Data Processing:
Accumulation of values in R2
Termination Condition:
Use of a specific value (endlist) to mark the end of data
Efficiency:
Minimizing branches improves performance
Using conditional execution where possible
Register Usage:
R0: Address pointer
R1: Current element
R2: Accumulator
R3: End marker

CONDITIONAL INSTRUCTION EXECUTION :

SAMPLE PROGRAM : 

.global _start
_start:
    MOV R0, #2
    MOV R1, #4
    CMP R1, R0
    MOVGE R2, #5


CODE EXPLANATION : 

MOV R0, #2: Loads the value 2 into register R0.
MOV R1, #4: Loads the value 4 into register R1.
CMP R1, R0: Compares the values in R1 and R0. This sets the condition flags in the CPSR (Current Program Status Register).
MOVGE R2, #5: This is a conditional move instruction. It will only execute if the condition "GE" (Greater than or Equal to) is true based on the previous comparison.

The key point here is the conditional execution:
The CMP instruction sets the condition flags based on R1 - R0 (4 - 2 in this case).
MOVGE will only execute if R1 is greater than or equal to R0, which is true in this case.
If the condition is met (which it is), R2 will be set to 5.

This demonstrates ARM's ability to conditionally execute instructions based on the state of the condition flags, 
allowing for efficient branching and conditional operations without explicit jump instructions



BRANCH WITH LINK REGISTER AND RETURNS :

SAMPLE PROGRAM :

.global _start
_start:
    MOV R0, #1
    MOV R1, #3
    BL add2
    MOV R3, #4
    
add2:
    ADD R2, R0, R1
    bx lr

CODE EXPLANATION : 

The program starts by setting up initial values:
R0 is set to 1
R1 is set to 3
BL add2: This is the Branch with Link instruction. It does two things:
It branches to the add2 label (subroutine)
It stores the return address (address of the next instruction) in the Link Register (LR)
The add2 subroutine:
Adds the values in R0 and R1, storing the result in R2
bx lr: This instruction branches to the address stored in LR, effectively returning from the subroutine
After returning from the subroutine, the program continues by moving 4 into R3


Key concepts:
Subroutine: A reusable block of code that can be called from different parts of the program.
BL (Branch with Link): Used to call subroutines. It jumps to the specified address and saves the return address in LR.
Link Register (LR): A special register (R14) that stores the return address when a subroutine is called.
bx lr: Used to return from a subroutine. It branches to the address stored in LR.
Register preservation: In this simple example, the subroutine doesn't need to preserve register values. 
In more complex scenarios, you might need to save and restore registers used within the subroutine.



PRESERVING AND RETRIVING DATA FROM STACK MEMORY :

SAMPLE CODE : 

.global _start
_start:
    MOV R0, #1
    MOV R1, #3
    PUSH {R0, R1}
    BL get_value
    POP {R0, R1}
    B end

get_value:
    MOV R0, #5
    MOV R1, #7
    ADD R2, R0, R1
    BX lr

end:


Key concepts and explanations:

Stack Operations:
PUSH {R0, R1}: This instruction pushes the values of R0 and R1 onto the stack. It's used to preserve these values before calling a function.
POP {R0, R1}: This retrieves the previously pushed values from the stack back into R0 and R1.
Function Call:
BL get_value: Branch with Link to the get_value function. This saves the return address in the link register (LR).
Function Return:
BX lr: Branch and Exchange using the link register. This returns from the function to the calling point.
Register Preservation:
The main code preserves R0 and R1 before calling get_value, which modifies these registers.
After the function call, the original values are restored.
Local Variables in Functions:
get_value uses R0, R1, and R2 for its own calculations without affecting the caller's data.
Stack Frame:
Although not explicitly shown, the PUSH and POP operations create a simple stack frame for preserving data across function calls.


Important points:
Stack grows downwards in ARM architecture.
PUSH decreases the stack pointer, while POP increases it.
The order of registers in PUSH and POP matters; they are processed in ascending order.
This method of preserving registers is crucial for maintaining data integrity across function calls.
In more complex scenarios, you might need to preserve more registers or allocate local variables on the stack.

HARDWARE INTERACTION : 

Interacting with Switches:
The video demonstrates how to read the state of switches connected to the ARM processor. Here's a sample code snippet:

.equ SWITCH_BASE, 0xFF200000  ; Address of switches

LDR R0, =SWITCH_BASE
LDR R1, [R0]  ; Load the value of switches into R1

This code loads the state of the switches into register R1. Each bit in R1 represents the state of a switch (on or off).



Interacting with LEDs:
The video shows how to control LEDs using the values read from switches. Here's a sample code:

.equ LED_BASE, 0xFF200000  ; Address of LEDs

LDR R0, =SWITCH_BASE
LDR R1, [R0]        ; Read switch values
LDR R0, =LED_BASE
STR R1, [R0]        ; Write switch values to LEDs


This code reads the switch values and then writes them directly to the LEDs, causing the LEDs to light up based on the switch positions.



Binary Representation:
The video explains that the switches and LEDs represent binary values. For example, if the rightmost switch is on, it represents 2^0 (1 in decimal), the next switch represents 2^1 (2 in decimal), and so on.


Memory-Mapped I/O:
The hardware devices (switches and LEDs) are accessed using specific memory addresses. This is known as memory-mapped I/O.

Input and Output:
The switches serve as input devices, while the LEDs serve as output devices, demonstrating basic I/O operations in assembly.


This example demonstrates how to read input from switches and control output to LEDs, providing a foundation for understanding hardware interactions in ARM assembly programming.


PRINTING CODE TO THE TERMINAL : 

SAMPLE CODE : 

.global _start
_start:
    MOV R0, #1         ; File descriptor for stdout (1)
    LDR R1, =message   ; Load the address of the message into R1
    LDR R2, =len       ; Load the length of the message into R2
    MOV R7, #4         ; System call number for write (4)
    SWI 0              ; Invoke the system call to write the message

    MOV R7, #1         ; System call number for exit (1)
    SWI 0              ; Invoke the system call to exit the program

.data
message:
   .asciz "Hello World \n" ; The string to be printed, null-terminated
len =.-message         ; Calculate the length of the message


Key Components
System Call for Writing:
MOV R0, #1: Sets the file descriptor for stdout (standard output).
LDR R1, =message: Loads the address of the string "Hello World \n" into R1.
LDR R2, =len: Loads the length of the string into R2.
MOV R7, #4: Sets the system call number for write (4).
SWI 0: Invokes the system call to write the string to the terminal.
System Call for Exit:
MOV R7, #1: Sets the system call number for exit (1).
SWI 0: Invokes the system call to exit the program.
Data Section:
message: Defines the string "Hello World \n" using the .asciz directive, which null-terminates the string.
len =.-message: Calculates the length of the string by subtracting the current address from the address of the message label.



Step-by-Step Process
Initialize Registers:
Set R0 to 1, which is the file descriptor for stdout.
Load the address of the message into R1.
Load the length of the message into R2.
Invoke Write System Call:
Set R7 to 4, which is the system call number for write.
Use SWI 0 to invoke the system call, which writes the string to the terminal.
Exit Program:
Set R7 to 1, which is the system call number for exit.
Use SWI 0 to invoke the system call, which exits the program.


Assembling and Running the Code
To assemble and run this code on a Raspberry Pi, you would typically follow these steps:
Save the Code:
Save the above code in a file named hello.s.
Assemble the Code:
Use the assembler to convert the assembly code into an object file.

as -o hello.o hello.s

Link the Code:
Link the object file to create an executable.

ld -o hello hello.o

Run the Code:
Execute the program.

./hello



This will print "Hello World \n" to the terminal and then exit the program.

### Additional Notes

- **System Calls**: The `SWI 0` instruction is used to invoke system calls. The value in R7 determines which system call to invoke.
- **Registers**: R0, R1, and R2 are used to pass arguments to the system call. R7 is used to specify the system call number.
- **Data Section**: The `.data` section is used to define data that will be used by the program. The `.asciz` directive is used to define null-terminated strings.

By following this example, you can understand how to print strings to the terminal using ARM assembly on a Raspberry Pi[3][4].





DEBUGGING ARM PROGRAMS WITH GDB

To debug ARM programs using GDB, you need to follow a series of steps that involve compiling your code, launching GDB, setting breakpoints, and stepping through your program. Here’s a detailed example to illustrate this process:

Step 1: Compile Your ARM Assembly Code
First, you need to compile your ARM assembly code into an executable. Here is an example of a simple "Hello World" program in ARM assembly:


.global _start
_start:
    MOV R0, #1
    LDR R1, =message
    LDR R2, =len
    MOV R7, #4
    SWI 0

    MOV R7, #1
    SWI 0

.data
message:
   .asciz "Hello World \n"
len =.-message

Compile this code using the ARM cross-compiler:

as -o hello.o hello.s
ld -o hello hello.o


Step 2: Launch GDB
Launch GDB with your compiled executable:

gdb./hello

Step 3: Set Breakpoints
Once GDB is launched, you can set breakpoints at specific locations in your code. For example, you can set a breakpoint at the _start label:

(gdb) break _start

Step 4: Run the Program
Start the execution of your program:

(gdb) run

GDB will stop at the breakpoint you set.

Step 5: Examine Registers and Memory
You can examine the registers and memory to see the current state of your program. Here are some commands you can use:
List the current instruction: disassemble _start
Show the registers: info registers
Examine memory: x/s &message (to see the string stored at the message label)

EXAMPLE : 

(gdb) disassemble _start
(gdb) info registers
(gdb) x/s &message

Step 6: Step Through the Program
You can step through your program instruction by instruction using the step or next commands:

(gdb) step
(gdb) next

Step 7: Continue Execution
If you want to continue the execution until the next breakpoint or until the program finishes, use the continue command:

(gdb) continue

Example GDB Session
Here is an example of what a GDB session might look like:

(gdb) break _start
Breakpoint 1 at 0x10000: file hello.s, line 3.
(gdb) run
Starting program: /path/to/hello 

Breakpoint 1, _start () at hello.s:3
3             MOV R0, #1
(gdb) info registers
r0             0x0      0
r1             0x0      0
r2             0x0      0
r3             0x0      0
r4             0x0      0
r5             0x0      0
r6             0x0      0
r7             0x0      0
r8             0x0      0
r9             0x0      0
r10            0x0      0
r11            0x0      0
sp             0x7ffffff0       0x7ffffff0
lr             0x0      0
pc             0x10000  0x10000 <_start>
cpsr           0x60000010       [Z flag clear]

(gdb) step
4             LDR R1, =message
(gdb) info registers
r0             0x1      1
r1             0x10020  65536
r2             0x0      0
r3             0x0      0
r4             0x0      0
r5             0x0      0
r6             0x0      0
r7             0x0      0
r8             0x0      0
r9             0x0      0
r10            0x0      0
r11            0x0      0
sp             0x7ffffff0       0x7ffffff0
lr             0x0      0
pc             0x10004  0x10004 <_start+4>
cpsr           0x60000010       [Z flag clear]

(gdb) x/s &message
0x10020:       "Hello World \n"
(gdb) continue
Continuing.

Program received signal SIGTRAP, Trace/breakpoint trap.
0x10010 in _start () at hello.s:9
9              MOV R7, #1
(gdb) quit

This example demonstrates how to use GDB to debug an ARM assembly program, including setting breakpoints, examining registers and memory, and stepping through the code


