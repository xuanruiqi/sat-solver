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