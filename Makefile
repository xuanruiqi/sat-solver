all: solver evaluator

solver:
	ocamlbuild -r -use-menhir repl.native
	@mv repl.native solver

evaluator:
	ocamlbuild -r -use-menhir evalrepl.native
	@mv evalrepl.native eval

clean:
	ocamlbuild -clean
