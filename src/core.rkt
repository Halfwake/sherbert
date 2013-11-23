#lang racket

(require ffi/unsafe
         "_util.rkt"
         "sdl-core.rkt"
         "poly.rkt"
         (for-syntax
          racket/match
          racket/list))

(provide init-systems!
         quit-systems!
         was-init
         set-window-title!
         with-window
         make-window
         destroy-window
         
         make-renderer ;TODO
         destroy-renderer ;TODO
         
         
         INIT-FLAGS)

(define INIT-TIMER          #x00000001)
(define INIT-AUDIO          #x00000010)
(define INIT-VIDEO          #x00000020)
(define INIT-CDROM          #x00000100)
(define INIT-JOYSTICK       #x00000200)
(define INIT-NOPARACHUTE    #x00100000)
(define INIT-EVENTTHREAD    #x01000000)
(define INIT-EVERYTHING     #x0000FFFF)
(define INIT-FLAGS '(INIT-TIMER
                     INIT-AUDIO
                     INIT-VIDEO
                     INIT-CDROM
                     INIT-JOYSTICK
                     INIT-NOPARACHUTE
                     ;INIT-EVENTTHREAD ;Threading is handled by racket.
                     ;INIT-EVERYTHING ;INIT-FLAGS acts as an INIT-EVERYTHING, but as an s-expresion rather than an int
                     ))

(define (init-systems! [flags INIT-FLAGS])
  (let ((flag-int (flags->int flags)))
    (= 0 (if (not (=  0 (_was-init 0)))
             (_init flag-int)
             (_init-sub-system flag-int)))))


(define (quit-systems! [flags '()])
  (if (null? flags)
      (_quit)
      (_quit-sub-system (flags->int flags)))
  #t)

(define (was-init [flags '()])
  (if (null? flags)
      (int->flags (_was-init 0) INIT-FLAGS)
      (not (null? (int->flags (_was-init (flags->int flags)) INIT-FLAGS)))))

(define (make-window title x y w h flags)
  (_create-window title x y w h flags))

(define (destroy-window window)
  (_destroy-window window))

(define-syntax (with-window stx)
  (match (syntax->datum stx)
    [(list _ window-identifier window-caption window-position window-size window-flags body ...)
     (datum->syntax
      stx
      `(let ((,window-identifier null))
         (dynamic-wind
          (lambda ()
            (set! ,window-identifier (apply make-window (list ,window-caption (posn-x ,window-position) (posn-y ,window-position) (posn-x ,window-size) (posn-y ,window-size) ,window-flags))))
          (lambda ()
            ,@body)
          (lambda ()
            (destroy-window ,window-identifier)))))]))

(define (set-window-title! window title)
  (_set-window-title window title))

(define (make-renderer window index flags)
  (_create-renderer window index flags))

(define (destroy-renderer renderer)
  (_destroy-renderer renderer))

;(define (sdl-version)
;  (_sdl-version))
