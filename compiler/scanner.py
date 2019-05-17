import re

def tokenize(code):
    segments = ' '.join([e.split('//')[0] for e in code.split('\n')])
    return __tokenize(segments.split())

def __tokenize(code):
    if len(code) == 0:
        return []
    if code[0] == '':
        return __tokenize(code[1:])
    segment = code[0]
    match = re.findall('^[\>\<\=\!]\=', segment)
    if len(match) > 0:
        token = match[0]
        return [token] + __tokenize([segment[len(token):]] + code[1:])
    match = re.findall('^[<>]{2}', segment)
    if len(match) > 0:
        token = match[0]
        return [token] + __tokenize([segment[len(token):]] + code[1:])
    match = re.findall('^[;,\(\)\{\}\+\-\*\/\%\&\|\^\~\=\<\>]', segment)
    if len(match) > 0:
        token = match[0]
        return [token] + __tokenize([segment[len(token):]] + code[1:])
    match = re.findall('^[a-zA-Z_][a-zA-Z_0-9]*', segment)
    if len(match) > 0:
        token = match[0]
        return [token] + __tokenize([segment[len(token):]] + code[1:])
    match = re.findall('^0x[0-9A-Fa-f]+', segment)
    if len(match) > 0:
        token = match[0]
        return [token] + __tokenize([segment[len(token):]] + code[1:])
    match = re.findall('^\d+', segment)
    if len(match) > 0:
        token = match[0]
        return [token] + __tokenize([segment[len(token):]] + code[1:])
    raise SyntaxError('Unknown token ' + segment)
