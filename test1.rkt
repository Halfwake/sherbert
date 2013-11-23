#lang racket

(require "src/core.rkt"
         "src/poly.rkt"
         "src/draw.rkt")

#;(with-window win "Draw Test #1" (posn 500 500) (posn 800 600) 0
             (define renderer (make-renderer win -1 0))
             (set-renderer-draw-color! renderer (make-color 255 128 0 0))
             (fill-renderer! renderer)
             (present-renderer! renderer)
             (sleep 4)
             (destroy-renderer renderer))

(define (alternate-colors renderer delay-amount colors max-time)
  (define (alternate-colors-iter index time)
    (cond [(= index (length colors))
           (alternate-colors-iter 0 time)]
          [(< time max-time)
           (set-renderer-draw-color! renderer (list-ref colors index))
           (fill-renderer! renderer)
           (present-renderer! renderer)
           (sleep delay-amount)
           (alternate-colors-iter (add1 index) (+ time delay-amount))]
          [else
           null]))
  (alternate-colors-iter 0 0))

(with-window win "Draw Test #1" (posn 500 500) (posn 800 600) 0
             (define renderer (make-renderer win -1 0))
             (alternate-colors renderer 0.5 (list (make-color 255 127 0 0) (make-color 127 255 0 0)) 10)
             (destroy-renderer renderer))

#;(with-window win "Here we go..." (posn 500 500) (posn 800 600) 0
             (sleep 2)
             (set-window-title! win "...and here we go...")
             (sleep 2)
             (set-window-title! win "...and one last time!")
             (sleep 2))

#;(begin
  (define time-machine null)
  (with-window win "Here we go..." (posn 500 500) (posn 800 600) 0
               (sleep 2)
               (set-window-title! win "...and here we go...")
               (call/cc (lambda (k) (set! time-machine k)))
               (sleep 2)
               (set-window-title! win "...and one last time!")
               (sleep 2))
  (time-machine))

;; opengl example
#;(begin
  (require
   sgl
   sgl/gl-vectors)
  (with-window win "Here we go..." (posn 500 500) (posn 800 600) 0
               (gl-begin 'triangles)
               (gl-vertex 1 2 3)
               (gl-vertex-v (gl-float-vector 1 2 3 4))
               (gl-end)
               (sleep 5)))
