{
  open Lexing
  open Parser
}

let id = ['a'-'z' 'A'-'Z' '_'] ['a'-'z' 'A'-'Z' '0'-'9' '_']*

rule read =
  parse
  | [' ' '\t' '\n']       { read lexbuf }
  | '('                   { LPAREN }
  | ')'                   { RPAREN }
  | '='                   { EQUAL }
  | "true"                { TRUE }
  | "false"               { FALSE }
  | "and" | "/\\" | "&&"  { AND }
  | "or"  | "\\/" | "||"  { OR }
  | "not" | "!" | "~"     { NOT }
  | "->"                  { IMP }
  | id as x               { VAR(x) }
  | eof                   { EOF }
