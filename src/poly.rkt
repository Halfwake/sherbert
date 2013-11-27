#lang racket

(provide (struct-out posn)
         
         rect
         rect-sdl-rect
         
         left
         width
         right
         
         top
         height
         bottom
         
         half-width
         half-height
         
         center-x
         center-y
         center
         
         top-left
         top-right
         bottom-left
         bottom-right)

(require ffi/unsafe
         "sdl-core.rkt"
         (rename-in "sdl-structs.rkt"
                    [rect __rect]
                    [rect? _rect?]
                    [make-rect _make-rect]
                    [rect-x _rect-x]
                    [rect-y _rect-y]
                    [rect-w _rect-w]
                    [rect-h _rect-h]))

;Needs work
#;(define (fill-rect surface rect color)
    (_fill-rect surface rect color))

;will-executor maybe not needed?
;(define rect-collector (make-will-executor))

(struct posn (x y) #:transparent)

(struct rect (sdl-rect)
  #:constructor-name make-rect
  #:omit-define-syntaxes)

(define (rect x y w h)
  (make-rect (_make-rect x y w h)))

(define (left rect)
  (_rect-x (rect-sdl-rect rect)))

(define (width rect)
  (_rect-w (rect-sdl-rect rect)))

(define (right rect)
  (+ (left rect) (width rect)))


(define (top rect)
  (_rect-y (rect-sdl-rect rect)))

(define (height rect)
  (_rect-h (rect-sdl-rect rect)))

(define (bottom rect)
  (+ (top rect) (height rect)))


(define (half-width rect)
  (quotient (width rect) 2))

(define (half-height rect)
  (quotient (height rect) 2))


(define (center-x rect)
    (+ (left rect) (half-width rect)))

(define (center-y rect)
  (+ (top rect) (half-height rect)))

(define (center rect)
  (posn (center-x rect) (center-y rect)))


(define (top-left rect)
  (posn (left rect) (top rect)))

(define (top-right rect)
  (posn (right rect)(top rect)))

(define (bottom-left rect)
  (posn (left rect)(bottom rect)))

(define (bottom-right rect)
  (posn (right rect) (bottom rect)))
