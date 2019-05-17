from parser import is_id

def get_constants(block):
    if len(block) == 0:
        return []
    if type(block[0]) is list:
        return get_constants(block[0]) + get_constants(block[1:])
    if type(block[0]) is int:
        return [block[0]] + get_constants(block[1:])
    if block[0] in ['load', 'store']:
        return []
    return get_constants(block[1:])

def generate_valOp(dest, valOp, mapper):
    if valOp[0] == '~':
        return 'not {} {}'.format(dest, mapper[valOp[1]])
    else:
        op = {
            '+': 'add',
            '-': 'sub',
            '*': 'mul',
            '/': 'div',
            '%': 'mod',
            '&': 'and',
            '|': 'or',
            '^': 'xor',
            '<<': 'shl',
            '>>': 'shr'
        }[valOp[0]]
        return '{} {} {} {}'.format(op, dest, mapper[valOp[1]], mapper[valOp[2]])

def generate_block(block, fname, base_tag, mapper):
    code = []
    subblock = 0
    for statement in block:
        operation = statement[0]
        if operation == 'return':
            code.append('mov r1 {}'.format(mapper[statement[1]]))
            code.append('jmp {}__return'.format(fname))
        elif operation == 'load':
            if is_id(statement[2]):
                code.append('load {} ({})'.format(mapper[statement[1]], mapper[statement[2]]))
            else:
                code.append('load {} {}'.format(mapper[statement[1]], statement[2]))
        elif operation == 'store':
            if is_id(statement[2]):
                code.append('store {} ({})'.format(mapper[statement[1]], mapper[statement[2]]))
            else:
                code.append('store {} {}'.format(mapper[statement[1]], statement[2]))
        elif operation == 'if':
            condition = statement[1]
            block = statement[2]
            elseBlock = statement[3]
            code.append('cmp {} {}'.format(mapper[condition[1]], mapper[condition[2]]))
            jmpMode = {
                '==': 'ne',
                '!=': 'eq',
                '>': 'le',
                '>=': 'lt',
                '<': 'ge',
                '<=': 'gt',
            }[condition[0]]
            if len(elseBlock) == 0:
                code.append('j{} {}__endif_{}'.format(jmpMode, base_tag, subblock))
                code += generate_block(block, fname, base_tag + '{}__if_{}'.format(base_tag, subblock), mapper)
            else:
                code.append('j{} {}__else_{}'.format(jmpMode, base_tag, subblock))
                code += generate_block(block, fname, base_tag + '{}__if_{}'.format(base_tag, subblock), mapper)
                code.append('jmp {}__endif{}'.format(base_tag, subblock))
                code.append('{}__else_{}:'.format(base_tag, subblock))
                code += generate_block(elseBlock, fname, '{}__else_{}'.format(base_tag, subblock), mapper)
            code.append('{}__endif_{}:'.format(base_tag, subblock))
            subblock += 1
        elif operation == 'while':
            condition = statement[1]
            block = statement[2]
            code.append('{}__while_{}:'.format(base_tag, subblock))
            if condition != 'true':
                jmpMode = {
                    '==': 'ne',
                    '!=': 'eq',
                    '>': 'le',
                    '>=': 'lt',
                    '<': 'ge',
                    '<=': 'gt',
                }[condition[0]]
                code.append('cmp {} {}'.format(mapper[condition[1]], mapper[condition[2]]))
                code.append('j{} {}__endwhile_{}'.format(jmpMode, base_tag, subblock))
            code += generate_block(block, fname, '{}__while_{}'.format(base_tag, subblock), mapper)
            code.append('jmp {}__while_{}'.format(base_tag, subblock))
            code.append('{}__endwhile_{}:'.format(base_tag, subblock))
            subblock += 1
            pass
        elif operation == 'call':
            for i, v in enumerate(statement[2]):
                code.append('mov r{} {}'.format(i+2, mapper[v]))
            code.append('call {}'.format(statement[1]))
        elif operation == 'assign':
            if type(statement[2]) is not list:
                code.append('mov {} {}'.format(mapper[statement[1]], mapper[statement[2]]))
            else:
                asgmtVal = statement[2]
                if asgmtVal[0] == 'call':
                    for i, v in enumerate(asgmtVal[2]):
                        if type(v) is not list:
                            code.append('mov r{} {}'.format(i+2, mapper[v]))
                        else:
                            code.append(generate_valOp('r{}'.format(i+2), v, mapper))
                    code.append('call {}'.format(asgmtVal[1]))
                    code.append('mov {} r1'.format(mapper[statement[1]]))
                else:
                    code.append(generate_valOp(mapper[statement[1]], asgmtVal, mapper))
        else:
            print(statement)
    return code

def generate_func(func, max_params):
    fname = func[0]
    params = func[1]
    localVars = func[2][0]
    block = func[2][1]
    constants = set(get_constants(block))
    variables = params + localVars + list(constants)
    mapper = {}
    for v in variables:
        mapper[v] = 'r{}'.format(len(mapper) + max_params + 2)

    code = []
    code.append('{}:'.format(fname))
    for v in variables:
        code.append('push {}'.format(mapper[v]))
    for i, v in enumerate(params):
        code.append('mov {} r{}'.format(mapper[v], i + 2))
    for v in constants:
        code.append('load {} #{}'.format(mapper[v], v))
    code += generate_block(block, fname, fname, mapper)
    code.append('{}__return:'.format(fname))
    for v in variables[::-1]:
        code.append('pop {}'.format(mapper[v]))
    code.append('ret')
    return code

def generate_code(tree):
    max_params = 0
    for func in tree[:-1]:
        max_params = max(max_params, len(func[1]))
    
    # Main
    main = tree[-1]
    localVars = main[0]
    block = main[1]
    constants = set(get_constants(block))
    variables = localVars + list(constants)
    mapper = {}
    for v in variables:
        mapper[v] = 'r{}'.format(len(mapper) + max_params + 2)
    
    code = []
    for v in constants:
        code.append('load {} #{}'.format(mapper[v], v))
    code += generate_block(block, 'main', '', mapper)
    for func in tree[:-1]:
        code += generate_func(func, max_params)
    return code
