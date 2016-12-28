open Eval
open Expr
open Solve

let parse (s: string) : Expr.expr = 
    Parser.main Lexer.read (Lexing.from_string s)

let print_bool_endline b =
if b then print_endline "true"
else print_endline "false"

let print_solution s =
match s with
| Solution env  -> 
    let printBinding x l = print_endline (x ^ " : " ^ string_of_bool l) in
    VarMap.mapi printBinding env;
    ();
| Unsolvable    -> print_endline "Unsolvable"

let rec repl env = 
    print_string "> ";
    let input = read_line () in
    if  input = "" then ()
    else 
    try
        let e = parse input in
        match e with
        | Assign (x, l) -> let (env', _) = eval (env, e) in
                           print_bool_endline l;
                           repl env';
        | _             -> let s = solve (env, e, true) in
                           print_solution s;
                           repl env;
    with
    _ -> print_endline "Error!";
         repl env;
;;

repl empty;