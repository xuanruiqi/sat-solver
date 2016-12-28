(***********************************************************
 * eval.ml: the boolean evaluator REPL
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

open Eval
open Expr

let parse (s: string) : Expr.expr = 
    Parser.main Lexer.read (Lexing.from_string s)

let print_bool_endline b =
if b then print_endline "true"
else print_endline "false"

let rec repl env = 
    print_string "> ";
    let input = read_line () in
    if  input = "" then ()
    else 
    try
        let e = parse input in
        let (newEnv, result) = eval (env, e) in
        print_bool_endline result;
        repl newEnv;
    with
    _ -> print_endline "Error!";
         repl env;
;;


repl empty;