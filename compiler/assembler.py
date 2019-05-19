REG = 5
IMM = 16
tag_list = {}
line_current = 0

OP_LOAD = ['load']
OP_STORE = ['store']
OP_MOVE = ['mov']
OP_ALU = ['add', 'sub', 'mul', 'div', 'mod', 'and', 'or', 'xor', 'not', 'neg', 'shl', 'shr']
OP_COMPARE = ['cmp']
OP_JUMP = ['jmp', 'jeq', 'jne', 'jlt', 'jle', 'jgt', 'jge']
OP_CALL = ['call']
OP_RETURN = ['ret']
OP_BRANCH = ['brn', 'beq', 'bne', 'blt', 'ble', 'bgt', 'bge']
OP_PUSH = ['push']
OP_POP = ['pop']
ALL_OP = OP_LOAD + OP_STORE + OP_MOVE + OP_ALU + OP_COMPARE + OP_JUMP + OP_CALL + OP_RETURN + OP_BRANCH + OP_PUSH + OP_POP

def errorMessage(err):
    raise Exception(err)

def dont_care(amount):
    return '0' * amount

def to_bin(number, zero):
    convert = 0
    if (number[0] == '-'):
        convert = 1<<16
    if (number[:2] == '0x'):
        return bin(int(number, 16) + convert)[2:].zfill(zero)
    else:
        return bin(int(number, 10) + convert)[2:].zfill(zero)

def store_tag(tag):
    tag = tag.strip(':')
    tag_list[tag] = str(line_current)
    print(tag, str(line_current))
    return 'tag'

def concat_ins(parts):
    ins = ''
    for p in parts:
        ins += '_' + p
    return ins[1:]

def compile_load(line):
    rR, operand = line[1:]
    if (operand[0] == '#'):
        operand = operand[1:]
        return concat_ins(['0001', '00', to_bin(rR[1:], REG), dont_care(REG), to_bin(operand, IMM)])
    # elif (operand.isdigit() or operand[:2] == '0x'):
    elif (operand[0:2] == '(r' and operand[-1] == ')'):
        operand = operand[2:-1]
        return concat_ins(['0001', '10', to_bin(rR[1:], REG), to_bin(operand, REG), dont_care(IMM)])        
    else:
        return concat_ins(['0001', '01', to_bin(rR[1:], REG), dont_care(REG), to_bin(operand, IMM)])

def compile_store(line):
    rR, operand = line[1:]
    if (operand[0:2] == '(r' and operand[-1] == ')'):
        operand = operand[2:-1]
        return concat_ins(['0010', '10', to_bin(rR[1:], REG), to_bin(operand, REG), dont_care(IMM)])
    else:
        return concat_ins(['0010', '01', to_bin(rR[1:], REG), dont_care(REG), to_bin(operand, IMM)])

def compile_move(line):
    rR, rS = line[1:]
    return concat_ins(['0011', dont_care(2), to_bin(rR[1:], REG), to_bin(rS[1:], REG), dont_care(IMM)])
    
def compile_alu(line):
    operation = line[0]
    if (operation == 'add'):    aluOp = '0001'
    elif (operation == 'sub'):  aluOp = '0010'
    elif (operation == 'mul'):  aluOp = '0011'
    elif (operation == 'div'):  aluOp = '0100'
    elif (operation == 'mod'):  aluOp = '0101'
    elif (operation == 'and'):  aluOp = '0110'
    elif (operation == 'or'):   aluOp = '0111'
    elif (operation == 'xor'):  aluOp = '1000'
    elif (operation == 'not'):  aluOp = '1001'
    elif (operation == 'neg'):  aluOp = '1010'
    elif (operation == 'shl'):  aluOp = '1011'
    elif (operation == 'shr'):  aluOp = '1100'

    if (len(line[1:]) > 2):
        rD, rR, rS = line[1:]
        return concat_ins(['0100', dont_care(2), to_bin(rR[1:], REG), to_bin(rS[1:], REG),
                           to_bin(rD[1:], REG), dont_care(7), aluOp])
    else:
        rD, rR = line[1:]
        return concat_ins(['0100', dont_care(2), to_bin(rR[1:], REG), dont_care(REG),
                           to_bin(rD[1:], REG), dont_care(7), aluOp])

def compile_compare(line):
    rR, rS = line[1:]
    return concat_ins(['0101', dont_care(2), to_bin(rR[1:], REG), to_bin(rS[1:], REG), dont_care(IMM)])

def compile_jump(line):
    operation = line[0]
    A = line[1]
    if (operation == 'jmp'):    jumpOp = '000'
    elif (operation == 'jeq'):  jumpOp = '001'
    elif (operation == 'jne'):  jumpOp = '010'
    elif (operation == 'jlt'):  jumpOp = '011'
    elif (operation == 'jle'):  jumpOp = '100'
    elif (operation == 'jgt'):  jumpOp = '101'
    elif (operation == 'jge'):  jumpOp = '110'
    
    if (tag_list[A]): A = tag_list[A]
    return concat_ins(['0110', jumpOp, dont_care(9), to_bin(A, IMM)])

def compile_call(line):
    A = line[1]
    if (tag_list[A]): A = tag_list[A]
    return concat_ins(['0111', dont_care(12), to_bin(A, IMM)])

def compile_return(line):
    return concat_ins(['1000', dont_care(28)])

def compile_branch(line):
    operation = line[0]
    A = line[1]
    if (operation == 'brn'):    branchOp = '000'
    elif (operation == 'beq'):  branchOp = '001'
    elif (operation == 'bne'):  branchOp = '010'
    elif (operation == 'blt'):  branchOp = '011'
    elif (operation == 'ble'):  branchOp = '100'
    elif (operation == 'bgt'):  branchOp = '101'
    elif (operation == 'bge'):  branchOp = '110'
    return concat_ins(['1001', branchOp, dont_care(9), to_bin(A, IMM)])

def compile_push(line):
    rR = line[1]
    return concat_ins(['1010', dont_care(2), to_bin(rR[1:], REG), dont_care(21)])

def compile_pop(line):
    rR = line[1]
    return concat_ins(['1011', dont_care(2), to_bin(rR[1:], REG), dont_care(21)])

def compile_digit(line):
    return concat_ins([to_bin(line[0], 16)])

def compiler(line):
    op = line[0]
    if (op.isdigit()):        return compile_digit(line)
    elif (op in ALL_OP):
        if (op == 'load'):      return compile_load(line)
        elif (op == 'store'):   return compile_store(line)
        elif (op == 'mov'):     return compile_move(line)
        elif (op in ['add', 'sub', 'mul', 'div', 'mod', 'and', 'or', 'xor', 'not', 'neg', 'shl', 'shr']):
            return compile_alu(line)
        elif (op == 'cmp'):     return compile_compare(line)
        elif (op in ['jmp', 'jeq', 'jne', 'jlt', 'jle', 'jgt', 'jge']):
            return compile_jump(line)
        elif (op == 'call'):    return compile_call(line)
        elif (op == 'ret'):     return compile_return(line)
        elif (op in ['brn', 'beq', 'bne', 'blt', 'ble', 'bgt', 'bge']):
            return compile_branch(line)
        elif (op == 'push'):    return compile_push(line)
        elif (op == 'pop'):     return compile_pop(line)
    errorMessage('not have this operation')

def scan_ins(line):
    op = line[0]
    global line_current
    if (op[-1] == ':'):   return store_tag(op)
    elif (op.isdigit()):  line_current = line_current + 1
    elif (op in ALL_OP):  line_current = line_current + 2
    else: errorMessage('not have this operation')

def scanner(code):
    ins_in_file = []
    for line in code:
        ass = line
        line = line.split('//')
        line = line[0].lower().strip().split()
        if line:    ins = scan_ins(line)
        else:       continue

        if not ins:
            ins_in_file.append((ass,line))
    return ins_in_file

def assemble(asm):
    ins_list = scanner(asm)
    assembly = ''
    for t in ins_list:
        print(t[1])
        ins = compiler(t[1])
        print(ins)
        begin, end = '', ''
        count = 0
        for a in ins:
            if (count < 16):    begin += a
            else:               end += a
            if (a != '_'):      count += 1
        assembly += begin.strip('_') + '\n' + end.strip('_') + '\t// ' + t[0] + '\n'
    return assembly
