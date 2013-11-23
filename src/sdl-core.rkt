#lang racket

(require ffi/unsafe
         ffi/unsafe/define
         ffi/unsafe/alloc
         "sdl-structs.rkt")

(module sdl-core racket)
(provide (all-defined-out))

(define-ffi-definer define-sdl (ffi-lib "SDL2"))

(define-sdl _init
  (_fun _uint32 -> _int)
  #:c-id SDL_Init)

(define-sdl _init-sub-system
  (_fun _uint32 -> _int)
  #:c-id SDL_InitSubSystem)

(define-sdl _quit-sub-system
  (_fun _int32 -> _void)
  #:c-id SDL_QuitSubSystem)

(define-sdl _quit
  (_fun -> _void)
  #:c-id SDL_Quit)

(define-sdl _was-init
  (_fun _uint32 -> _int)
  #:c-id SDL_WasInit)

(define-sdl _get-error
  (_fun -> _string)
  #:c-id SDL_GetError)

(define-sdl _set-error
  (_fun _string -> _void)
  #:c-id SDL_SetError)

(define-sdl _error
  (_fun _error-code -> _void)
  #:c-id SDL_Error)

(define-sdl _load-object
  (_fun _string -> (_cpointer _void))
  #:c-id SDL_LoadObject)

(define-sdl _load-function
  (_fun _string -> (_cpointer _void))
  #:c-id SDL_LoadFunction)

(define-sdl _unload-object
  (_fun (_cpointer _void) -> _void)
  #:c-id SDL_UnloadObject)

;(define-sdl _sdl-version
;  (_fun -> _version)
;  #:c-id SDL_VERSION)

;(define-sdl _linked-sdl-version
;  (_fun -> _version)
;  #:c-id SDL_Linked_Version)

(define-sdl _rw-from-file
  (_fun _string -> _rw-ops)
  #:c-id SDL_RWFromFile)

(define-sdl _destroy-window
  (_fun (_cpointer _window) -> _void)
  #:c-id SDL_DestroyWindow)

(define-sdl _create-window
  (_fun _string _int _int _int _int _uint32 -> (_cpointer _window))
  #:c-id SDL_CreateWindow)

(define-sdl _fill-rect
  (_fun _surface _rect _uint32 -> _void)
  #:c-id SDL_FillRect)

(define-sdl _set-window-title
  (_fun (_cpointer _window) _string -> _void)
  #:c-id SDL_SetWindowTitle)

(define-sdl _render-draw-rects
  (_fun (_cpointer _renderer) (_cpointer _rect) _int -> _int)
  #:c-id SDL_RenderDrawRects)

(define-sdl _create-renderer
  (_fun (_cpointer _window) _int _uint32 -> (_cpointer _renderer))
  #:c-id SDL_CreateRenderer)

(define-sdl _destroy-renderer
  (_fun (_cpointer _renderer) -> _void)
  #:c-id SDL_DestroyRenderer)

(define-sdl _set-renderer-draw-color
  (_fun (_cpointer _renderer) _int _int _int _int -> _int)
  #:c-id SDL_SetRenderDrawColor)

(define-sdl _render-draw-line
  (_fun (_cpointer _renderer) _int _int _int _int -> _int)
  #:c-id SDL_RenderDrawLine)

(define-sdl _render-clear
  (_fun (_cpointer _renderer) -> _int)
  #:c-id SDL_RenderClear)

(define-sdl _render-present
  (_fun (_cpointer _renderer) -> _void)
  #:c-id SDL_RenderPresent)

