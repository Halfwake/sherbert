#lang racket/base

(require racket/contract)

(provide (struct-out posn)
         (struct-out rect)
         (contract-out
          [left (-> rect? integer?)]
          [width (-> rect? natural-number/c)]
          [right (-> rect? integer?)]
          [top (-> rect? integer?)]
          [height (-> rect? natural-number/c)]
          [bottom (-> rect? integer?)]
          [half-width (-> rect? natural-number/c)]
          [half-height (-> rect? natural-number/c)]       
          [center-x (-> rect? integer?)]
          [center-y (-> rect? integer?)]
          [center (-> rect? posn?)]
          [top-left (-> rect? posn?)]
          [top-right (-> rect? posn?)]
          [bottom-left (-> rect? posn?)]
          [bottom-right (-> rect? posn?)]))

(module+ test
  (require rackunit))

(struct posn (x y) #:transparent)
(struct rect (posn size) #:transparent)

(module+ test
  (check-true (equal? (posn 0 0) (posn 0 0)))
  (check-true (equal? (rect (posn 0 0) (posn 1 2))
                      (rect (posn 0 0) (posn 1 2))))
  (check-false (equal? (posn 0 0) (posn 1 1)))
  (check-false (equal? (rect (posn 0 0) (posn 1 2))
                       (rect (posn 1 2) (posn 0 0)))))

(define (left rect)
  ((compose posn-x rect-posn) rect))

(define (width rect)
  ((compose posn-x rect-size) rect))

(define (right rect)
  (+ (left rect) (width rect)))

(module+ test
  (check-equal? (left (rect (posn 0 0)
                            (posn 0 0)))
                0)
  (check-equal? (left (rect (posn 2 0)
                            (posn 0 0)))
                2)
  (check-equal? (width (rect (posn 0 0)
                             (posn 10 0)))
                10)
  (check-equal? (width (rect (posn 4 4)
                             (posn 4 4)))
                4)
  (check-equal? (right (rect (posn 0 0)
                             (posn 10 0)))
                10)
  (check-equal? (right (rect (posn 6 6)
                             (posn 6 6)))
                12))

(define (top rect)
  ((compose posn-y rect-posn) rect))

(define (height rect)
  ((compose posn-y rect-size) rect))

(define (bottom rect)
  (+ (top rect) (height rect)))

(module+ test
  (check-equal? (top (rect (posn 0 10)
                           (posn 0 0)))
                10)
  (check-equal? (top (rect (posn 5 5)
                           (posn 5 5)))
                5)
  (check-equal? (height (rect (posn 0 0)
                              (posn 0 10)))
                10)
  (check-equal? (height (rect (posn 5 5)
                              (posn 5 5)))
                5)
  (check-equal? (bottom (rect (posn 0 0)
                              (posn 0 10)))
                10)
  (check-equal? (bottom (rect (posn 5 5)
                              (posn 5 5)))
                10))

(define (half-width rect)
  (quotient (width rect) 2))

(define (half-height rect)
  (quotient (height rect) 2))

(define (center-x rect)
  (+ (left rect) (half-width rect)))

(define (center-y rect)
  (+ (top rect) (half-height rect)))

(module+ test
  (check-equal? (half-width (rect (posn 0 0)
                                  (posn 8 0)))
                4)
  (check-equal? (half-width (rect (posn 0 0)
                                  (posn 7 0)))
                3)
  (check-equal? (half-height (rect (posn 0 0)
                                   (posn 0 8)))
                4)
  (check-equal? (half-height (rect (posn 0 0)
                                   (posn 0 7)))
                3)
  (check-equal? (center-x (rect (posn 0 0)
                                (posn 8 0)))
                4)
  (check-equal? (center-x (rect (posn 2 0)
                                (posn 7 0)))
                5)
  (check-equal? (center-y (rect (posn 0 0)
                                (posn 0 8)))
                4)
  (check-equal? (center-y (rect (posn 0 2)
                                (posn 0 7)))
                5))
                
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

(module+ test
  (check-equal? (center (rect (posn 5 4)
                              (posn 3 2)))
                (posn 6 5))
  (check-equal? (top-left (rect (posn 5 4)
                                (posn 3 2)))
                (posn 5 4))
  (check-equal? (top-right (rect (posn 5 4)
                                 (posn 3 2)))
                (posn 8 4))
  (check-equal? (bottom-left (rect (posn 5 4)
                                   (posn 3 2)))
                (posn 5 6))
  (check-equal? (bottom-right (rect (posn 5 4)
                                    (posn 3 2)))
                (posn 8 6)))  
