@genType
type t<'a> = Task(unit => promise<'a>)

let fromIO = (ta): t<'a> => Task(async () => ta())

let fromPromise = (ta): t<'a> => Task(ta)

let run = (Task(ta): t<'a>) => {
  try ta() catch {
  | Js.Exn.Error(obj) => {
      let helpText = "[Task] can't throw. "
      let msg = switch Js.Exn.message(obj) {
      | Some(msg) => helpText ++ msg
      | None => helpText ++ "unknown error."
      }
      Js.Console.error(msg)
      Js.Exn.raiseError(msg)
    }
  }
}

let map = (ta: t<'a>, fab: 'a => 'b): t<'b> =>
  fromPromise(async () =>
    switch await run(ta) {
    | a => fab(a)
    }
  )

let chain = (ta: t<'a>, fab: 'a => t<'b>): t<'b> =>
  fromPromise(async () => {
    let a = await run(ta)
    let b = await run(fab(a))
    b
  })

let chainFirst = (ta, fab: 'a => t<'b>): t<'a> =>
  fromPromise(async () => {
    let a = await run(ta)
    await run(fab(a))
    a
  })
