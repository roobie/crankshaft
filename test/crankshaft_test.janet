(import ../crankshaft :as cs)

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

