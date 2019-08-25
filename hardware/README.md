Pong SNMP Hardware Description
===
This is the hardware part of Pong game project of SNMP group written in Verilog. The code is built optimized for Basys 3 board.

## About the Architecture
The components in this architecture are:

* CPU
* Memory-mapped I/O
    * Memory: 128-kbit storage, 13-bit address line (0x0000 ~ 0x1fff), 16-bit line
    * VGA Memory: 0xff00 ~ 0xff0f
    * PS/2 Keyboard Reader: 0xffe0, Read-only, Interrupt
    * Switch: 0xfff0, Read-only
    * 7-segment Display: 0xfff8 ~ 0xfffb, 0xfffe ~ 0xffff, Write-only

## CPU

* 16-bit data line
* 16-bit address line
* 32 registers
* 32-bit instruction length
* 1 interrupt line

### Instruction Format
The instruction length is 32 bits. Four most significant bits are for opcode. The other 28 bits vary in different opcodes. The detail for each opcode are as follows. `P` is opcode option, `R`, `S` and `T` are register numbers and `A` is data or memory addresss.

* 0b0001: Load to register
    * Format: 0001PPRRRRRSSSSSAAAAAAAAAAAAAAAA
    * Options
        * 0b00: Load immediate value A to register R
        * 0b01: Load direct from memory address A to register R
        * 0b10: Load register indirect S to register R
* 0b0010: Store to memory
    * Format: 0010PPRRRRRSSSSSAAAAAAAAAAAAAAAA
    * Options
        * 0b01: Store value from register R to memory address A
        * 0b10: Store value from register R to memory whose address is value from register S
* 0b0011: Move data from one register to another
    * Format: 0011xxRRRRRSSSSSxxxxxxxxxxxxxxxx
    * Move data to register R from register S
* 0b0100: ALU operations
    * Format: 0100xxRRRRRSSSSSTTTTTxxxxxxxPPPP
    * Do ALU operation on register R and S and store in register T
    * Options
        * 0b0001: T = R + S
        * 0b0010: T = R - S
        * 0b0011: T = R * S
        * 0b0100: T = R / S
        * 0b0101: T = R % S
        * 0b0110: T = R & S
        * 0b0111: T = R | S
        * 0b1000: T = R ^ S
        * 0b1001: T = ~R
        * 0b1010: T = -R
        * 0b1011: T = R << S
        * 0b1100: T = R >> S
* 0b0101: Compare value between two registers
    * Format: 0101xxRRRRRSSSSSxxxxxxxxxxxxxxxx
    * Compare two registers and set flag
* 0b0110: Jump with or without condition
    * Format: 0110PPPxxxxxxxxxAAAAAAAAAAAAAAAA
    * Options
        * 0b000: Unconditional jump
        * 0b001: Jump if equal
        * 0b010: Jump if not equal
        * 0b011: Jump if less than
        * 0b100: Jump if less than or equal to
        * 0b101: Jump if greater than
        * 0b110: Jump if greater than or equal to
* 0b0111: Call a new subroutine
    * Format: 0111xxxxxxxxxxxxAAAAAAAAAAAAAAAA
    * Push current program counter to program stack and jump to address A
* 0b1000: Return from subroutine
    * Format: 1000xxxxxxxxxxxxxxxxxxxxxxxxxxxx
    * Jump to the value in the top of program stack and pop the program stack
* 0b1001: Branch from the current instruction with or without condition
    * Format: 1001PPPxxxxxxxxxAAAAAAAAAAAAAAAA
    * Options: Same as jump
* 0b1010: Push value from register to the stack
    * Format: 1010xxRRRRRxxxxxxxxxxxxxxxxxxxxx
    * Push value from register R to data stack
* 0b1011: Pop value from stack to register
    * Format: 1011xxRRRRRxxxxxxxxxxxxxxxxxxxxx
    * Set value of register R to the top of data stack and pop the data stack

### Interruption
When interrupt request line is triggered, the program will move to address 0x0002. So, it is not recommended to put normal program flow in this area. In the first instruction (0x0000), it is recommended to jump to the memory address after the interrupt function. To end the interrupt function and return to the normal flow, use return instruction (0b1000).

## Seven-segment registers
There is a 16-bit register to store seven-segment display data. There are many options that you can use to set the number in the register.

* 0xfff8: Write to the rightmost digit with hexadecimal value
* 0xfff9: Write to the second rightmost digit with hexadecimal value
* 0xfffa: Write to the second leftmost digit with hexadecimal value
* 0xfffb: Write to the leftmost digit with hexadecimal value
* 0xfffe: Write all digits with hexadecimal value
* 0xffff: Write all digits with decimal value

## How to use the keyboard
When a keyboard button is pressed or released, the interrupt request line is triggered, causing the program to move to address 0x0002. To handle the value received from keyboard, read memory-mapped I/O address 0xffe0 to get data.
