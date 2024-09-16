module Null = {
  @genType @unboxed type t<'a> = Presented('a) | @as(null) Null
}
