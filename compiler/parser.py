import re

def is_id(token: str) -> bool:
    if type(token) is not str:
        return False
    match = re.findall('^[a-zA-Z_][a-zA-Z_0-9]?$', token)
    return len(match) > 0

def is_fname(token: str) -> bool:
    return token[0].isalpha() and len(token) > 2

def is_hex(token: str) -> bool:
    return token[:2] == '0x'

def is_num(token: str) -> bool:
    return token.isdigit()

class Parser:
    def __init__(self):
        pass
    
    def parse(self, tokens):
        self.tokens = tokens
        tree = self.__parse_code()
        if len(self.tokens) > 0:
            raise SyntaxError('Unknown token ' + self.tokens[0])
        return tree

    def __match(self, expected: str):
        if self.tokens[0] == expected:
            self.tokens = self.tokens[1:]
        else:
            raise SyntaxError(expected + ' expected but got ' + self.tokens[0])

    def __parse_code(self):
        if self.tokens[0] == 'func':
            func = self.__parse_function()
            code = self.__parse_code()
            return [func] + code
        elif self.tokens[0] == '(':
            return [self.__parse_funcContent()]
        raise SyntaxError('Unexpected token ' + self.tokens[0])

    def __parse_function(self):
        if self.tokens[0] == 'func':
            self.__match('func')
            fname = self.__parse_fname()
            self.__match('(')
            params = self.__parse_params()
            self.__match(')')
            content = self.__parse_funcContent()
            return [fname, params, content]
        raise SyntaxError('Unexpected token ' + self.tokens[0])

    def __parse_params(self):
        if self.tokens[0] == ')':
            return []
        elif is_id(self.tokens[0]):
            id = self.__parse_id()
            params = self.__parse_params2()
            return [id] + params
        raise SyntaxError('Unexpected token ' + self.tokens[0])

    def __parse_params2(self):
        if self.tokens[0] == ')':
            return []
        elif self.tokens[0] == ',':
            self.__match(',')
            id = self.__parse_id()
            params = self.__parse_params2()
            return [id] + params
        raise SyntaxError('Unexpected token ' + self.tokens[0])

    def __parse_funcContent(self):
        if self.tokens[0] == '(':
            self.__match('(')
            params = self.__parse_params()
            self.__match(')')
            self.__match('{')
            block = self.__parse_block()
            self.__match('}')
            return [params, block]
        raise SyntaxError('Unexpected token ' + self.tokens[0])

    def __parse_block(self):
        if self.tokens[0] == '}':
            return []
        elif is_fname(self.tokens[0]) or is_id(self.tokens[0]):
            stmt = self.__parse_statement()
            self.__match(';')
            block = self.__parse_block()
            return [stmt] + block
        raise SyntaxError('Unexpected token ' + self.tokens[0])

    def __parse_statement(self):
        if self.tokens[0] == 'return':
            self.__match('return')
            val = self.__parse_val()
            return ['return', val]
        elif self.tokens[0] == 'load':
            self.__match('load')
            id = self.__parse_id()
            val = self.__parse_val()
            return ['load', id, val]
        elif self.tokens[0] == 'store':
            self.__match('store')
            id = self.__parse_id()
            val = self.__parse_val()
            return ['store', id, val]
        elif self.tokens[0] == 'if':
            self.__match('if')
            self.__match('(')
            condition = self.__parse_condition()
            self.__match(')')
            self.__match('{')
            block = self.__parse_block()
            self.__match('}')
            elseBlock = self.__parse_elseBlock()
            return ['if', condition, block, elseBlock]
        elif self.tokens[0] == 'while':
            self.__match('while')
            self.__match('(')
            condition = self.__parse_condition()
            self.__match(')')
            self.__match('{')
            block = self.__parse_block()
            self.__match('}')
            return ['while', condition, block]
        elif is_id(self.tokens[0]):
            return self.__parse_assignment()
        elif is_fname(self.tokens[0]):
            fname = self.__parse_fname()
            self.__match('(')
            params = self.__parse_paramCall()
            self.__match(')')
            return ['call', fname, params]
        raise SyntaxError('Unexpected token ' + self.tokens[0])

    def __parse_assignment(self):
        if is_id(self.tokens[0]):
            id = self.__parse_id()
            self.__match('=')
            asgmtVal = self.__parse_asgmtVal()
            return ['assign', id, asgmtVal]
        raise SyntaxError('Unexpected token ' + self.tokens[0])

    def __parse_asgmtVal(self):
        if self.tokens[0] == '~' or is_id(self.tokens[0]) or is_num(self.tokens[0]):
            valOp = self.__parse_valOp()
            return valOp
        elif is_fname(self.tokens[0]):
            fname = self.__parse_fname()
            self.__match('(')
            params = self.__parse_paramCall()
            self.__match(')')
            return ['call', fname, params]
        raise SyntaxError('Unexpected token ' + self.tokens[0])

    def __parse_asgmtVal2(self):
        if self.tokens[0] == ';':
            return []
        elif self.tokens[0] in ['+', '-', '*', '/', '%', '&', '|', '^', '~', '<<', '>>']:
            op = self.__parse_op()
            val = self.__parse_val()
            return [op, val]
        raise SyntaxError('Unexpected token ' + self.tokens[0])

    def __parse_valOp(self):
        if self.tokens[0] == '~':
            self.__match('~')
            id = self.__parse_id()
            return ['~', id]
        elif is_id(self.tokens[0]) or is_num(self.tokens[0]):
            val = self.__parse_val()
            valOp2 = self.__parse_valOp2()
            if len(valOp2) > 0:
                return [valOp2[0], val, valOp2[1]]
            else:
                return val
        raise SyntaxError('Unexpected token ' + self.tokens[0])

    def __parse_valOp2(self):
        if self.tokens[0] in [';', ')', ',']:
            return []
        elif self.tokens[0] in ['+', '-', '*', '/', '%', '&', '|', '^', '~', '<<', '>>']:
            op = self.__parse_op()
            val = self.__parse_val()
            return [op, val]
        raise SyntaxError('Unexpected token ' + self.tokens[0])

    def __parse_val(self):
        if is_id(self.tokens[0]):
            return self.__parse_id()
        elif is_num(self.tokens[0]) or is_hex(self.tokens[0]):
            return self.__parse_num()
        raise SyntaxError('Unexpected token ' + self.tokens[0])

    def __parse_paramCall(self):
        if self.tokens[0] == ')':
            return []
        elif is_id(self.tokens[0]) or is_num(self.tokens[0]):
            valOp = self.__parse_valOp()
            valOps = self.__parse_paramCall2()
            return [valOp] + valOps
        raise SyntaxError('Unexpected token ' + self.tokens[0])

    def __parse_paramCall2(self):
        if self.tokens[0] == ')':
            return []
        elif self.tokens[0] == ',':
            self.__match(',')
            valOp = self.__parse_valOp()
            valOps = self.__parse_paramCall2()
            return [valOp] + valOps
        raise SyntaxError('Unexpected token ' + self.tokens[0])

    def __parse_elseBlock(self):
        if self.tokens[0] == ';':
            return []
        elif self.tokens[0] == 'else':
            self.__match('else')
            self.__match('{')
            block = self.__parse_block()
            self.__match('}')
            return block
        raise SyntaxError('Unexpected token ' + self.tokens[0])

    def __parse_condition(self):
        if self.tokens[0] == 'true':
            self.__match('true')
            return 'true'
        if is_id(self.tokens[0]) or is_num(self.tokens[0]):
            val1 = self.__parse_val()
            cmp = self.__parse_cmp()
            val2 = self.__parse_val()
            return [cmp, val1, val2]
        raise SyntaxError('Unexpected token ' + self.tokens[0])

    def __parse_id(self):
        if is_id(self.tokens[0]):
            id = self.tokens[0]
            self.tokens = self.tokens[1:]
            return id
        raise SyntaxError('Unexpected token ' + self.tokens[0])

    def __parse_fname(self):
        if is_fname(self.tokens[0]):
            fname = self.tokens[0]
            self.tokens = self.tokens[1:]
            return fname
        raise SyntaxError('Unexpected token ' + self.tokens[0])

    def __parse_num(self):
        if is_num(self.tokens[0]):
            num = self.tokens[0]
            self.tokens = self.tokens[1:]
            return int(num)
        if is_hex(self.tokens[0]):
            num = self.tokens[0]
            self.tokens = self.tokens[1:]
            return int(num[2:], 16)
        raise SyntaxError('Unexpected token ' + self.tokens[0])

    def __parse_op(self):
        if self.tokens[0] in ['+', '-', '*', '/', '%', '&', '|', '^', '~', '<<', '>>']:
            op = self.tokens[0]
            self.tokens = self.tokens[1:]
            return op
        raise SyntaxError('Unexpected token ' + self.tokens[0])

    def __parse_cmp(self):
        if self.tokens[0] in ['==', '>', '>=', '<', '<=', '!=']:
            cmp = self.tokens[0]
            self.tokens = self.tokens[1:]
            return cmp
        raise SyntaxError('Unexpected token ' + self.tokens[0])
