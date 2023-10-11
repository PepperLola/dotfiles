#lang racket (require stepper/external-interface
                      stepper/private/marks
                      racket/list
                      racket/format)

(define (is-label? ml l)
  (string=? (~s (mark-label (first ml))) l))

(define ELS empty)
(define STR "")

(define (prints s)
  (set! STR (string-append STR s)))

(define (print-stx mark-list kind value-list)
  (when (and (not (string=? (~s kind) "result-exp-break")) (not (empty? ELS)) (string=? (last ELS) "normal-break"))
    (prints "},"))
  (if value-list
      (when (is-label? mark-list "called")
        ((lambda ()
           (define mark (first mark-list))
           (define source (mark-source mark))
           (prints (format "{\"kind\": \"result-value-break\",\"source\": \"~a\",\"value\": \"~a\",\"line\": ~a,\"column\": ~a, \"span\": ~a, \"position\": \"~a\"},"
                           (string-replace (~s (syntax->datum (mark-source mark))) "\"" "\\\"")
                           (first value-list)
                           (syntax-line source)
                           (syntax-column source)
                           (syntax-span source)
                           (syntax-position source)))
           (set! ELS (append ELS (list "result-value-break"))))))
      ((lambda ()
         (when (and (string=? (~s kind) "normal-break") (is-label? mark-list "not-yet-called"))
           ((lambda ()
              (define mark (first mark-list))
              (prints (format "{\"kind\": \"normal-break\",\"source\": \"~a\",\"line\": ~a,\"column\": ~a,\"span\": ~a"
                              (string-replace (~s (syntax->datum (mark-source mark))) "\"" "\\\"")
                              (syntax-line (mark-source mark))
                              (syntax-column (mark-source mark))
                              (syntax-span (mark-source mark))))
              (set! ELS (append ELS (list "normal-break"))))))
         (when (and (not (empty? ELS)) (string=? (last ELS) "normal-break") (string=? (~s kind) "result-exp-break"))
           ((lambda ()
              (prints (format ",\"becomes\": \"~a\",\"bindings\": "
                              (string-replace (~s (syntax->datum (mark-source (first mark-list)))) "\"" "\\\"")))
              (prints (format "{~a}}," (string-join (map (lambda (binding)
                                                           (format "\"~a\": \"~a\""
                                                                   (syntax-e (mark-binding-binding binding))
                                                                   (mark-binding-value binding)))
                                                         (mark-bindings (first mark-list))) ", ")))
              (set! ELS (append ELS (list "result-exp-break"))))))))))

(define (handler2 mark-list kind value-list)
  (when mark-list
    (print-stx mark-list kind value-list)))

;; the file interface:
#| (define-runtime-path bobby "./bobby.rkt") |#

#| (expand-and-print (path->stx file-path)) |#

#| (step-program-file bobby handler2) |#

(define (main args)
  (define file-path
    (if (>= (vector-length args) 0)
        (vector-ref args 0)
        #f))
  (prints "[")
  (when file-path
    (step-program-file file-path handler2))
  ; \"} because expr-finished-break is not completed
  ; since step-program-file always prints out result at the end
  (set! STR (substring STR 0 (- (string-length STR) 1)))
  (prints "]")
  (printf "--~a" STR))
(main (current-command-line-arguments))
