module Promise = Js.Promise2

let identity = (a: 'a): 'a => a

module Result = {
  let mapLeft = (fa, f) =>
    switch fa {
    | Error(err) => Error(f(err))
    | Ok(v) => Ok(v)
    }

  let fold = (fa: result<result<'a, 'e>, 'e>) =>
    switch fa {
    | Error(e) => Error(e)
    | Ok(Error(e)) => Error(e)
    | Ok(Ok(a)) => Ok(a)
    }

  let chain = (result: result<'a, 'error>, fab: 'a => result<'b, 'error>): result<'b, 'error> => {
    switch result {
    | Ok(value) => fab(value)
    | Error(error) => Error(error)
    }
  }

  let chainFirst = (result: result<'a, 'error>, fab: 'a => result<'b, 'error>): result<
    'a,
    'error,
  > => {
    switch result {
    | Ok(value) => {
        fab(value)->ignore
        result
      }
    | Error(error) => Error(error)
    }
  }

  let fromOption = (option: option<'a>, error: 'e): result<'a, 'e> =>
    switch option {
    | Some(value) => Ok(value)
    | None => Error(error)
    }

  let fromBool = (value: bool, error: 'e): result<'a, 'e> =>
    switch value {
    | true => Ok(value)
    | false => Error(error)
    }

  let orElse = (m, alternative) =>
    switch m {
    | Ok(v) => Ok(v)
    | Error(_) => alternative
    }

  let stackWithResult = (r: result<'b, 'err>) => a => r->Result.map(b => (a, b))

  let stackWithResult2 = (r: result<'c, 'err>) => ((a, b)) => r->Result.map(c => (a, b, c))

  let stackWithResult3 = (r: result<'d, 'err>) => ((a, b, c)) => r->Result.map(d => (a, b, c, d))
}

module Option = {
  let fromResult = r =>
    switch r {
    | Ok(v) => Some(v)
    | Error(_) => None
    }
}

let mapValidationError = (r: result<'a, S.error>, marker: string) =>
  r->Result.mapLeft(err => #ValidationError(marker ++ "\n" ++ err->S.Error.message))
