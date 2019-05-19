inter:
    push r2
    push r3
    push r4
    push r5
    push r6
    push r7
    push r8
    push r9
    push r10
    push r11
    push r12
    push r13
    push r14
    load r4 #0
    load r5 #1
    load r6 #66
    load r7 #61506
    load r8 #61467
    load r9 #59
    load r10 #41
    load r11 #61499
    load r12 #61468
    load r13 #27
    load r14 #28
    load r2 65504
    cmp r2 r14
    jne inter__else_0
    store r5 7943
    jmp inter__endif_0
inter__else_0:
    cmp r2 r13
    jne inter__else_0__else_0
    store r5 7944
    jmp inter__else_0__endif_0
inter__else_0__else_0:
    cmp r2 r9
    jne inter__else_0__else_0__else_0
    store r5 7945
    jmp inter__else_0__else_0__endif_0
inter__else_0__else_0__else_0:
    cmp r2 r6
    jne inter__else_0__else_0__else_0__else_0
    store r5 7946
    jmp inter__else_0__else_0__else_0__endif_0
inter__else_0__else_0__else_0__else_0:
    cmp r2 r10
    jne inter__else_0__else_0__else_0__else_0__endif_0
    load r3 65280
    cmp r3 r4
    jne inter__else_0__else_0__else_0__else_0inter__else_0__else_0__else_0__else_0__if_0__else_0
    store r5 65280
    jmp inter__else_0__else_0__else_0__else_0inter__else_0__else_0__else_0__else_0__if_0__endif_0
inter__else_0__else_0__else_0__else_0inter__else_0__else_0__else_0__else_0__if_0__else_0:
    store r4 65280
inter__else_0__else_0__else_0__else_0inter__else_0__else_0__else_0__else_0__if_0__endif_0:
inter__else_0__else_0__else_0__else_0__endif_0:
inter__else_0__else_0__else_0__endif_0:
inter__else_0__else_0__endif_0:
inter__else_0__endif_0:
inter__endif_0:
    cmp r2 r12
    jne inter__else_1
    store r4 7943
    jmp inter__endif_1
inter__else_1:
    cmp r2 r8
    jne inter__else_1__else_0
    store r4 7944
    jmp inter__else_1__endif_0
inter__else_1__else_0:
    cmp r2 r11
    jne inter__else_1__else_0__else_0
    store r4 7945
    jmp inter__else_1__else_0__endif_0
inter__else_1__else_0__else_0:
    cmp r2 r7
    jne inter__else_1__else_0__else_0__endif_0
    store r4 7946
inter__else_1__else_0__else_0__endif_0:
inter__else_1__else_0__endif_0:
inter__else_1__endif_0:
inter__endif_1:
    store r2 65534
inter__return:
    pop r14
    pop r13
    pop r12
    pop r11
    pop r10
    pop r9
    pop r8
    pop r7
    pop r6
    pop r5
    pop r4
    pop r3
    pop r2
    ret
