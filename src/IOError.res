type status = int
type code = int
type message = string

@genType.as("IOError")
type t = [
  | #ValidationError(string)
  | #AppError(string)
  | #RequestError(status, Js.Json.t)
  | #NetworkError(string)
]

module Utils = {
  @genType
  let getMessage = (err: t): string =>
    switch err {
    | #AppError(msg) => "AppError: " ++ msg
    | #ValidationError(msg) => msg
    | #RequestError(status, _) => `${status->Int.toString} Request Error.`
    | #NetworkError(msg) => msg
    }

  type ioErrorHandlers = {
    onAppError: string => unit,
    onValidationError: string => unit,
    onRequestError: string => unit,
    onNetworkError: string => unit,
  }

  @genType
  let handleIOError = (err: t, handlers: ioErrorHandlers) => {
    switch err {
    | #AppError(msg) => handlers.onAppError(msg)
    | #ValidationError(msg) => handlers.onValidationError(msg)
    | #RequestError(status, _) => handlers.onRequestError(`${status->Int.toString}: Request Error.`)
    | #NetworkError(msg) => handlers.onNetworkError(msg)
    }
  }

  let logError = (err, marker) => {
    let msg = getMessage(err)
    Js.Console.log(marker ++ " " ++ msg)
  }
}
