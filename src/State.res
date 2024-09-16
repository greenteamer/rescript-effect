type t<'s, 'a> = State('s => ('a, 's))

// return a state computation from a function
let return = (f: 's => (unit, 's)) => State(f)

// return a state computation from a value
let make = (a: 'a): t<'s, 'a> => State(s => (a, s))

let run = (State(f): t<'s, 'a>, init: 's): ('a, 's) => f(init)

let chain = (st: t<'s, 'a>, fab: 'a => t<'s, 'b>): t<'s, 'b> => State(
  state => {
    let (a, s) = run(st, state)
    let State(stb) = fab(a)
    stb(s)
  },
)

let chainFirst = (st: t<'s, 'a>, fab: 'a => t<'s, 'b>): t<'s, 'a> => State(
  s => {
    let (a, s) = run(st, s)
    run(fab(a), s)
  },
)

let map = (sm: t<'s, 'a>, fab: 'a => 'b): t<'s, 'b> => sm->chain(a => a->fab->make)

// Get the current state
let get = (): t<'s, 's> => State(s => (s, s))

// Set the state
let put = (s: 's): t<'s, unit> => State(_ => ((), s))

// Modify the state by applying a function to the current state
let modify = (f: 's => 's): t<'s, unit> => State(s => ((), f(s)))

// Get a value which depends on the current state
let gets = (f: 's => 'a): t<'s, 'a> => State(s => (f(s), s))

// lift a computation from the State
let ap = (fa: t<'s, 'a>, fab: t<'s, 'a => 'b>): t<'s, 'b> => State(
  s => {
    let (a, s) = run(fa, s)
    let (a2b, s) = run(fab, s)
    (a2b(a), s)
  },
)

let flatten = (mma: t<'s, t<'s, 'a>>) => mma->chain(Helpers.identity)
