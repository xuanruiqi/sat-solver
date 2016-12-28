(***********************************************************
 * eval.ml: the SAT solver
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

type solution = Solution of env | Unsolvable
exception InvalidExpr
exception NotImplemented

let rec solve (env, e, v) =
match e with
| Var x     -> if not (isBound (env, x))
               then Solution (bindName (env, x, v))
               else if (find (env, x) = v)
               then Solution env
               else Unsolvable
| Literal l -> if l then Solution env else Unsolvable
| Assign _  -> raise InvalidExpr
| And (e1, e2) ->  
    if v (* both must be true *)
    then (match solve (env, e1, true) with
    | Solution env' -> solve (env', e2, true)
    | Unsolvable    -> Unsolvable)
    else (* only one needs to be false *) (
    match solve (env, e1, false) with
    | Solution env1 -> Solution env1
    | Unsolvable    -> solve (env, e2, false))
| Or  (e1, e2) -> 
    if v (* only one needs to be true *)
    then (match solve (env, e1, true) with
    | Solution env1 -> Solution env1
    | Unsolvable    -> solve (env, e2, true))
    else (* both must be false *) (
    match solve (env, e1, false) with
    | Solution env' -> solve (env', e2, false)
    | Unsolvable    -> Unsolvable)
| Not e        -> solve (env, e, not v)
| Imply (e1, e2) -> raise NotImplemented