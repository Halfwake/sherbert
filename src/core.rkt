#lang racket/base

(require "_util.rkt"
         (submod "sdl-core.rkt" system/unsafe)
         (submod "sdl-core.rkt" window/unsafe)
         (submod "sdl-core.rkt" renderer/unsafe)
         "poly.rkt"
         racket/dict
         racket/set
         racket/list)

(provide set-window-title!
         with-window
         with-renderer
         with-window-and-renderer)

(module+ unsafe
  (provide init-systems!
           quit-systems!
           was-init
           make-window
           destroy-window))

(define system-flags 
  (hash 'timer #x00000001
        'audio #x00000010
        'video  #x00000020
        'cdrom  #x00000100
        'joystick  #x00000200
        'noparachute  #x00100000
        'eventthread  #x01000000
        'everything  #x0000FFFF))

(define (init-systems! [flags (dict-keys system-flags)])
  (let ((flag-int (flags->int flags)))
    (sdl-success? (if (was-init)
                      (SDL_InitSubSystem flag-int)
                      (SDL_Init flag-int)))))


(define (quit-systems! [flags '()])
  (if (null? flags)
      (SDL_Quit)
      (SDL_QuitSubSystem (flags->int flags)))
  #t)

(define (was-init [flags '()])
  (if (null? flags)
      (int->flags (SDL_WasInit 0) system-flags)
      (not (null? (int->flags (SDL_WasInit (flags->int flags)) system-flags)))))

(define (flag/c flags)
  (λ (values)
    (subset? values flags)))

(define (make-window title posn size flags)
  (SDL_CreateWindow title
                  (posn-x posn) (posn-y posn)
                  (posn-x size) (posn-y size)
                  (flags->int flags system-flags)))

(define (destroy-window window)
  (SDL_DestroyWindow window))

(define (with-window #:caption [caption "Racket SDL2"]
                     #:posn posn
                     #:size size
                     #:flags [flags empty]
                     callback)
  (define window null)
  (dynamic-wind
   (λ ()
     (set! window (make-window caption posn size flags)))
   (λ ()
     (callback window))
   (λ ()
     (destroy-window window))))

(define (set-window-title! window title)
  (SDL_SetWindowTitle window title))

(define renderer-flags
  (hash 'software #x00000001
        'accelerated #x00000010
        'present-vsync  #x00000020
        'target-texture #x00000100))

(define (make-renderer window index flags)
  (SDL_CreateRenderer window index (flags->int flags renderer-flags)))

(define (destroy-renderer renderer)
  (SDL_DestroyRenderer renderer))

(define (with-renderer #:window window
                       #:driver [driver -1]
                       #:flags [flags empty]
                       callback)
  (define renderer null)
  (dynamic-wind
   (λ ()
     (set! renderer (make-renderer window driver flags)))
   (λ ()
     (callback renderer))
   (λ ()
     (destroy-renderer renderer))))

(define (with-window-and-renderer #:caption [caption "Racket SDL2"]
                                  #:posn posn
                                  #:size size
                                  #:window-flags [window-flags empty]
                                  #:driver [driver -1]
                                  #:renderer-flags [renderer-flags empty]
                                  callback)
  (with-window
   #:caption caption
   #:posn posn
   #:size size
   #:flags window-flags
   (λ (window)
     (with-renderer
      #:window window
      #:driver driver
      #:flags renderer-flags
      (λ (renderer)
        (callback window renderer))))))
