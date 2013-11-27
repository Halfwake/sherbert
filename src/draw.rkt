#lang racket

(require "poly.rkt" 
         "sdl-core.rkt"
         (only-in "sdl-structs.rkt" make-color color-r color-g color-b color-a)
         "sdl-draw.rkt"
         "_util.rkt"
         ffi/unsafe)

(provide fill-rect!
         draw-rect!
         fill-renderer!
         set-renderer-draw-color!
         present-renderer!
         color
         color-r
         color-g
         color-b
         color-a)

(define color make-color)

(define (fill-rect! renderer rect)
  (_fill-rect renderer rect))

(define (set-renderer-draw-color! renderer color)
  (sdl-success? (_set-renderer-draw-color renderer
                                          (color-r color)
                                          (color-g color)
                                          (color-b color)
                                          (color-a color))))

;; Outline or something.
#;(define (fill! renderer)
  (sdl-success? (_fill-rect renderer 0)))

(define (draw-rect! renderer rect)
  (sdl-success? (_render-draw-rect renderer
                                   (rect-sdl-rect rect))))
  

(define (draw-line! posn1 posn2)
  (sdl-success? (_render-draw-line (posn-x posn1)
                          (posn-y posn1)
                          (posn-x posn2)
                          (posn-y posn2))))

(define (fill-renderer! renderer)
  (sdl-success? (_render-clear renderer)))

(define (present-renderer! renderer)
  (_render-present renderer))