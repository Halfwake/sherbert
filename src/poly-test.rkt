#lang racket

(require rackunit
         "poly.rkt")

(let ([test-posn (posn 4 7)])
  (check-equal? 4
                (posn-x test-posn))
  (check-equal? 7
                (posn-y test-posn)))

(let ([test-rect (rect 3 5 7 8)])
  (check-equal? 3
                (left test-rect))
  (check-equal? 10
                (right test-rect))
  (check-equal? 5
                (top test-rect))
  (check-equal? 13
                (bottom test-rect))
  
  (check-equal? 3
                (half-width test-rect))
  (check-equal? 4
                (half-height test-rect))
  
  (check-equal? 6
                (center-x test-rect))
  (check-equal? 9
                (center-y test-rect))
  (check-equal? (posn (center-x test-rect) (center-y test-rect))
                (center test-rect))
  
  (check-equal? (posn (left test-rect) (top test-rect))
                (top-left test-rect))
  (check-equal? (posn (right test-rect) (top test-rect))
                (top-right test-rect))
  (check-equal? (posn (left test-rect) (bottom test-rect))
                (bottom-left test-rect))
  (check-equal? (posn (right test-rect) (bottom test-rect))
                (bottom-right test-rect)))