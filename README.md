# crankshaft
Assertion library for janet

## API

`(assert= expected actual &opt message)`

Asserts that expected is equal (`=`) to actual.

-----

`(assert-deep= expected actual &opt message)`

Asserts that expected is deeply equal (`deep=`) to actual.

-----

`(assert-error lambda &opt message error-matcher)`

Asserts that `lambda` signals an error. `error-matcher` is an optional `fn` that consumes the signalled `error` to test if it is the "correct" error.

## Example

```janet
(import crankshaft :as cs)

(var counter 0)

# some ref types
(def a @[])
(def b @[])
(def c @[1])

(cs/assert= 0 0)
(cs/assert= a a)

(try
  (cs/assert= 1 0)
  ((e f) (set counter (inc counter))))
(cs/assert= 1 counter)

(try
  (cs/assert= a b)
  ((e f) (set counter (inc counter))))
(cs/assert= 2 counter)

(cs/assert-deep= a a)
(cs/assert-deep= a b)

(try
  (cs/assert-deep= c b)
  ((e f) (set counter (inc counter))))
(cs/assert= 3 counter)

(cs/assert-error (fn [] (error "A")))
(try
  (cs/assert-error (fn [] :ok) "OMG")
  ((e f) (set counter (inc counter))))
(cs/assert= 4 counter)
```
