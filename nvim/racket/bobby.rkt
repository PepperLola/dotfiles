#lang racket

;;
;; Given the definition below, write the step-by-step evaluation of
;; the expression that follows it.
;;
;; Be sure not to comment out the definition, not to comment out or delete
;; the original expression, show every intermediate evaluation step, and the
;; final result.  The steps MUST NOT be in comments.
;;
;; Stepping questions like this one have ONLY ONE CORRECT ANSWER.  The goal
;; of this problem is to assess whether you have learned the exact BSL step
;; by step evaluation rules; not whether you can figure out the final result
;; of an expression.
;;

(define (foo s i)
  (if (string=? (substring s 0 i) "a")
      (string-append s "a")
      s))

(foo (substring "abcde" 0 3) 1)
