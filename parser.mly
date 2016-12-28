%{ open Expr %}

(* Tokens *)

%token EOF LPAREN RPAREN SEMICOLON
%token AND OR NOT IMP
%token EQUAL
%token TRUE FALSE
%token <string> VAR

%left NOT
%left AND
%left OR
%left IMP

%start <Expr.expr> main
%%

main:
  | e = expr EOF { e } ;

expr:
  | v = VAR                 { Var v }
  | v = VAR EQUAL TRUE      { Assign (v, true) }
  | v = VAR EQUAL FALSE     { Assign (v, false) }
  | TRUE                    { Literal true}
  | FALSE                   { Literal false}
  | LPAREN e = expr RPAREN  { e }
  | e1 = expr AND e2 = expr { And (e1, e2) }
  | e1 = expr OR  e2 = expr { Or  (e1, e2) }
  | e1 = expr IMP e2 = expr { Imply (e1, e2) }
  | NOT e = expr            { Not e }
