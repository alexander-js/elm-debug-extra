# Debug.Extra

This is a package with a handful of utility functions for debugging and measuring the performance of your Elm application.
Elm's `Debug` module exposes no builtin way to e.g create a performance timeline.

The current functions are as follows:

```elm
Debug.Extra.time : String -> a -> a
```
> Start a performance timeline. This is just calling `console.time`.

```elm
Debug.Extra.timeEnd : String -> a -> a
```
> End a performance timeline. This is just calling `console.timeEnd`.

```elm
Debug.Extra.performanceMark : String -> a -> a
```
> Create a performance mark. This is just calling `performance.mark`.

```elm
Debug.Extra.debugger : a -> a
```
> Start the DevTools [debugger](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/debugger). Might be interesting if you'd like to inspect the runtime details of Elm at a given point.

```elm
Debug.Extra.block : Float -> a -> a
```
> Block the current thread for a given time.
> Note! This is just a CPU-hogging loop. Given a long enough duration, your browser might hang up.

## Necessary JavaScript

The aforementioned API calls JavaScript synchronously. This is done with a  [small hack](src/Hack.js). Include this file anywhere in your application for the functions to have any effect.

## Trying this out

Clone the repository and run `make demo`.