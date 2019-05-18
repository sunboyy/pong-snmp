from typing import List
import re


def tokenize(code: str) -> List[str]:
    segments = ' '.join([e.split('//')[0] for e in code.split('\n')])
    return __tokenize(segments)


def __tokenize(code: str) -> List[str]:
    tokens = []
    while len(code) > 0:
        code = code.strip()
        match = re.findall('^[\>\<\=\!]\=', code)
        if len(match) > 0:
            token = match[0]
            tokens.append(token)
            code = code[len(token):]
            continue
        match = re.findall('^[<>]{2}', code)
        if len(match) > 0:
            token = match[0]
            tokens.append(token)
            code = code[len(token):]
            continue
        match = re.findall('^[;,\(\)\{\}\+\-\*\/\%\&\|\^\~\=\<\>]', code)
        if len(match) > 0:
            token = match[0]
            tokens.append(token)
            code = code[len(token):]
            continue
        match = re.findall('^[a-zA-Z_][a-zA-Z_0-9]*', code)
        if len(match) > 0:
            token = match[0]
            tokens.append(token)
            code = code[len(token):]
            continue
        match = re.findall('^0x[0-9A-Fa-f]+', code)
        if len(match) > 0:
            token = match[0]
            tokens.append(token)
            code = code[len(token):]
            continue
        match = re.findall('^\d+', code)
        if len(match) > 0:
            token = match[0]
            tokens.append(token)
            code = code[len(token):]
            continue
        raise SyntaxError('Unknown token ' + code[0])
    return tokens
