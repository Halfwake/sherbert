#lang racket/base

(require "poly.rkt" 
         (submod "sdl-core.rkt" renderer/unsafe)
         (submod "sdl-core.rkt" renderer-draw/unsafe)
         (only-in "sdl-structs.rkt" make-color color-r color-g color-b color-a make-rect)
         "_util.rkt"
         racket/match)

(provide fill-rect!
         draw-rect!
         draw-line!
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
  (SDL_FillRect renderer rect))

(define (set-renderer-draw-color! renderer color)
  (sdl-success? (SDL_SetRenderDrawColor renderer
                                        (color-r color)
                                        (color-g color)
                                        (color-b color)
                                        (color-a color))))
(define (rect->sdl-rect rect)
  (match-define (posn x y) (rect-posn rect))
  (match-define (posn w h) (rect-size rect))
  (make-rect x y w h))

;; Outline or something.
#;(define (fill! renderer)
  (sdl-success? (SDL_FillRect renderer 0)))

(define (draw-rect! renderer rect)
  (sdl-success? (SDL_RenderDrawRect renderer
                                   (rect->sdl-rect rect))))
  

(define (draw-line! renderer posn1 posn2)
  (sdl-success? (SDL_RenderDrawLine renderer
                                    (posn-x posn1) (posn-y posn1)
                                    (posn-x posn2) (posn-y posn2))))

(define (fill-renderer! renderer)
  (sdl-success? (SDL_RenderClear renderer)))

(define (present-renderer! renderer)
  (SDL_RenderPresent renderer))