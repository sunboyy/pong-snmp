- Compile

```
python3 ./compiler/compiler.py program/program.sb -S -o program.pp
python3 ./compiler/compiler.py program/interrupt.sb -S -o interrupt.pp

python3 ./compiler/assembler.py fullprogram.pp -o fullprogram.mo
```

```
python3 ./compiler/compiler.py ./program/program.sb -o program.mo
```

Constraint

- len(funtion name) >= 3
- len(variable name) <= 2
