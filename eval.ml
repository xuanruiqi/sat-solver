(***********************************************************
 * eval.ml: the boolean expression evaluator
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

open Expr

let rec eval (env, e) = 
match e with
| Var x           -> (env, find (env, x))
| Literal l       -> (env, l)
| Assign (x, l)   -> (bindName (env, x, l), l)
| And    (e1, e2) -> (
  let (env1, v1) = eval (env, e1)  in
  let (env2, v2) = eval (env1, e2) in
  (env2, v1 && v2))
| Or     (e1, e2) -> (
  let (env1, v1) = eval (env, e1)  in
  let (env2, v2) = eval (env1, e2) in
  (env2, v1 || v2))
| Not    e        -> (
  let (env', v) = eval (env, e) in
  (env', v))
| Imply  (e1, e2) -> (
  let implies p q = (not p) or q   in
  let (env1, v1) = eval (env, e1)  in
  let (env2, v2) = eval (env1, e2) in
  (env2, implies v1 v2))