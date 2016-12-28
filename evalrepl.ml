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