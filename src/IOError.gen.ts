/* TypeScript file generated from IOError.res by genType. */

/* eslint-disable */
/* tslint:disable */

const IOErrorJS = require('./IOError.mjs');

import type {Json_t as Js_Json_t} from './Js.gen';

export type status = number;

export type t = 
    { NAME: "ValidationError"; VAL: string }
  | { NAME: "AppError"; VAL: string }
  | { NAME: "RequestError"; VAL: [status, Js_Json_t] }
  | { NAME: "NetworkError"; VAL: string };
export type IOError = t;

export type Utils_ioErrorHandlers = {
  readonly onAppError: (_1:string) => void; 
  readonly onValidationError: (_1:string) => void; 
  readonly onRequestError: (_1:string) => void; 
  readonly onNetworkError: (_1:string) => void
};

export const Utils_getMessage: (err:t) => string = IOErrorJS.Utils.getMessage as any;

export const Utils_handleIOError: (err:t, handlers:Utils_ioErrorHandlers) => void = IOErrorJS.Utils.handleIOError as any;

export const Utils: { getMessage: (err:t) => string; handleIOError: (err:t, handlers:Utils_ioErrorHandlers) => void } = IOErrorJS.Utils as any;
