;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; R7RS 6.2 - Numbers
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define-syntax assert-equal!
  (syntax-rules ()
    [(_ expected actual)
     (let ([ok (equal? expected actual)])
       (when (not ok)
         (displayln "Expected value " expected " but got " actual ".")
         (assert! ok)))]))

;; ;; Number types
(assert! (not (equal? 10 10.0)))
(assert! (integer? 1))
(assert! (exact-integer? 1))
(assert! (integer? 1.0))
(assert! (not (exact-integer? 1.0)))
(assert! (not (integer? 1.2)))
(assert! (not (exact-integer? 1.2)))
(assert! (not (integer? +inf.0)))
(assert! (not (exact-integer? +inf.0)))
(assert! (rational? 1))
(assert! (rational? 1/4))
(assert! (rational? 1.2))
(assert! (not (rational? -inf.0)))
(assert! (not (rational? -nan.0)))
(assert! (number? 1))
(assert! (number? 1/4))
(assert! (number? 1.2))
(assert! (number? +inf.0))
(assert! (number? +nan.0))
(assert! (real? 1))
(assert! (real? 1/4))
(assert! (real? 1.2))
(assert! (real? +inf.0))
(assert! (real? -nan.0))
(assert! (not (float? 1/3)))
(assert! (float? 0.3))
(assert! (not (real? 1+2i)))
(assert! (not (real? +2i)))
(assert! (not (real? 1.0+2.0i)))
(assert! (not (real? +2.0i)))
(assert! (not (real? 1.0+2i)))

;; Other predicates
(assert! (zero? 0.0))
(assert! (zero? 0))
(assert! (zero? 0+0i))
(assert! (not (zero? 0.001)))
(assert! (not (zero? -0.001)))
(assert! (not (zero? 1)))
(assert! (not (zero? -1)))
(assert! (not (negative? 0)))
(assert! (negative? -1))
(assert! (negative? -1/2))
(assert! (negative? -0.5))
(assert! (not (negative? 1)))
(assert! (not (negative? 1/2)))
(assert! (not (negative? 0.5)))
(assert! (not (positive? 0)))
(assert! (positive? 1))
(assert! (positive? 1/2))
(assert! (positive? 0.5))
(assert! (not (positive? -1)))
(assert! (not (positive? -1/2)))
(assert! (not (positive? -0.5)))
(assert! (nan? +nan.0))
(assert! (not (nan? 1.0)))
(assert! (not (nan? -1.0)))
(assert! (not (nan? 1)))
(assert! (not (nan? -1)))

;; Addition
(assert-equal! 10 (+ 1 2 3 4))
(assert-equal! 10.0 (+ 1 2 3.0 4))
(assert-equal! 7/12 (+ 1/4 1/3))
(assert-equal! 120.0 (+ 1e2 2e1))
;; Float + Rational is promoted to Float.
(assert-equal! (/ 7.0 12.0) (+ 0.25 1/3))
(assert-equal! 9223372036854775808 (+ 9223372036854775808))
(assert-equal! 18446744073709551616 (+ 9223372036854775808 9223372036854775808))
(assert-equal! 27670116110564327424 (+ 9223372036854775808 9223372036854775808 9223372036854775808))
;; Promotion from int -> bignum, one over int max
(assert-equal! 9223372036854775808 (+ 1 9223372036854775807))
(assert-equal! 20000000000000000000000009/60000000000000 (+ 1000000000000/3 15/100000000000000))
(assert-equal! 4+6i (+ 1+2i 3+4i))
(assert-equal! 4.0+6.0i (+ 1.0+2.0i 3+4i))

;; Subtraction
(assert-equal! -10 (- 10))
(assert-equal! -10.0 (- 10.0))
(assert-equal! -8 (- 1 2 3 4))
(assert-equal! -8.0 (- 1 2.0 3 4))
(assert-equal! 1 (- -1))
(assert-equal! -1/4 (- 1/4))
(assert-equal! 9223372036854775808 (- -9223372036854775808))
(assert-equal! 9999980000000000000 (- 10000000000000000000 20000000000000))
(assert-equal! -1e10-2e10i (- 1e10+2e10i))
(assert-equal! -2-2i (- 1+2i 3+4i))

;; Multiplication
(assert-equal! 10 (* 2 5))
(assert-equal! 10.0 (* 2.0 5.0))
(assert-equal! 10.0 (* 100.0 0.1))
(assert-equal! 1/4 (* 1/8 2))
;; Promotion from int -> bignum, with multiplication
(assert-equal! 18446744073709551614 (* 2 9223372036854775807))
(assert-equal! 85070591730234615856620279821087277056 (* 9223372036854775807 9223372036854775808))
(assert-equal! -5+10i (* 1+2i 3+4i))

;; Division
(assert-equal! 0.25 (/ 4.0))
(assert-equal! 1 (/ 1))
(assert-equal! 0.25 (/ 1 4.0))
(assert-equal! 0.04 (/ 2.0 5 10))
(assert-equal! 1/4 (/ 4))
(assert-equal! 2 (/ 22222222222222222222 11111111111111111111))
(assert-equal! 1/2 (/ 11111111111111111111 22222222222222222222))
(assert-equal! 1/2 (/ 11111111111111111111 22222222222222222222))
(assert-equal! 1/5-1/5i (/ 1+2i))

;; Comparisons
(assert! (< -10 9223372036854775808))
(assert! (< -10.1 9223372036854775808))
(assert! (< 9223372036854775808 9993372036854775808))

(assert! (exact? 3))
(assert! (exact? 3/10))
(assert! (exact? 100000000000000000000000000))
(assert! (exact? 100000000000000000000000000/3))
(assert! (not (exact? 3.5)))
(assert! (exact? 3+1i))
(assert! (not (exact? 3.0+1i)))

(assert! (not (inexact? 3)))
(assert! (not (inexact? 3/10)))
(assert! (not (inexact? 100000000000000000000000000)))
(assert! (not (inexact? 100000000000000000000000000/3)))
(assert! (inexact? 3.5))
(assert! (not (inexact? 3+1i)))
(assert! (inexact? 3.0+1i))

(assert-equal! 0.5 (exact->inexact 1/2))
(assert-equal! 0.5 (exact->inexact 0.5))

(assert-equal! 1/2 (inexact->exact 0.5))
(assert-equal! 1/2 (inexact->exact 1/2))
(assert-equal! 2 (inexact->exact 2))

(assert! (finite? 1))
(assert! (finite? 1.0))
(assert! (finite? 1/2))
(assert! (not (finite? +nan.0)))
(assert! (not (finite? +inf.0)))
(assert! (not (finite? -inf.0)))

(assert! (not (infinite? 1)))
(assert! (not (infinite? 1.0)))
(assert! (not (infinite? 1/2)))
(assert! (not (finite? +nan.0)))
(assert! (infinite? +inf.0))
(assert! (infinite? -inf.0))

(assert-equal! 10 (abs -10))
(assert-equal! 10 (magnitude -10))
(assert-equal! 10/3 (abs -10/3))
(assert-equal! 10/3 (magnitude -10/3))
(assert-equal! 10.0 (abs -10.0))
(assert-equal! 10.0 (magnitude -10.0))
(assert-equal! 5 (magnitude -3+4i))

(assert-equal! 3 (real-part 3+4i))
(assert-equal! 42 (real-part 42))
(assert-equal! 4 (imag-part 3+4i))
(assert-equal! 0 (imag-part 42))

(assert-equal! 10.0 (ceiling 9.1))
(assert-equal! 9.0 (floor 9.1))
(assert-equal! 10.0 (ceiling 10.0))
(assert-equal! 10.0 (floor 10.0))
(assert-equal! 10 (ceiling 10))
(assert-equal! 10 (floor 10))
(assert-equal! -9.0 (ceiling -9.1))
(assert-equal! -10.0 (floor -9.1))
(assert-equal! 1 (ceiling 1/2))
(assert-equal! 0 (floor 1/2))
(assert-equal! 0 (ceiling -1/2))
(assert-equal! -1 (floor -1/2))

(assert-equal! 3 (numerator 3))
(assert-equal! 3 (numerator 3/2))
(assert-equal! 1 (denominator 3))
(assert-equal! 2 (denominator 3/2))

(assert-equal! 4 (expt 2 2))
(assert-equal! 4.0 (expt 2.0 2.0))
(assert-equal! 1/4 (expt 1/2 2))
(assert-equal! 0.25 (expt 1/2 2.0))
(assert-equal! 2.0 (expt 4 1/2))
(assert-equal! 2.0 (expt 4 0.5))

(assert-equal! 1 (exp 0))

(assert-equal! 3 (round 3))
(assert-equal! 1 (round 4/3))
(assert-equal! 2 (round 5/3))
(assert-equal! 2.0 (round 2.1))
(assert-equal! 3.0 (round 2.6))
(assert-equal! 9223372036854775808 (round 9223372036854775808))

(assert-equal! 4 (square 2))
(assert-equal! 2 (sqrt 4))
(assert-equal! 4.0 (square 2.0))
(assert-equal! 2.0 (sqrt 4.0))
(assert-equal! 1/4 (square 1/2))
(assert-equal! 1/2 (sqrt 1/4))
(assert-equal! -7+24i (square -3-4i))
(assert-equal! -3-4i (square 1-2i))
(assert-equal! 1-2i (sqrt -3-4i))
(assert-equal! -3+4i (square 1+2i))
(assert-equal! 1+2i (sqrt -3+4i))

(assert-equal! 0 (log 1 100))
(assert-equal! 2 (log 100 10))
(assert-equal! 2.0 (log 100.0 10.0))
(assert-equal! 2.0 (log 100.0 10))
(assert-equal! 2.0 (log 100 10.0))
(assert-equal! 1.0 (log (exp 1)))

(assert-equal! '(0 0) (exact-integer-sqrt 0))
(assert-equal! '(1 0) (exact-integer-sqrt 1))
(assert-equal! '(1 1) (exact-integer-sqrt 2))
(assert-equal! '(1 2) (exact-integer-sqrt 3))
(assert-equal! '(2 0) (exact-integer-sqrt 4))
(assert-equal! '(2 1) (exact-integer-sqrt 5))
(assert-equal! '(10000000000000000000000 4)
               (exact-integer-sqrt 100000000000000000000000000000000000000000004))

(assert-equal! 255 (string->number "ff" 16))
(assert-equal! 1+2i (string->number "1+10i" 2))
(assert-equal! 1/8 (string->number "1/10" 8))
