@genType
module T = Task

@genType
type t<'a, 'e> = T.t<result<'a, 'e>>

let fromIO = (ta): t<'a, 'e> => T.Task(async () => ta())

let fromPromise = (ta: unit => promise<result<'a, 'e>>): t<'a, 'e> => T.Task(ta)

let tryCatch = (ta: unit => Promise.t<'a>, onRejected): t<'a, 'e> => T.Task(
  async () => {
    try {
      let res = await ta()
      res->Ok
    } catch {
    | _ => onRejected()->Error
    }
  },
)

let run = (T.Task(ta)) => ta()

let map = (ta: t<'a, 'e>, fab: 'a => 'b): t<'b, 'e> => T.Task(
  async () => {
    switch await ta->run {
    | Ok(a) => a->fab->Ok
    | Error(e) => e->Error
    }
  },
)

let mapError = (ta: t<'a, 'e>, feb: 'e => 'e2): t<'a, 'e2> => T.Task(
  async () => {
    switch await ta->run {
    | Ok(a) => a->Ok
    | Error(e) => e->feb->Error
    }
  },
)

let chain = (ta: t<'a, 'e>, fab: 'a => t<'b, 'e>): t<'b, 'e> => T.Task(
  async () => {
    switch await ta->run {
    | Ok(a) => await a->fab->run
    | Error(e) => e->Error
    }
  },
)

let chainFirst = (ta: t<'a, 'e>, fab: 'a => t<'b, 'e>): t<'a, 'e> => T.Task(
  async () => {
    switch await ta->run {
    | Ok(a) => {
        let fabResult = await a->fab->run
        switch fabResult {
        | Ok(_) => a->Ok
        | Error(e) => e->Error
        }
      }
    | Error(e) => e->Error
    }
  },
)

let chainResult = (ta: t<'a, 'e>, fab: 'a => result<'b, 'e>): t<'b, 'e> => T.Task(
  async () => {
    let aResult = await ta->run
    aResult->Result.flatMap(fab)
  },
)
