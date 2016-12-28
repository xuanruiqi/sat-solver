(***********************************************************
 * expr.ml: expression definitions
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
