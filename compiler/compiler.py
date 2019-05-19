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
    argparser.add_argument('-S', dest='asm', help='Assembly', type=bool, default=False, nargs='?', const=True)
    args = argparser.parse_args()
    with open(args.src) as infile:
        code = infile.read()
    sys.setrecursionlimit(5000)
    asm = compile(code)
    if args.asm:
        asm = prettify(asm)
        if args.output_path:
            with open(args.output_path, 'w') as outfile:
                for line in asm:
                    outfile.write(line + '\n')
        else:
            print(asm)
    else:
        machine_code = assemble(asm)
        if args.output_path:
            with open(args.output_path, 'w') as outfile:
                outfile.write(machine_code)
        else:
            print(machine_code)
