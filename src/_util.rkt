#lang racket

(provide flags->int
         int->flags
         sdl-success?)

(define (sdl-success? result)
  (= 0 result))

(define (flags->int flags)
  (apply bitwise-ior (map eval flags)))

(define (int->flags int flags)
  (if (null? flags)
      '()
      (if (< 0 (bitwise-and int (eval (car flags))))
          (cons (car flags) (int->flags int (cdr flags)))
          (int->flags int (cdr flags)))))
