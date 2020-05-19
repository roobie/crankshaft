(defn fail
  [message]
  (assert false message))

(defn assert=
  [expected actual &opt message]
  (default message "")
  (when (not (= expected actual))
    (fail (string/format `assert= failed - %s
  expected: %q
  actual:   %q
` message expected actual))))

(defn assert-deep=
  [expected actual &opt message]
  (default message "")
  (when (not (deep= expected actual))
    (fail (string/format `assert-deep= failed - %s
  expected: %q
  actual:   %q
` message expected actual))))

(defn assert-error
  [lambda &opt message error-matcher]
  (default message "")
  (default error-matcher (fn [&] false))
  (var e nil)
  (try
    (lambda)
    ((err fib)
     (set e err)))
  (when (and (nil? e) (not (error-matcher e)))
      (fail (string/format `assert-error failed - %s
  expected function to signal an error.` message))))
