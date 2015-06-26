#lang racket/base

(define event-flags
  (hash 'active-event 1
        'key-down 2
        'key-up 3
        'mouse-motion 4
        'mouse-button-down 5
        'mouse-button-up 6
        'joy-axis-motion 7
        'joy-ball-motion 8
        'joy-hat-motion 9
        'joy-button-down 10
        'joy-button-up 11
        'quit 12
        'system-wm-event 13
        'event 14))
