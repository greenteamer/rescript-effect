// Generated by ReScript, PLEASE EDIT WITH CARE


function getMessage(err) {
  var variant = err.NAME;
  if (variant === "NetworkError" || variant === "ValidationError") {
    return err.VAL;
  } else if (variant === "AppError") {
    return "AppError: " + err.VAL;
  } else {
    return err.VAL[0].toString() + " Request Error.";
  }
}

function handleIOError(err, handlers) {
  var variant = err.NAME;
  if (variant === "ValidationError") {
    return handlers.onValidationError(err.VAL);
  } else if (variant === "AppError") {
    return handlers.onAppError(err.VAL);
  } else if (variant === "NetworkError") {
    return handlers.onNetworkError(err.VAL);
  } else {
    return handlers.onRequestError(err.VAL[0].toString() + ": Request Error.");
  }
}

function logError(err, marker) {
  var msg = getMessage(err);
  console.log(marker + " " + msg);
}

var Utils = {
  getMessage: getMessage,
  handleIOError: handleIOError,
  logError: logError
};

export {
  Utils ,
}
/* No side effect */
