from typing import List
import re


def tokenize(code: str) -> List[str]:
    segments = ' '.join([e.split('//')[0] for e in code.split('\n')])
    return __tokenize(segments)


def __tokenize(code: str) -> List[str]:
    code = code.strip()
    if len(code) == 0:
        return []
    match = re.findall('^[\>\<\=\!]\=', code)
    if len(match) > 0:
        token = match[0]
        return [token] + __tokenize(code[len(token):])
    match = re.findall('^[<>]{2}', code)
    if len(match) > 0:
        token = match[0]
        return [token] + __tokenize(code[len(token):])
    match = re.findall('^[;,\(\)\{\}\+\-\*\/\%\&\|\^\~\=\<\>]', code)
    if len(match) > 0:
        token = match[0]
        return [token] + __tokenize(code[len(token):])
    match = re.findall('^[a-zA-Z_][a-zA-Z_0-9]*', code)
    if len(match) > 0:
        token = match[0]
        return [token] + __tokenize(code[len(token):])
    match = re.findall('^0x[0-9A-Fa-f]+', code)
    if len(match) > 0:
        token = match[0]
        return [token] + __tokenize(code[len(token):])
    match = re.findall('^\d+', code)
    if len(match) > 0:
        token = match[0]
        return [token] + __tokenize(code[len(token):])
    raise SyntaxError('Unknown token ' + code[0])
