/* TypeScript file generated from TaskResult.res by genType. */

/* eslint-disable */
/* tslint:disable */

const TaskResultJS = require('./TaskResult.mjs');

import type {t as Task_t} from './Task.gen';

export type T_t<a> = { TAG: "Task"; _0: () => Promise<a> };

export type t<a,e> = Task_t<
    { TAG: "Ok"; _0: a }
  | { TAG: "Error"; _0: e }>;

export const T_fromIO: <a>(_1:(() => a)) => T_t<a> = TaskResultJS.T.fromIO as any;

export const T_fromPromise: <a>(_1:(() => Promise<a>)) => T_t<a> = TaskResultJS.T.fromPromise as any;

export const T_run: <a>(_1:T_t<a>) => Promise<a> = TaskResultJS.T.run as any;

export const T_map: <a,b>(_1:T_t<a>, _2:((_1:a) => b)) => T_t<b> = TaskResultJS.T.map as any;

export const T_chain: <a,b>(_1:T_t<a>, _2:((_1:a) => T_t<b>)) => T_t<b> = TaskResultJS.T.chain as any;

export const T_chainFirst: <a>(_1:T_t<a>, _2:((_1:a) => T_t<void>)) => T_t<a> = TaskResultJS.T.chainFirst as any;

export const T: {
  map: <a,b>(_1:T_t<a>, _2:((_1:a) => b)) => T_t<b>; 
  chainFirst: <a>(_1:T_t<a>, _2:((_1:a) => T_t<void>)) => T_t<a>; 
  run: <a>(_1:T_t<a>) => Promise<a>; 
  fromIO: <a>(_1:(() => a)) => T_t<a>; 
  fromPromise: <a>(_1:(() => Promise<a>)) => T_t<a>; 
  chain: <a,b>(_1:T_t<a>, _2:((_1:a) => T_t<b>)) => T_t<b>
} = TaskResultJS.T as any;
