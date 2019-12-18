# SB Compiler

This is the compiler which translates .sb file into machine code for this architecture in the memory file format that can be used in Vivado.

## Usage

To compile from .sb to machine code, run

```sh
$ python3 compiler.py <source.sb> -o <dest.mem>
```

To compile from .sb to assembly-like language, run with option `-S`

```sh
$ python3 compiler.py <source.sb> -S -o <dest.mem>
```

---

Constraint

- len(funtion name) >= 3
- len(variable name) <= 2

## Assembly-like code

Besides writing in a high-level language, you can also optimize that even further by writing an assembly-like language. To compile the assembly-like code, run the following command

```sh
$ python3 assembler.py <source.pp> -o <dest.mem>
```

The documentation below describes how each assembly-like command is mapped to the machine code. *(Updated: May 2nd, 2019)*

Load: 0001
- load rR #A:   000100RRRRRxxxxxAAAAAAAAAAAAAAAA (Load Immediate A to register R (00))
- load rR A:    000101RRRRRxxxxxAAAAAAAAAAAAAAAA (Load Direct memory address A to register R (01))
- load rR (rS): 000110RRRRRSSSSSxxxxxxxxxxxxxxxx (Load Register indirect register S to register R (10))

Store: 0010
- store rR A:    001001RRRRRxxxxxAAAAAAAAAAAAAAAA (Store Register R to memory A (01))
- store rR (rS): 001010RRRRRSSSSSxxxxxxxxxxxxxxxx (Store Register R to memory address from register indirect S (10))

Move: 0011
- mov rR rS: 0011xxRRRRRSSSSSxxxxxxxxxxxxxxxx (Move data to Register R from Register S)

ALU Operation: 0100
- add rD rR rS: 0100xxRRRRRSSSSSDDDDDxxxxxxx0001 (Value in register D = R + S (0001))
- sub rD rR rS: 0100xxRRRRRSSSSSDDDDDxxxxxxx0010 (Value in register D = R - S (0010))
- mul rD rR rS: 0100xxRRRRRSSSSSDDDDDxxxxxxx0011 (Value in register D = R * S (0011))
- div rD rR rS: 0100xxRRRRRSSSSSDDDDDxxxxxxx0100 (Value in register D = R / S (0100))
- mod rD rR rS: 0100xxRRRRRSSSSSDDDDDxxxxxxx0101 (Value in register D = R % S (0101))
- and rD rR rS: 0100xxRRRRRSSSSSDDDDDxxxxxxx0110 (Value in register D = R & S (0110))
- or rD rR rS:  0100xxRRRRRSSSSSDDDDDxxxxxxx0111 (Value in register D = R | S (0111))
- xor rD rR rS: 0100xxRRRRRSSSSSDDDDDxxxxxxx1000 (Value in register D = R ^ S (1000))
- not rD rR:    0100xxRRRRRxxxxxDDDDDxxxxxxx1001 (Value in register D = ~R (1001))
- neg rD rR:    0100xxRRRRRxxxxxDDDDDxxxxxxx1010 (Value in register D = -R (1010))
- shl rD rR rS: 0100xxRRRRRSSSSSDDDDDxxxxxxx1011 (Value in register D = R << S (1011))
- shr rD rR rS: 0100xxRRRRRSSSSSDDDDDxxxxxxx1100 (Value in register D = R >> S (1100))

Compare: 0101
- cmp rR rS: 0101xxRRRRRSSSSSxxxxxxxxxxxxxxxx (Compare value of register R and S)

Jump Conditional/Unconditional: 0110
- jmp A:     0110000xxxxxxxxxAAAAAAAAAAAAAAAA (Unconditional jump to address A (000))
- jeq A:     0110001xxxxxxxxxAAAAAAAAAAAAAAAA (Jump to address A if equal (001))
- jne A:     0110010xxxxxxxxxAAAAAAAAAAAAAAAA (Jump to address A if not equal (010))
- jlt A:     0110011xxxxxxxxxAAAAAAAAAAAAAAAA (Jump to address A if less than (011))
- jle A:     0110100xxxxxxxxxAAAAAAAAAAAAAAAA (Jump to address A if less than or equal (100))
- jgt A:     0110101xxxxxxxxxAAAAAAAAAAAAAAAA (Jump to address A if greater than (101))
- jge A:     0110110xxxxxxxxxAAAAAAAAAAAAAAAA (Jump to address A if greater than or equal (110))

Call: 0111
- call A:    0111xxxxxxxxxxxxAAAAAAAAAAAAAAAA (Create a subroutine at address A)

Return: 1000
- ret:       1000xxxxxxxxxxxxxxxxxxxxxxxxxxxx (Subroutine return)

Branch: 1001
- brn A:     1001000xxxxxxxxxAAAAAAAAAAAAAAAA (Move to the next A addresses (000))
- beq A:     1001001xxxxxxxxxAAAAAAAAAAAAAAAA (Move to the next A addresses if equal (001))
- bne A:     1001010xxxxxxxxxAAAAAAAAAAAAAAAA (Move to the next A addresses if not equal (010))
- blt A:     1001011xxxxxxxxxAAAAAAAAAAAAAAAA (Move to the next A addresses if less than (011))
- ble A:     1001100xxxxxxxxxAAAAAAAAAAAAAAAA (Move to the next A addresses if less than or equal (100))
- bgt A:     1001101xxxxxxxxxAAAAAAAAAAAAAAAA (Move to the next A addresses if greater than (101))
- bge A:     1001110xxxxxxxxxAAAAAAAAAAAAAAAA (Move to the next A addresses if greater than or equal (110))

Push: 1010
- push rR:   1010xxRRRRRxxxxx0000000000000000 (Push register R to the stack)

Pop: 1011
- pop rR:    1011xxRRRRRxxxxx0000000000000000 (Pop the stack and store at register R)
