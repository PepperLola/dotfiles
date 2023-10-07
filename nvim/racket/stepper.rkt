#lang racket

(require stepper/external-interface
         stepper/private/marks)

(define (is-label? ml l)
  (string=? (~s (mark-label (first ml))) l))

(define (print-stx mark-list kind value-list)
  (if (and (string=? (~s kind) "normal-break") (is-label? mark-list "not-yet-called"))
      (printf "~a -> " (syntax->datum (mark-source (first mark-list))))
      (if value-list
          (if (is-label? mark-list "called")
              (printf "~a\n" (first value-list))
              (printf ""))
          (if (string=? (~s kind) "result-exp-break")
              (printf "Becomes: ~a" (syntax->datum (mark-source (first mark-list))))
              (printf "")))))

(define (handler2 mark-list kind value-list)
  (when mark-list
    (print-stx mark-list kind value-list)))

;; the file interface:
#| (define-runtime-path bobby "./bobby.rkt") |#

#| (expand-and-print (path->stx bobby)) |#

#| (step-program-file bobby handler2) |#

(define (main args)
  (define file-path
    (if (>= (vector-length args) 0)
        (vector-ref args 0)
        #f))
  (if file-path
      (step-program-file file-path handler2)
      (printf "Need a file path! Only provided arguments were: ~a" args)))

(main (current-command-line-arguments))
