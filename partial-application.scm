;;;; partial-application.scm - Partial procedure application in CHICKEN 5.

(module partial-application
    (part-eval part-apply part-map)
  (import scheme)
  (import (chicken base))

  (define (part-eval proc . binds)
    (lambda rest
      (apply proc (append binds rest))))

  (define (part-apply proc binds)
    (apply (part-eval part-eval proc) binds))

  (define-syntax part-map
    (syntax-rules ()
      ((part-map sexp lst ...)
       (map (part-apply (eval (car 'sexp))
                        (map eval (cdr 'sexp)))
            lst ...)))))
