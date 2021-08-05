;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Cebir) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
(require "Teachpacks/fonksiyon-teachpack.rkt")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; #1 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; f(x) = x + 5
(define (f x)(+ x 5))
(f 5)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; #2 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; g(y) = 6x
(define (g x) (* x 6))
(g 2)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; #3 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; h(x) = 6x + 5
(define (h x) (+ (* 6 x) 5))
(h 2)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; #4 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; height(t) = 4t+80
(define (height t) (+ (* 4 t) 80))
(height 2)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; #5 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; distance(t) = 3t*t + 10
(define (distance t) (+ (* (* 3 t) t) 10))
(distance 2)
(define (iki-kat x)
  (* x 2))
(ÖRNEK (iki-kat 3) 6)
(ÖRNEK (iki-kat 3) 6)

;;mesafe(x y) = sqrt(sqr x + sqr y)

(ÖRNEK (mesafe 3 4) 5)
(define (mesafe x y) (sqrt (+ (sqr x) (sqr y))))

(mesafe 5 12)

;; metin üretir
(string-append "hello" " " "chris")

;; karakter uzunluğunu bulur
(string-length "Chris")

;isminizle merhaba der

(ÖRNEK (hello "Atakan") "Hello Atakan!")
(define (hello str) (string-append "Hello" " " str "!"))

(hello "World")

(square 20 "solid" "blue")
(rectangle 20 20 "solid" "yellow")


(above (circle 40 "outline" "red") (circle 30 "outline" "black"))

(above (triangle 90 "solid" "pink") (square 10 "solid" "yellow"))

(overlay (circle 5 "solid" "black")(overlay (circle 20 "solid" "red") (triangle 100 "solid" "green")))

(ÖRNEK (target 20 "red" "blue") (overlay (circle 10 "solid" "blue") (circle 20 "solid" "red")))
(define (target x) (overlay (circle x "solid" "red") (circle (* 2 x) "solid" "black")))

(target 10)