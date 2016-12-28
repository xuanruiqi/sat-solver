(***********************************************************
 * eval.ml: the boolean expression lexer and scanner
 * Copyright 2016 by Xuanrui Qi <me@xuanruiqi.com> 
 * Licensed under Mozilla Public License. 
 * Available at
 * 
 *     https://www.mozilla.org/en-US/MPL/2.0/ 
 * 
 * Covered Software is provided under this License 
 * on an “as is” basis, without warranty of any kind, 
 * either expressed, implied, or statutory, including, 
 * without limitation, warranties that the Covered Software 
 * is free of defects, merchantable, fit for a particular 
 * purpose or non-infringing. No liability is assumed unless 
 * required by law or consented by writing. Refer to 
 * license for details. *)

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
