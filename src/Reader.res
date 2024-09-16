@genType
type t<'e, 'a> = Reader('e => 'a)

let make = (ea): t<'e, 'a> => Reader(ea)

let run = (Reader(r): t<'e, 'a>, env): 'a => r(env)

let ask = (): t<'e, 'e> => Reader(env => env)

let asks = (ea: 'e => 'a): t<'e, 'a> => Reader(env => ea(env))

let local = (r: t<'e, 'a>, fe: 'e => 'e) => Reader(env => run(r, fe(env)))

let map = (r: t<'e, 'a>, fab: 'a => 'b) => Reader(env => fab(run(r, env)))

let chain = (Reader(ea): t<'e, 'a>, fab: 'a => t<'e, 'b>) => Reader(env => run(env->ea->fab, env))

let chainFirst = (Reader(ea): t<'e, 'a>, fab: 'a => t<'e, 'b>): t<'e, 'a> => Reader(
  env => {
    let _ = ea(env)->fab->run(env)
    ea(env)
  },
)
