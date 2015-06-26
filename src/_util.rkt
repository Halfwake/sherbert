#lang racket/base

(require racket/dict)

(provide flags->int
         int->flags
         sdl-success?)

(define (sdl-success? result)
  (zero? result))

(define (flags->int flags flag-table)
  (apply bitwise-ior
         (for/list ([flag flags])
           (dict-ref flag-table flag))))

(define (int->flags int flag-table)
  (for/list ([flag (dict-keys flag-table)]
             #:unless (zero? (bitwise-and int (dict-ref flag-table flag))))
    flag))
