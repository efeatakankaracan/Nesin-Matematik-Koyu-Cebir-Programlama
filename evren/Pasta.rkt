#lang racket
(require "teachpacks/evren-teachpack.rkt")


; STRUCT pasta:
; renk : color - pastanın rengi
; mesaj-rengi : color - mesajın rengi
; kat : sayı - pasta katların sayısı
; mesaj : metin - pasta üstündeki mesaj
; yarı-çap : sayı - pastanın yarıçapı

(define kalınlık 20)

(STRUCT pasta (renk kat mesaj mesaj-rengi yarı-çap))

(define pasta-örneği
  (pasta "white" 5 "Happy Birthday" "black" 400))


(ÖRNEK (isim-ekle pasta-örneği "Atakan") (pasta "white" 5 "Happy Birthday Atakan" "black" 400))
(define (isim-ekle p isim)
  (pasta (pasta-renk p) (pasta-kat p) (string-append (pasta-mesaj p) " " isim) (pasta-mesaj-rengi p) (pasta-yarı-çap p)))

(ÖRNEK (scale-pasta 20 pasta-örneği) (pasta "white" 5 "Happy Birthday" "black" 8000))
(define (scale-pasta sayi p)
  (pasta (pasta-renk p) (pasta-kat p) (pasta-mesaj p) (pasta-mesaj-rengi p) (* sayi (pasta-yarı-çap p))))
(ÖRNEK (çift-kat pasta-örneği) (pasta "white" 10 "Happy Birthday" "black" 400))
(define (çift-kat p)
  (pasta (pasta-renk p) (* (pasta-kat p)2) (pasta-mesaj p) (pasta-mesaj-rengi p) (pasta-yarı-çap p)))

(define (katla-pasta sayi p) (
cond [
      (< (pasta-kat p) sayi) (çift-kat p)](
     else p)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Verilmiş kod
;;; Buraya dokunma..
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (çiz-pasta p)
  (overlay/align/offset "center" "top" (text (pasta-mesaj p) 18 (pasta-mesaj-rengi p)) 0  (- kalınlık)
                     (çiz-katlar (pasta-kat p) (pasta-renk p) (pasta-yarı-çap p) kalınlık)))

(define (çiz-katlar kat-sayısı renk yarı-çap kalınlık)
  (cond
    ((<= kat-sayısı 1) (çiz-kat renk yarı-çap))
    (else  (overlay/align/offset "left" "top"  (çiz-kat renk yarı-çap) 0 kalınlık 
                                     (çiz-katlar (- kat-sayısı 1) renk yarı-çap kalınlık)))))

(define (çiz-kat renk yarı-çap)
  (overlay
   (ellipse yarı-çap (/ yarı-çap 2) "outline" "black")
   (ellipse yarı-çap (/ yarı-çap 2) "solid" renk)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Verilmiş kod sonu
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

