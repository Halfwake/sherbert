#lang racket

(require ffi/unsafe
         ffi/unsafe/define
         ffi/unsafe/alloc
         "sdl-structs.rkt")

(define-ffi-definer define-sdl (ffi-lib "SDL2"))

(module+ system/unsafe
  (provide (all-defined-out))
  
  (define-sdl SDL_Init
    (_fun _uint32 -> _int))
  
  (define-sdl SDL_InitSubSystem
    (_fun _uint32 -> _int))
  
  (define-sdl SDL_QuitSubSystem
    (_fun _int32 -> _void))
  
  (define-sdl SDL_Quit
    (_fun -> _void))

  (define-sdl SDL_WasInit
    (_fun _uint32 -> _int)))

(module+ error/unsafe
  (provide (all-defined-out))
  
  (define-sdl SDL_GetError
    (_fun -> _string))
  
  (define-sdl SDL_SetError
    (_fun _string -> _void))
  
  (define-sdl SDL_Error
    (_fun _error-code -> _void)))

(module+ load/unsafe
  (provide (all-defined-out))
  
  (define-sdl SDL_LoadObject
    (_fun _string -> (_cpointer _void)))
  
  (define-sdl SDL_LoadFunction
    (_fun _string -> (_cpointer _void)))
  
  (define-sdl SDL_UnloadObject
    (_fun (_cpointer _void) -> _void)))

;(define-sdl _sdl-version
;  (_fun -> _version)
;  #:c-id SDL_VERSION)

;(define-sdl _linked-sdl-version
;  (_fun -> _version)
;  #:c-id SDL_Linked_Version)

(define-sdl SDL_RWFromFile
  (_fun _string -> _rw-ops))

(module+ window/unsafe
  (provide (all-defined-out))
  
  (define-sdl SDL_CreateWindow
    (_fun _string _int _int _int _int _uint32 -> (_cpointer _window)))
  
  (define-sdl SDL_DestroyWindow
    (_fun (_cpointer _window) -> _void))
  
  (define-sdl SDL_SetWindowTitle
    (_fun (_cpointer _window) _string -> _void)))

(module+ renderer/unsafe
  (provide (all-defined-out))
  
  (define-sdl SDL_CreateRenderer
    (_fun (_cpointer _window) _int _uint32 -> (_cpointer _renderer)))
  
  (define-sdl SDL_DestroyRenderer
    (_fun (_cpointer _renderer) -> _void))
  
  (define-sdl SDL_SetRenderDrawColor
    (_fun (_cpointer _renderer) _int _int _int _int -> _int))
  
  (define-sdl SDL_RenderClear
    (_fun (_cpointer _renderer) -> _int))
  
  (define-sdl SDL_RenderPresent
    (_fun (_cpointer _renderer) -> _void)))

(module+ renderer-draw/unsafe
  (provide (all-defined-out))
  
  (define-sdl SDL_FillRect
    (_fun _surface _rect _uint32 -> _void))
  
  (define-sdl SDL_RenderDrawRects
    (_fun (_cpointer _renderer) (_cpointer _rect) _int -> _int))
  
  (define-sdl SDL_RenderDrawLine
    (_fun (_cpointer _renderer) _int _int _int _int -> _int))
  
  (define-sdl SDL_RenderDrawRect
    (_fun (_cpointer _renderer) (_ptr i _rect) -> _int)))

(module+ event/unsafe
  (provide (all-defined-out))
  
  (define-sdl SDL_WaitEvent
    (_fun (_cpointer _event) -> _int))
  
  (define-sdl SDL_PeepEvents
    (_fun (_cpointer _event) _int _int _uint32 _uint32 -> _int))
  
  (define-sdl SDL_PollEvent
    (_fun (_cpointer _event) -> _int)))
