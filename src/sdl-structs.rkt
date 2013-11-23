#lang racket

(require ffi/unsafe)

(module sdl-structs racket)
(provide (all-defined-out))

(define _blend-mode _int)
(define _renderer-flip _int)
(define _renderer-info _int)

(define _void-pointer (_cpointer _void))

(define-cstruct _error-code ([error _int]
                             [key _string]
                             [argc _int]
                             [args (_union _void-pointer _byte _int _double _string)]))

(define-cstruct _version
  ([major _uint8]
   [minor _uint8]
   [patch _uint8]))

(define-cstruct _rect
  ([x _int]
   [y _int]
   [w _int]
   [h _int]))

(define-cstruct _color
  ([r _uint8]
   [g _uint8]
   [b _uint8]
   [a _uint8]))

(define-cstruct _palette
  ([n-colors _int]
   [colors (_cpointer _color)]
   [version _uint32]
   [ref-count _int]))

(define-cstruct _pixel-format
  ([palette _palette]
   [bits-per-pixel _uint8]
   [bytes-per-pixel _uint8]
   [r-loss _uint8]
   [g-loss _uint8]
   [b-loss _uint8]
   [a-loss _uint8]
   [r-shift _uint8]
   [g-shift _uint8]
   [b-shift _uint8]
   [a-shift _uint8]
   [r-mask _uint32]
   [g-mask _uint32]
   [b-mask _uint32]
   [a-mask _uint32]
   [color-key _uint32]
   [alpha _uint8]))

(define-cstruct _blit-info
  ([r _uint8]
   [g _uint8]
   [b _uint8]
   [a _uint8]
   [colorkey _uint32]
   [dst (_cpointer _uint8)]
   [dst_fmt (_cpointer _pixel-format)]
   [dst_w _int]
   [dst_h _int]
   [dst_pitch _int]
   [dst_skip _int]
   [flags _int]
   [src (_cpointer _int8)]
   [src_fmt (_cpointer _pixel-format)]
   [src_pitch _int]
   [src_skip  _int]
   [src_w _int]
   [src_h _int]
   [table (_cpointer _uint8)]))

(define-cstruct _blit-map
  ([blit _void-pointer]; SDL_blit
   [data _void-pointer]
   [dst _void-pointer] ;_surface
   [dst_palette_version _uint32]
   [identity _int]
   [info _blit-info]
   [src_palette_version _uint32]))
   

(define-cstruct _surface
  ([clip_rect _rect]
   [flags _uint32]
   [format (_cpointer _pixel-format)]
   [w _int]
   [h _int]
   [lock_data _void-pointer]
   [locked _int]
   [map _blit-map]
   [pitch _int]
   [pixels _void-pointer]
   [refcount _int]
   [userdata _void-pointer]))
   
   

(define-cstruct _window-user-data
  ([data _void-pointer]
   [name _string]
   [next _void-pointer]))

(define-cstruct _display-mode
  ([driverdata _void-pointer]
   [format _uint32]
   [w _int]
   [h _int]
   [refresh_rate _int]))

;(define _bool _int)

(define-cstruct _window-shaper1
  ([driverdata _void-pointer]
   [hasshape _bool]
   [mode _void-pointer] ;_window-shape-mode
   [userx _uint32]
   [usery _uint32]
   [window _void-pointer])) ;; _window

(define-cstruct _window
  ([brightness _float]
   [data (_cpointer _window-user-data)]
   [driverdata _void-pointer]
   [flags _uint32]
   [fullscreen_mode _display-mode]
   [gamma (_cpointer _uint16)]
   [icon (_cpointer _surface)];
   [id _uint32]
   [magic _void-pointer]
   [min_w _int]
   [min_h _int]
   [max_w _int]
   [max_h _int]
   [prev _void-pointer] ;; _window
   [next _void-pointer] ;; _window
   [saved-gamma (_cpointer _uint16)]
   [shaper (_cpointer _window-shaper1)];
   [surface (_cpointer _surface)]
   [surface_valid _bool]
   [title _string]
   [windowed _rect]
   [x _int]
   [y _int]
   [w _int]
   [h _int]))

(define-cstruct _window-event
  ([type _uint32]
   [timestamp _uint32]
   [windowID _uint32]
   [event _uint8]
   [padding1 _uint8]
   [padding2 _uint8]
   [padding3 _uint8]
   [data1 _sint32]
   [data2 _sint32]))

(define-cstruct _sw-yuv-texture
  ([format _uint32]
   [target_format _uint32]
   [w _int]
   [h _int]
   [pixels (_cpointer _uint8)]
   [colortab (_cpointer _uint8)]
   [rgb_2_pix (_cpointer _uint32)]
   [Display1X (_fun _pointer
                    (_cpointer _int)
                    (_cpointer _uint32)
                    (_cpointer _ubyte)
                    (_cpointer _ubyte)
                    (_cpointer _ubyte)
                    (_cpointer _ubyte)
                    _int
                    _int
                    _int -> _void)]
   [Display2X (_fun _pointer
                    (_cpointer _int)
                    (_cpointer _uint32)
                    (_cpointer _ubyte)
                    (_cpointer _ubyte)
                    (_cpointer _ubyte)
                    (_cpointer _ubyte)
                    _int
                    _int
                    _int -> _void)]
   [pitches (_cpointer _uint16)]
   [planes (_cpointer (_cpointer _uint8))]
   (stretch (_cpointer _surface))
   (display (_cpointer _surface))))
   

(define-cstruct _texture
  ([magic _void-pointer]
   [format _uint32]
   [access _int]
   [w _int]
   [h _int]
   [modMode _int]
   [blendMode _blend-mode]
   [r _uint8]
   [g _uint8]
   [b _uint8]
   [a _uint8]
   [renderer _void-pointer]
   [native _void-pointer]
   [yuv (_cpointer _sw-yuv-texture)] ;SDL_SW_YUVTexture *yuv;
   [pixels _void-pointer]
   [pitch _int]
   [locked_rect _rect]
   [driverdata _void-pointer]
   [prev _void-pointer]
   [next _void-pointer]))

(define-cstruct _fpoint
  ([x _float]
   [y _float]))

(define-cstruct _frect
  ([x _float]
   [y _float]
   [w _float]
   [h _float]))

(define-cstruct _renderer
  ([magic _void-pointer]
   [WindowEvent (_fun _pointer (_cpointer _void) (_cpointer _window-event) -> _void)]
   [GetOutputSize (_fun _pointer (_cpointer _void) _int _int -> _int)]
   
   [CreateTexture (_fun _pointer (_cpointer _void) (_cpointer _texture) -> _int)]
   [SetTextureColorMode (_fun _pointer (_cpointer _void) (_cpointer _texture) -> _int)]
   [SetTextureAlphaMode (_fun _pointer (_cpointer _void) (_cpointer _texture) -> _int)]
   [SetTextureBlendMode (_fun _pointer (_cpointer _void) (_cpointer _texture) -> _int)]
   
   [UpdateTexture (_fun _pointer (_cpointer _void) (_cpointer _texture) (_cpointer _rect) _void-pointer -> _int)]
   [UpdateTextureYUV (_fun _pointer
                           (_cpointer _void)
                           (_cpointer _texture)
                           (_cpointer _rect)
                           (_cpointer _uint8)
                           _int
                           (_cpointer _uint8)
                           _int
                           (_cpointer _uint8)
                           _int
                           ->
                           _int)]
   [LockTexture (_fun _pointer (_cpointer _void) (_cpointer _texture) (_cpointer _rect) (_cpointer _void-pointer) (_cpointer _int) -> _int)]
   [UnlockTexture (_fun _pointer (_cpointer _void) (_cpointer _texture) -> _void)]
   [SetRenderTarget (_fun _pointer (_cpointer _void) (_cpointer _texture) -> _int)]
   [UpdateViewport (_fun _pointer (_cpointer _void) -> _int)]
   [RenderClear (_fun _pointer (_cpointer _void) -> _int)]
   [RenderDrawPoints (_fun _pointer (_cpointer _void) (_cpointer _fpoint) _int -> _int)]
   [RenderDrawLines (_fun _pointer (_cpointer _void) (_cpointer _fpoint) _int -> _int)]
   [RenderFillRects (_fun _pointer (_cpointer _void) (_cpointer _frect) _int -> _int)]
   [RenderCopy (_fun _pointer (_cpointer _void) (_cpointer _texture) (_cpointer _rect) (_cpointer _frect) -> _int)]
   [RenderCopyEx (_fun _pointer (_cpointer _void) (_cpointer _texture) (_cpointer _rect) (_cpointer _frect) _double (_cpointer _fpoint) _renderer-flip -> _int)]
   [RenderReadPixels (_fun _pointer (_cpointer _void) (_cpointer _rect) _uint32 (_cpointer _void) _int -> _int)]
   [RenderPresent (_fun _pointer (_cpointer _void) -> _void)]
   [DestroyTexture (_fun _pointer (_cpointer _void) (_cpointer _texture) -> _void)]
   [DestroyRenderer (_fun _pointer (_cpointer _void) -> _void)]
   [GL_BindTexture (_fun _pointer (_cpointer _void) (_cpointer _texture) (_cpointer _float) (_cpointer _float) -> _int)]
   [GL_UnbindTexture (_fun _pointer (_cpointer _void) (_cpointer _texture) -> _int)]
   [info _renderer-info];TODO
   [window (_cpointer _window)]
   [hidden _bool]
   [logical_w _int]
   [logical_h _int]
   [logical_w_backup _int]
   [logical_h_backup _int]
   [viewport _rect]
   [viewport_backup _rect]
   [clip_rect _rect]
   [clip_rect_backup _rect]
   [scale _fpoint];TODO
   [scale_backup _fpoint]
   [texture (_cpointer _texture)];TODO
   [target (_cpointer _texture)]
   [r _uint8]
   [g _uint8]
   [b _uint8]
   [a _uint8]))
   
   

;;;messy code because I don't know how to inline struct for the _rw-ops definition
(define-cstruct __int-and-file ((a _int) (b _file)))
(define-cstruct __uint8-pointers-3 ((a (_cpointer _uint8)) (b (_cpointer _uint8)) (c (_cpointer _uint8))))
(define-cstruct __void-struct ((a (_cpointer _void))))
;;;end cruft

(define-cstruct _rw-ops
  ([seek (_fun _pointer _int _int -> _int)]
   [read (_fun _pointer (_cpointer _void) _int _int -> _int)]
   [write(_fun _pointer (_cpointer _void) _int _int -> _int)]
   [close (_fun _pointer -> _int)]
   [type _uint32]
   [hidden (_union
            __int-and-file
            __uint8-pointers-3
            __void-struct)]))
   
