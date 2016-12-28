The Simple SAT Solver
=====================

A simple solver for the boolean satisfiability problem (SAT) written in
OCaml and a simple Boolean expression evaluator.

## Author
Xuanrui Qi

## Build
`make` to build both the solver and the evaluator; `make solver` to build
the solver; `make evaluator` to build the evaluator.

## Features
The solver solves the SAT problem for given boolean expressions. It also
supports pre-assigning values to variables as additional constraints.
```
$ ./solver
> (not m) and m
Unsolvable
> (q or n) and (not p or m)
m : false
p : false
q : true
> (r /\ p) \/ (~p /\ m \/ n)
p : true
r : true
```

## Usage
Use `&&`, `and` or `/\` for logical and, `||`, `or` or `\/` for logical or,
and `!`, `not`, or `~` for logical negation. Valid identifiers consist of
alphanumeric characters and the underscore (`_`), except for `true` and `false`
which are boolean literals.

## License
Mozilla Public License. See "LICENSE" file for details.
