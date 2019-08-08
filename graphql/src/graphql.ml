module Err = struct
  type t = string

  let message_of_error t = t
  let extensions_of_error _t = []
end

module Context = struct
  type t = {dummy: string}
end

module Schema = Graphql_schema.Make (struct
  type +'a t = 'a

  let bind t f = f t
  let return t = t

  module Stream = struct
    type 'a t = 'a Seq.t

    let map t f = Seq.map f t
    let iter t f = Seq.iter f t
    let close _t = ()
  end
end) (Err) (Context)
