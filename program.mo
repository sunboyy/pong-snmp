0110_000_000000000
0000000010100000	// jmp main
1010_00_00101_00000
0000000000000000	// push r5
1010_00_00110_00000
0000000000000000	// push r6
1010_00_00111_00000
0000000000000000	// push r7
1010_00_01000_00000
0000000000000000	// push r8
1010_00_01001_00000
0000000000000000	// push r9
1010_00_01010_00000
0000000000000000	// push r10
1010_00_01011_00000
0000000000000000	// push r11
1010_00_01100_00000
0000000000000000	// push r12
1010_00_01101_00000
0000000000000000	// push r13
1010_00_01110_00000
0000000000000000	// push r14
1010_00_01111_00000
0000000000000000	// push r15
1010_00_10000_00000
0000000000000000	// push r16
1010_00_10001_00000
0000000000000000	// push r17
0001_00_00111_00000
0000000000000000	// load r7 #0
0001_00_01000_00000
0000000000000001	// load r8 #1
0001_00_01001_00000
0000000001000010	// load r9 #66
0001_00_01010_00000
1111000001000010	// load r10 #61506
0001_00_01011_00000
1111000000011011	// load r11 #61467
0001_00_01100_00000
0000000000111011	// load r12 #59
0001_00_01101_00000
0000000000101001	// load r13 #41
0001_00_01110_00000
1111000000111011	// load r14 #61499
0001_00_01111_00000
1111000000011100	// load r15 #61468
0001_00_10000_00000
0000000000011011	// load r16 #27
0001_00_10001_00000
0000000000011100	// load r17 #28
0001_01_00101_00000
1111111111100000	// load r5 65504
0101_00_00101_10001
0000000000000000	// cmp r5 r17
0110_010_000000000
0000000000111100	// jne interrupt__else_0
0010_01_01000_00000
0001111100000111	// store r8 7943
0110_000_000000000
0000000001100100	// jmp interrupt__endif_0
0101_00_00101_10000
0000000000000000	// cmp r5 r16
0110_010_000000000
0000000001000100	// jne interrupt__else_0__else_0
0010_01_01000_00000
0001111100001000	// store r8 7944
0110_000_000000000
0000000001100100	// jmp interrupt__else_0__endif_0
0101_00_00101_01100
0000000000000000	// cmp r5 r12
0110_010_000000000
0000000001001100	// jne interrupt__else_0__else_0__else_0
0010_01_01000_00000
0001111100001001	// store r8 7945
0110_000_000000000
0000000001100100	// jmp interrupt__else_0__else_0__endif_0
0101_00_00101_01001
0000000000000000	// cmp r5 r9
0110_010_000000000
0000000001010100	// jne interrupt__else_0__else_0__else_0__else_0
0010_01_01000_00000
0001111100001010	// store r8 7946
0110_000_000000000
0000000001100100	// jmp interrupt__else_0__else_0__else_0__endif_0
0101_00_00101_01101
0000000000000000	// cmp r5 r13
0110_010_000000000
0000000001100100	// jne interrupt__else_0__else_0__else_0__else_0__endif_0
0001_01_00110_00000
1111111100000000	// load r6 65280
0101_00_00110_00111
0000000000000000	// cmp r6 r7
0110_010_000000000
0000000001100010	// jne interrupt__else_0__else_0__else_0__else_0interrupt__else_0__else_0__else_0__else_0__if_0__else_0
0010_01_01000_00000
1111111100000000	// store r8 65280
0110_000_000000000
0000000001100100	// jmp interrupt__else_0__else_0__else_0__else_0interrupt__else_0__else_0__else_0__else_0__if_0__endif_0
0010_01_00111_00000
1111111100000000	// store r7 65280
0101_00_00101_01111
0000000000000000	// cmp r5 r15
0110_010_000000000
0000000001101100	// jne interrupt__else_1
0010_01_00111_00000
0001111100000111	// store r7 7943
0110_000_000000000
0000000010000010	// jmp interrupt__endif_1
0101_00_00101_01011
0000000000000000	// cmp r5 r11
0110_010_000000000
0000000001110100	// jne interrupt__else_1__else_0
0010_01_00111_00000
0001111100001000	// store r7 7944
0110_000_000000000
0000000010000010	// jmp interrupt__else_1__endif_0
0101_00_00101_01110
0000000000000000	// cmp r5 r14
0110_010_000000000
0000000001111100	// jne interrupt__else_1__else_0__else_0
0010_01_00111_00000
0001111100001001	// store r7 7945
0110_000_000000000
0000000010000010	// jmp interrupt__else_1__else_0__endif_0
0101_00_00101_01010
0000000000000000	// cmp r5 r10
0110_010_000000000
0000000010000010	// jne interrupt__else_1__else_0__else_0__endif_0
0010_01_00111_00000
0001111100001010	// store r7 7946
0010_01_00101_00000
1111111111111110	// store r5 65534
1011_00_10001_00000
0000000000000000	// pop r17
1011_00_10000_00000
0000000000000000	// pop r16
1011_00_01111_00000
0000000000000000	// pop r15
1011_00_01110_00000
0000000000000000	// pop r14
1011_00_01101_00000
0000000000000000	// pop r13
1011_00_01100_00000
0000000000000000	// pop r12
1011_00_01011_00000
0000000000000000	// pop r11
1011_00_01010_00000
0000000000000000	// pop r10
1011_00_01001_00000
0000000000000000	// pop r9
1011_00_01000_00000
0000000000000000	// pop r8
1011_00_00111_00000
0000000000000000	// pop r7
1011_00_00110_00000
0000000000000000	// pop r6
1011_00_00101_00000
0000000000000000	// pop r5
1000_000000000000
0000000000000000	// ret
0001_00_00111_00000
0000000000000000	// load r7 #0
0001_00_01000_00000
0000000000000001	// load r8 #1
0001_00_01001_00000
0000000000000010	// load r9 #2
0001_00_01010_00000
1111111100000011	// load r10 #65283
0001_00_01011_00000
1111111100000100	// load r11 #65284
0001_00_01100_00000
0001111100000111	// load r12 #7943
0001_00_01101_00000
0001111100001000	// load r13 #7944
0001_00_01110_00000
0001111100001001	// load r14 #7945
0001_00_01111_00000
0001111100001010	// load r15 #7946
0001_00_10000_00000
0000000001001100	// load r16 #76
0001_00_10001_00000
0000000001110100	// load r17 #116
0001_00_10010_00000
0000000000111100	// load r18 #60
0001_01_00101_00000
1111111100000000	// load r5 65280
0101_00_00101_00111
0000000000000000	// cmp r5 r7
0110_010_000000000
0000000011010010	// jne main__while_0__endwhile_0
0001_01_00101_00000
1111111100000000	// load r5 65280
0010_01_01000_00000
0001111111111110	// store r8 8190
0010_01_01000_00000
0001111111111111	// store r8 8191
0010_01_10010_00000
1111111100000011	// store r18 65283
0010_01_10010_00000
1111111100000100	// store r18 65284
0010_01_00111_00000
1111111100000001	// store r7 65281
0010_01_00111_00000
1111111100000010	// store r7 65282
0010_01_10001_00000
1111111100000101	// store r17 65285
0010_01_10000_00000
1111111100000110	// store r16 65286
0110_000_000000000
0000000010111010	// jmp main__while_0__while_0
0101_00_00101_01000
0000000000000000	// cmp r5 r8
0110_010_000000000
0000000100010000	// jne main__while_0__endwhile_1
0001_01_00101_00000
1111111100000000	// load r5 65280
0111_000000000000
0000000110100010	// call detectBound
0011_00_00110_00001
0000000000000000	// mov r6 r1
0101_00_00110_00111
0000000000000000	// cmp r6 r7
0110_010_000000000
0000000011110000	// jne main__while_0__while_1__endif_0
0011_00_00010_01010
0000000000000000	// mov r2 r10
0111_000000000000
0000001001010000	// call detectPaddle
0011_00_00110_00001
0000000000000000	// mov r6 r1
0101_00_00110_00111
0000000000000000	// cmp r6 r7
0110_010_000000000
0000000011110000	// jne main__while_0__while_1main__while_0__while_1__if_0__endif_0
0011_00_00010_01011
0000000000000000	// mov r2 r11
0111_000000000000
0000001001010000	// call detectPaddle
0011_00_00110_00001
0000000000000000	// mov r6 r1
0101_00_00110_01000
0000000000000000	// cmp r6 r8
0110_001_000000000
0000000011111000	// jeq main__while_0__while_1__endif_1
0111_000000000000
0000000100110100	// call chkOutField
0011_00_00110_00001
0000000000000000	// mov r6 r1
0011_00_00010_01100
0000000000000000	// mov r2 r12
0011_00_00011_01101
0000000000000000	// mov r3 r13
0011_00_00100_01010
0000000000000000	// mov r4 r10
0111_000000000000
0000001010110010	// call movePaddle
0011_00_00010_01110
0000000000000000	// mov r2 r14
0011_00_00011_01111
0000000000000000	// mov r3 r15
0011_00_00100_01011
0000000000000000	// mov r4 r11
0111_000000000000
0000001010110010	// call movePaddle
0101_00_00110_01001
0000000000000000	// cmp r6 r9
0110_001_000000000
0000000100001110	// jeq main__while_0__while_1__endif_2
0111_000000000000
0000000100010010	// call moveBall
0110_000_000000000
0000000011010010	// jmp main__while_0__while_1
0110_000_000000000
0000000010111000	// jmp main__while_0
1010_00_00101_00000
0000000000000000	// push r5
1010_00_00110_00000
0000000000000000	// push r6
1010_00_00111_00000
0000000000000000	// push r7
1010_00_01000_00000
0000000000000000	// push r8
0001_01_00111_00000
1111111100000101	// load r7 65285
0001_01_01000_00000
1111111100000110	// load r8 65286
0001_01_00101_00000
0001111111111110	// load r5 8190
0001_01_00110_00000
0001111111111111	// load r6 8191
0100_00_00111_00101
00111_0000000_0001	// add r7 r7 r5
0100_00_01000_00110
01000_0000000_0001	// add r8 r8 r6
0010_01_00111_00000
1111111100000101	// store r7 65285
0010_01_01000_00000
1111111100000110	// store r8 65286
1011_00_01000_00000
0000000000000000	// pop r8
1011_00_00111_00000
0000000000000000	// pop r7
1011_00_00110_00000
0000000000000000	// pop r6
1011_00_00101_00000
0000000000000000	// pop r5
1000_000000000000
0000000000000000	// ret
1010_00_00101_00000
0000000000000000	// push r5
1010_00_00110_00000
0000000000000000	// push r6
1010_00_00111_00000
0000000000000000	// push r7
1010_00_01000_00000
0000000000000000	// push r8
1010_00_01001_00000
0000000000000000	// push r9
1010_00_01010_00000
0000000000000000	// push r10
1010_00_01011_00000
0000000000000000	// push r11
1010_00_01100_00000
0000000000000000	// push r12
1010_00_01101_00000
0000000000000000	// push r13
1010_00_01110_00000
0000000000000000	// push r14
0001_00_01000_00000
0000000000000000	// load r8 #0
0001_00_01001_00000
0000000000000001	// load r9 #1
0001_00_01010_00000
0000000000000010	// load r10 #2
0001_00_01011_00000
0000000000001000	// load r11 #8
0001_00_01100_00000
0000000011101000	// load r12 #232
0001_00_01101_00000
0000000001001100	// load r13 #76
0001_00_01110_00000
0000000001110100	// load r14 #116
0001_01_00101_00000
1111111100000101	// load r5 65285
0100_00_00101_01011
00110_0000000_0001	// add r6 r5 r11
0101_00_00101_01011
0000000000000000	// cmp r5 r11
0110_101_000000000
0000000101110010	// jgt chkOutField__else_0
0001_01_00111_00000
1111111100000010	// load r7 65282
0010_01_01110_00000
1111111100000101	// store r14 65285
0010_01_01101_00000
1111111100000110	// store r13 65286
0010_01_01001_00000
0001111111111110	// store r9 8190
0010_01_01001_00000
0001111111111111	// store r9 8191
0100_00_00111_01001
00111_0000000_0001	// add r7 r7 r9
0010_01_00111_00000
1111111100000010	// store r7 65282
0011_00_00001_01010
0000000000000000	// mov r1 r10
0110_000_000000000
0000000110001100	// jmp chkOutField__return
0110_000_000000000
0000000110001000	// jmp chkOutField__endif_0
0101_00_00110_01100
0000000000000000	// cmp r6 r12
0110_011_000000000
0000000110001000	// jlt chkOutField__else_0__endif_0
0001_01_00111_00000
1111111100000001	// load r7 65281
0010_01_01110_00000
1111111100000101	// store r14 65285
0010_01_01101_00000
1111111100000110	// store r13 65286
0010_01_01001_00000
0001111111111110	// store r9 8190
0010_01_01001_00000
0001111111111111	// store r9 8191
0100_00_00111_01001
00111_0000000_0001	// add r7 r7 r9
0010_01_00111_00000
1111111100000001	// store r7 65281
0011_00_00001_01010
0000000000000000	// mov r1 r10
0110_000_000000000
0000000110001100	// jmp chkOutField__return
0011_00_00001_01000
0000000000000000	// mov r1 r8
0110_000_000000000
0000000110001100	// jmp chkOutField__return
1011_00_01110_00000
0000000000000000	// pop r14
1011_00_01101_00000
0000000000000000	// pop r13
1011_00_01100_00000
0000000000000000	// pop r12
1011_00_01011_00000
0000000000000000	// pop r11
1011_00_01010_00000
0000000000000000	// pop r10
1011_00_01001_00000
0000000000000000	// pop r9
1011_00_01000_00000
0000000000000000	// pop r8
1011_00_00111_00000
0000000000000000	// pop r7
1011_00_00110_00000
0000000000000000	// pop r6
1011_00_00101_00000
0000000000000000	// pop r5
1000_000000000000
0000000000000000	// ret
1010_00_00101_00000
0000000000000000	// push r5
1010_00_00110_00000
0000000000000000	// push r6
1010_00_00111_00000
0000000000000000	// push r7
1010_00_01000_00000
0000000000000000	// push r8
1010_00_01001_00000
0000000000000000	// push r9
1010_00_01010_00000
0000000000000000	// push r10
1010_00_01011_00000
0000000000000000	// push r11
1010_00_01100_00000
0000000000000000	// push r12
0001_00_01001_00000
0000000000001000	// load r9 #8
0001_00_01010_00000
0000000000000000	// load r10 #0
0001_00_01011_00000
0000000000000001	// load r11 #1
0001_00_01100_00000
0000000010011111	// load r12 #159
0001_01_00101_00000
1111111100000110	// load r5 65286
0001_01_00111_00000
0001111111111111	// load r7 8191
0100_00_00101_01001
00110_0000000_0001	// add r6 r5 r9
0011_00_01000_01010
0000000000000000	// mov r8 r10
0101_00_00101_01010
0000000000000000	// cmp r5 r10
0110_101_000000000
0000000111001100	// jgt detectBound__else_0
0100_00_01010_00111
00111_0000000_0010	// sub r7 r10 r7
0011_00_01000_01011
0000000000000000	// mov r8 r11
0110_000_000000000
0000000111010100	// jmp detectBound__endif_0
0101_00_00110_01100
0000000000000000	// cmp r6 r12
0110_011_000000000
0000000111010100	// jlt detectBound__else_0__endif_0
0100_00_01010_00111
00111_0000000_0010	// sub r7 r10 r7
0011_00_01000_01011
0000000000000000	// mov r8 r11
0010_01_00111_00000
0001111111111111	// store r7 8191
0011_00_00001_01000
0000000000000000	// mov r1 r8
0110_000_000000000
0000000111011010	// jmp detectBound__return
1011_00_01100_00000
0000000000000000	// pop r12
1011_00_01011_00000
0000000000000000	// pop r11
1011_00_01010_00000
0000000000000000	// pop r10
1011_00_01001_00000
0000000000000000	// pop r9
1011_00_01000_00000
0000000000000000	// pop r8
1011_00_00111_00000
0000000000000000	// pop r7
1011_00_00110_00000
0000000000000000	// pop r6
1011_00_00101_00000
0000000000000000	// pop r5
1000_000000000000
0000000000000000	// ret
1010_00_00101_00000
0000000000000000	// push r5
1010_00_00110_00000
0000000000000000	// push r6
1010_00_00111_00000
0000000000000000	// push r7
1010_00_01000_00000
0000000000000000	// push r8
1010_00_01001_00000
0000000000000000	// push r9
1010_00_01010_00000
0000000000000000	// push r10
1010_00_01011_00000
0000000000000000	// push r11
1010_00_01100_00000
0000000000000000	// push r12
1010_00_01101_00000
0000000000000000	// push r13
1010_00_01110_00000
0000000000000000	// push r14
1010_00_01111_00000
0000000000000000	// push r15
0011_00_00101_00010
0000000000000000	// mov r5 r2
0011_00_00110_00011
0000000000000000	// mov r6 r3
0011_00_00111_00100
0000000000000000	// mov r7 r4
0001_00_01010_00000
0000000000000000	// load r10 #0
0001_00_01011_00000
0000000000000001	// load r11 #1
0001_00_01100_00000
1111111100000011	// load r12 #65283
0001_00_01101_00000
1111111100000100	// load r13 #65284
0001_00_01110_00000
0000000000001000	// load r14 #8
0001_00_01111_00000
0000000011101000	// load r15 #232
0001_01_01000_00000
0001111111111110	// load r8 8190
0011_00_01001_01010
0000000000000000	// mov r9 r10
0101_00_00101_01100
0000000000000000	// cmp r5 r12
0110_010_000000000
0000001000100110	// jne doInRange__else_0
0101_00_00110_01110
0000000000000000	// cmp r6 r14
0110_010_000000000
0000001000100100	// jne doInRangedoInRange__if_0__endif_0
0100_00_01010_01000
01000_0000000_0010	// sub r8 r10 r8
0011_00_01001_01011
0000000000000000	// mov r9 r11
0110_000_000000000
0000001000110010	// jmp doInRange__endif_0
0101_00_00101_01101
0000000000000000	// cmp r5 r13
0110_010_000000000
0000001000110010	// jne doInRange__else_0__endif_0
0101_00_00111_01111
0000000000000000	// cmp r7 r15
0110_010_000000000
0000001000110010	// jne doInRange__else_0doInRange__else_0__if_0__endif_0
0100_00_01010_01000
01000_0000000_0010	// sub r8 r10 r8
0011_00_01001_01011
0000000000000000	// mov r9 r11
0010_01_01000_00000
0001111111111110	// store r8 8190
0011_00_00001_01001
0000000000000000	// mov r1 r9
0110_000_000000000
0000001000111000	// jmp doInRange__return
1011_00_01111_00000
0000000000000000	// pop r15
1011_00_01110_00000
0000000000000000	// pop r14
1011_00_01101_00000
0000000000000000	// pop r13
1011_00_01100_00000
0000000000000000	// pop r12
1011_00_01011_00000
0000000000000000	// pop r11
1011_00_01010_00000
0000000000000000	// pop r10
1011_00_01001_00000
0000000000000000	// pop r9
1011_00_01000_00000
0000000000000000	// pop r8
1011_00_00111_00000
0000000000000000	// pop r7
1011_00_00110_00000
0000000000000000	// pop r6
1011_00_00101_00000
0000000000000000	// pop r5
1000_000000000000
0000000000000000	// ret
1010_00_00101_00000
0000000000000000	// push r5
1010_00_00110_00000
0000000000000000	// push r6
1010_00_00111_00000
0000000000000000	// push r7
1010_00_01000_00000
0000000000000000	// push r8
1010_00_01001_00000
0000000000000000	// push r9
1010_00_01010_00000
0000000000000000	// push r10
1010_00_01011_00000
0000000000000000	// push r11
1010_00_01100_00000
0000000000000000	// push r12
1010_00_01101_00000
0000000000000000	// push r13
1010_00_01110_00000
0000000000000000	// push r14
1010_00_01111_00000
0000000000000000	// push r15
1010_00_10000_00000
0000000000000000	// push r16
1010_00_10001_00000
0000000000000000	// push r17
0011_00_00101_00010
0000000000000000	// mov r5 r2
0001_00_01111_00000
0000000000001000	// load r15 #8
0001_00_10000_00000
0000000000000000	// load r16 #0
0001_00_10001_00000
0000000000101000	// load r17 #40
0001_01_00110_00000
1111111100000101	// load r6 65285
0001_01_01000_00000
1111111100000110	// load r8 65286
0001_10_01011_00101
0000000000000000	// load r11 (r5)
0100_00_00110_01111
00111_0000000_0001	// add r7 r6 r15
0100_00_01000_01111
01001_0000000_0001	// add r9 r8 r15
0100_00_01011_10001
01010_0000000_0001	// add r10 r11 r17
0011_00_01110_10000
0000000000000000	// mov r14 r16
0101_00_01011_01001
0000000000000000	// cmp r11 r9
0110_101_000000000
0000001010010010	// jgt detectPaddle__endif_0
0101_00_01000_01010
0000000000000000	// cmp r8 r10
0110_101_000000000
0000001010010010	// jgt detectPaddledetectPaddle__if_0__endif_0
0011_00_00010_00101
0000000000000000	// mov r2 r5
0011_00_00011_00110
0000000000000000	// mov r3 r6
0011_00_00100_00111
0000000000000000	// mov r4 r7
0111_000000000000
0000000111101100	// call doInRange
0011_00_01110_00001
0000000000000000	// mov r14 r1
0011_00_00001_01110
0000000000000000	// mov r1 r14
0110_000_000000000
0000001010010110	// jmp detectPaddle__return
1011_00_10001_00000
0000000000000000	// pop r17
1011_00_10000_00000
0000000000000000	// pop r16
1011_00_01111_00000
0000000000000000	// pop r15
1011_00_01110_00000
0000000000000000	// pop r14
1011_00_01101_00000
0000000000000000	// pop r13
1011_00_01100_00000
0000000000000000	// pop r12
1011_00_01011_00000
0000000000000000	// pop r11
1011_00_01010_00000
0000000000000000	// pop r10
1011_00_01001_00000
0000000000000000	// pop r9
1011_00_01000_00000
0000000000000000	// pop r8
1011_00_00111_00000
0000000000000000	// pop r7
1011_00_00110_00000
0000000000000000	// pop r6
1011_00_00101_00000
0000000000000000	// pop r5
1000_000000000000
0000000000000000	// ret
1010_00_00101_00000
0000000000000000	// push r5
1010_00_00110_00000
0000000000000000	// push r6
1010_00_00111_00000
0000000000000000	// push r7
1010_00_01000_00000
0000000000000000	// push r8
1010_00_01001_00000
0000000000000000	// push r9
1010_00_01010_00000
0000000000000000	// push r10
1010_00_01011_00000
0000000000000000	// push r11
1010_00_01100_00000
0000000000000000	// push r12
1010_00_01101_00000
0000000000000000	// push r13
1010_00_01110_00000
0000000000000000	// push r14
1010_00_01111_00000
0000000000000000	// push r15
0011_00_00101_00010
0000000000000000	// mov r5 r2
0011_00_00110_00011
0000000000000000	// mov r6 r3
0011_00_00111_00100
0000000000000000	// mov r7 r4
0001_00_01100_00000
0000000000000000	// load r12 #0
0001_00_01101_00000
0000000000000001	// load r13 #1
0001_00_01110_00000
0000000000101000	// load r14 #40
0001_00_01111_00000
0000000010011111	// load r15 #159
0001_10_01000_00101
0000000000000000	// load r8 (r5)
0001_10_01001_00110
0000000000000000	// load r9 (r6)
0001_10_01010_00111
0000000000000000	// load r10 (r7)
0101_00_01000_01101
0000000000000000	// cmp r8 r13
0110_010_000000000
0000001011101000	// jne movePaddle__else_0
0101_00_01010_01100
0000000000000000	// cmp r10 r12
0110_100_000000000
0000001011100110	// jle movePaddlemovePaddle__if_0__endif_0
0100_00_01010_01101
01010_0000000_0010	// sub r10 r10 r13
0110_000_000000000
0000001011110100	// jmp movePaddle__endif_0
0101_00_01001_01101
0000000000000000	// cmp r9 r13
0110_010_000000000
0000001011110100	// jne movePaddle__else_0__endif_0
0100_00_01010_01110
01011_0000000_0001	// add r11 r10 r14
0101_00_01011_01111
0000000000000000	// cmp r11 r15
0110_110_000000000
0000001011110100	// jge movePaddle__else_0movePaddle__else_0__if_0__endif_0
0100_00_01010_01101
01010_0000000_0001	// add r10 r10 r13
0010_10_01010_00111
0000000000000000	// store r10 (r7)
1011_00_01111_00000
0000000000000000	// pop r15
1011_00_01110_00000
0000000000000000	// pop r14
1011_00_01101_00000
0000000000000000	// pop r13
1011_00_01100_00000
0000000000000000	// pop r12
1011_00_01011_00000
0000000000000000	// pop r11
1011_00_01010_00000
0000000000000000	// pop r10
1011_00_01001_00000
0000000000000000	// pop r9
1011_00_01000_00000
0000000000000000	// pop r8
1011_00_00111_00000
0000000000000000	// pop r7
1011_00_00110_00000
0000000000000000	// pop r6
1011_00_00101_00000
0000000000000000	// pop r5
1000_000000000000
0000000000000000	// ret
