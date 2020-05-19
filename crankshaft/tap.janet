
# https://testanything.org/tap-specification.html

(def tap-header "TAP version 13")

(def tests @[])

(defn test [name lambda]
  (array/push tests [name lambda]))

(defn run []
  (print tap-header)
  (var counter 1)
  (var fail-counter 0)
  (var plan-counter 0)
  (each t tests
    (let [[name lambda] t]
      (defn dispatch [k & args]
      (if (keyword? k)
        (match k
          :plan (set plan-counter (+ plan-counter (in args 0)))
          _ (error "Fall through"))
        (do
          (when-not (apply k args)
                    (...)))))
      (var fail? nil)
      (var errobj nil)
      (var fibobj nil)
      (try
        (do
          (lambda dispatch)
          (set fail? false))
        ((err fib)
         (set fail-counter (inc fail-counter))
         (set errobj err)
         (set fibobj fib)
         (set fail? true)))
      (if fail?
        (do
          (print (string "not ok " counter " # " errobj))
          (debug/stacktrace fibobj errobj))
        (print (string "ok " counter)))
      (set counter (inc counter))))
  (print "1.." counter)
  (when (> fail-counter 0)
    (error "Some tests failed")))
