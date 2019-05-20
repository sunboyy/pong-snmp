# SB Compiler
This is the compiler which translates .sb file into machine code for this architecture in the memory file format that can be used in Vivado.

## Usage
To compile from .sb to machine code, run
```
$ python3 compiler.py <source.sb> -o <dest.mem>
```

To compile from .sb to assembly-like language, run with option `-S`
```
$ python3 compiler.py <source.sb> -S -o <dest.mem>
```

---

Constraint

- len(funtion name) >= 3
- len(variable name) <= 2
