type rec t<'b, 'c> =
  | Nil: t<'b, 'b>
  | Cons('a, t<'b, 'c>): t<'b, 'a => 'c>
