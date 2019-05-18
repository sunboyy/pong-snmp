#! /usr/bin/env python3

from scanner import tokenize
from parser import Parser
from semantic_validator import validate
from code_generator import generate_code
from argparse import ArgumentParser
from assembler import assemble
import sys

def compile(code):
    tokens = tokenize(code)
    parser = Parser()
    parse_tree = parser.parse(tokens)
    validate(parse_tree)
    return generate_code(parse_tree)

def prettify(asm):
    text = []
    for line in asm:
        if ':' not in line:
            text.append('    ' + line)
        else:
            text.append(line)
    return text

if __name__ == "__main__":
    argparser = ArgumentParser()
    argparser.add_argument('src', help='Source path')
    argparser.add_argument('-o', '--output-path', dest='output_path', help='Output path')
    args = argparser.parse_args()
    with open(args.src) as infile:
        code = infile.read()
    sys.setrecursionlimit(10000)
    asm = compile(code)
    assembly = assemble(asm, args.output_path)
    if args.output_path:
        with open(args.output_path, 'w') as outfile:
            outfile.write(assembly)
    else:
        print(assembly)
