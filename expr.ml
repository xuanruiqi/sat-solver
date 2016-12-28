type expr =
  | Var     of string
  | Literal of bool
  | Assign  of string * bool
  | And     of expr * expr
  | Or      of expr * expr
  | Not     of expr
  | Imply   of expr * expr

module VarMap = Map.Make(String)
type env = bool VarMap.t;;

let empty                = VarMap.empty
let isBound    (env, id) = VarMap.mem id env
let find       (env, id) = VarMap.find id env
let bindName   (env, id, v) = VarMap.add id v env
let unbindName (env, id) = VarMap.remove id env
