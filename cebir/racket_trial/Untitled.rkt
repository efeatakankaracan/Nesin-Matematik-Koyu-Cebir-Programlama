#lang racket
(define (extract str)
  (substring str 0 5))

(extract "hello")