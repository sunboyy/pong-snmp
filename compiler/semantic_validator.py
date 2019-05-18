from parser import is_id

def validate_val(vars, val):
    if is_id(val) and val not in vars:
        raise SyntaxError('Undeclared identifier ' + val)

def validate_fname(fnames, fname):
    if fname not in fnames:
        raise SyntaxError('Undeclared function ' + fname)

def validate_valOp(vars, valOp):
    if valOp is not list:
        validate_val(vars, valOp)
    elif valOp[0] == '~':
        validate_val(vars, valOp[1])
    else:
        validate_val(vars, valOp[1])
        validate_val(vars, valOp[2])

def validate_call(vars, fnames, call):
    validate_fname(fnames, call[1])
    if fnames[call[1]] != len(call[2]):
        raise SyntaxError('Unmatched parameter of function ' + call[1])
    for val in call[2]:
        validate_valOp(vars, val)

def validate_asgmtVal(vars, fnames, asgmtVal):
    if type(asgmtVal) is not list:
        validate_val(vars, asgmtVal)
    elif asgmtVal[0] == 'call':
        validate_call(vars, fnames, asgmtVal)
    else:
        validate_valOp(vars, asgmtVal)

def validate_condition(vars, condition):
    if condition != 'true':
        validate_val(vars, condition[1])
        validate_val(vars, condition[2])

def validate_block(vars, fnames, block):
    for statement in block:
        operation = statement[0]
        if operation == 'return':
            validate_val(vars, statement[1])
        elif operation == 'load':
            validate_val(vars, statement[1])
            validate_val(vars, statement[2])
        elif operation == 'store':
            validate_val(vars, statement[1])
            validate_val(vars, statement[2])
        elif operation == 'if':
            validate_condition(vars, statement[1])
            validate_block(vars, fnames, statement[2])
            validate_block(vars, fnames, statement[3])
        elif operation == 'while':
            validate_condition(vars, statement[1])
            validate_block(vars, fnames, statement[2])
        elif operation == 'call':
            validate_call(vars, fnames, statement)
        elif operation == 'assign':
            validate_val(vars, statement[1])
            validate_asgmtVal(vars, fnames, statement[2])

def validate_func(fnames, func):
    funcName = func[0]
    params = func[1]
    localVar = func[2][0]
    allVars = params + localVar
    for i, var in enumerate(allVars):
        if var in allVars[i+1:]:
            raise SyntaxError('Duplicate variable declaration ' + var + ' in ' + funcName)
    block = func[2][1]
    validate_block(allVars, fnames, block)

def validate(tree):
    # Get all function names
    fnames = {}
    maxParams = 0
    for func in tree[:-1]:
        if func[0] in fnames:
            raise SyntaxError('Duplicate function name ' + func[0])
        fnames[func[0]] = len(func[1])
        maxParams = max(maxParams, len(func[1]))

    # Validate variables in functions
    for func in tree[:-1]:
        validate_func(fnames, func)

    # Validate variables in main
    localVar = tree[-1][0]
    for i, var in enumerate(localVar):
        if var in localVar[i+1:]:
            raise SyntaxError('Duplicate variable declaration ' + var + ' in main')
    block = tree[-1][1]
    validate_block(localVar, fnames, block)
