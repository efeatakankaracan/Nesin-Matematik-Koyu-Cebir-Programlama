#lang racket
(require "teachpacks/evren-teachpack.rkt")
;; STRUCT v - vektör
;; x : sayı - x koordinatı
;; y : sayı - y koordinatı
(STRUCT v( x y ))
;; v+ - vektör toplama
;; 
;;
;(ÖRNEK ....)
;(ÖRNEK ....)
(define(v+ v1 v2) (v (+ (v-x v1 )(v-x v2))(+(v-y v1) (v-y v2)) ))
(ÖRNEK (v+ (v 2 3) (v 4 5))(v 6 8))
(ÖRNEK (v+ (v -5 -8) (v 3 0))(v -2 -8))
;; v- - vektör çıkartma
;; 
;;
;(ÖRNEK ....)
;(ÖRNEK ....)
(define(v- v1 v2) (v (- (v-x v1 )(v-x v2))(-(v-y v1) (v-y v2)) ))
(ÖRNEK (v-(v -2 3) (v 3 2)) (v -5 1))
(ÖRNEK (v-(v 0 5) (v -5 2)) (v 5 3))
(ÖRNEK (v-(v -2 -3) (v 5 10)) (v -7 -13))
(ÖRNEK (v-(v 0 10) (v -5 -20)) (v 5 30))
;; v* - vektör sayıyla çarpma
;; 
;;
;(ÖRNEK ....)
;(ÖRNEK ....)
(define (v* sayi v1) (v (* (v-x v1) sayi) (* (v-y v1) sayi)))
(ÖRNEK (v* 5 (v 5 5)) (v 25 25)) 
(ÖRNEK (v* -10 (v 3 20)) (v -30 -200))

;; v. - vektör dot çarpma
;; 
;;
;(ÖRNEK ....)
;(ÖRNEK ....)
(define (v. v1 v2)(+(* (v-x v1) (v-x v2)) (*(v-y v1)(v-y v2))))
(ÖRNEK (v. (v 5 5) (v -5 5)) 0)
(ÖRNEK (v. (v 10 5) (v 2 2)) 30)
;; v-mag - vektör uzunluğu
;; 
;;
;(ÖRNEK ....)
;(ÖRNEK ....)
(define(v-mag v1) (sqrt(+(sqr(v-x v1))(sqr(v-y v1)))))
(ÖRNEK(v-mag (v 6 8)) 10)

;;sets resolution using scale/xy function
(define (set-resolution x y image)
  (scale/xy (/ x (image-width image)) (/ y (image-height image)) image))

;;sets the y value of the resolution to 4/3 
(define (set-scale x)
  (* x (/ 3 4)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Hediye vektör çizim fonksiyonları
;; Vektör STRUCT tanıttıktan sonra bu fonkisyonları uncomment edebilirsiniz
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;place-image/v
; resim v sahne -> sahne
; bir sahneye vectöre göre bir imaj yerleştir
; template :
; (define (place-image/v im v1 sahne)
;  (... im ... (v-x v1) ... (v-y v1) ...)
(define test-circle (circle 10 "solid" "purple"))
(define test-square (square 100 "solid" "green"))

(ÖRNEK (place-image/v  test-circle (v 5 5) test-square)
       (place-image/align test-circle 5 5 "center" "center" test-square))
(ÖRNEK (place-image/v test-circle (v 3 8) test-square)
       (place-image/align test-circle 3 8 "center" "center" test-square))
(ÖRNEK (place-image/v test-circle (v 1 2) test-square)
       (place-image/align test-circle 1 2 "center" "center" test-square))
(ÖRNEK (place-image/v test-circle (v 2 8) test-square)
       (place-image/align test-circle 2 8 "center" "center" test-square))

(define (place-image/v im v1 sahne)
  (place-image/align im (v-x v1) (v-y v1) "center" "center"  sahne))

; place-line/v v v color görüntü -> görüntü
; v1'den v2'e giden bir çizgi arka imajına yerleştir
(ÖRNEK (place-line/v (v 2 3) (v 5 1) "red" test-square)
       (add-line test-square 2 3 5 1 "red")) 

(define (place-line/v v1 v2 renk arka)
  (add-line arka (v-x v1) (v-y v1) (v-x v2) (v-y v2) renk)) 

; place-text/v v metin sayı color görüntü -> görüntü
; v pozisyonda  verilen metni arka imajına yerleştir
(ÖRNEK (place-text/v (v 20 30) "Hello" 15 "red" test-square)
       (place-image/v (text "Hello" 15 "red") (v 20 30) test-square))
(define (place-text/v v metin size col arka)
  (place-image/v (text metin size col) v arka))

(define BACKGROUND (set-resolution 1080 (set-scale 1080) (bitmap "imaj/background.jpeg")))

; STRUCT nesne
;; imaj : görüntü - nesneini imajı
;; yer : v - nesnenin ekrandaki yeri
;; hız : v - nesnenin hızı
;; ivme : v - nesnenin ivmesi50
(STRUCT nesne (imaj yer hız ivme can puan))

(define oyuncu (nesne (set-resolution 100 100 (bitmap "imaj/rocket.png")) (v (/ (image-width BACKGROUND) 2) 700) (v 0 0) (v 0 0) 3 100))
(define nesne2 (nesne (set-resolution 100 100 (bitmap "imaj/trash1.png")) (v 200 78) (v 0 (random 1 10)) (v 0 0) 1 0))
(define nesne3 (nesne (set-resolution 100 100 (bitmap "imaj/trash2.png")) (v 300 100) (v 0 (random 1 10)) (v 0 0) 1 0))
(define nesne4 (nesne (set-resolution 100 100 (bitmap "imaj/trash2.png")) (v 100 100) (v 0 (random 1 10)) (v 0 0) 1 0))
(define nesne5 (nesne (set-resolution 100 100 (bitmap "imaj/trash1.png")) (v 400 78) (v 0 (random 1 10)) (v 0 0) 1 0))


(define bullet-list empty)

;;nesne-fizik-güncelle
(define (nesne-fizik-güncelle n)(nesne (nesne-imaj n) (v+ (nesne-yer n) (nesne-hız n)) (v+ (nesne-hız n)(nesne-ivme n)) (nesne-ivme n)
                                       (nesne-can n) (nesne-puan n)))


;;nesne-çiz
(define (nesne-çiz n imaj) (place-image/v (nesne-imaj n) (nesne-yer n) imaj))
;; STRUCT evren
;; arkaplanı : görüntü - oyun arka planı
;;
(STRUCT evren (arkaplan nesne-a nesne-b nesne-c nesne-d nesne-e b-liste puan))

(define (evren-güncelle e)
  (evren-çatışma (evren-nesne-b e) (evren (evren-arkaplan e) (ekrandan-cik (nesne-fizik-güncelle (evren-nesne-a e)) BACKGROUND)
  (alttan-sek (nesne-fizik-güncelle (evren-nesne-b e)) BACKGROUND)
  (alttan-sek (nesne-fizik-güncelle (evren-nesne-c e)) BACKGROUND)
  (alttan-sek (nesne-fizik-güncelle (evren-nesne-d e)) BACKGROUND)
  (alttan-sek (nesne-fizik-güncelle (evren-nesne-e e)) BACKGROUND)
  (filter kursun-cikti-mi? (map nesne-fizik-güncelle (evren-b-liste e)))
  (evren-puan e))))


(define (evren-çiz e)
  (place-text/v (v 30 30) (string-append "Puan:" (number->string (evren-puan e))) 15 "white" (nesne-çiz (evren-nesne-e e)(nesne-çiz (evren-nesne-d e)(nesne-çiz (evren-nesne-c e)(nesne-çiz (evren-nesne-b e)(nesne-çiz (evren-nesne-a e)
                                                                     (foldr nesne-çiz (evren-arkaplan e) (evren-b-liste e)))))))))


;(define (evren-tuş e t)
;  (cond [(string=? t "up") (evren (evren-arkaplan e) (nesne (nesne-imaj (evren-nesne-a e)) (nesne-yer (evren-nesne-a e)) (v (v-x (nesne-hız (evren-nesne-a e)))(- (v-y (nesne-hız (evren-nesne-a e))) 5)) (nesne-ivme (evren-nesne-a e))) (evren-nesne-b e) (evren-nesne-c e))]
;        [(string=? t "down") (evren (evren-arkaplan e) (nesne (nesne-imaj (evren-nesne-a e)) (nesne-yer (evren-nesne-a e)) (v (v-x (nesne-hız (evren-nesne-a e)))(+ (v-y (nesne-hız (evren-nesne-a e))) 5)) (nesne-ivme (evren-nesne-a e))) (evren-nesne-b e) (evren-nesne-c e))]
;        [(string=? t "left") (evren (evren-arkaplan e) (nesne (nesne-imaj (evren-nesne-a e)) (nesne-yer (evren-nesne-a e)) (v (- (v-x (nesne-hız (evren-nesne-a e))) 5) (v-y (nesne-hız (evren-nesne-a e)))) (nesne-ivme (evren-nesne-a e))) (evren-nesne-b e) (evren-nesne-c e))]
;        [(string=? t "right") (evren (evren-arkaplan e) (nesne (nesne-imaj (evren-nesne-a e)) (nesne-yer (evren-nesne-a e)) (v (+ (v-x (nesne-hız (evren-nesne-a e))) 5) (v-y (nesne-hız (evren-nesne-a e)))) (nesne-ivme (evren-nesne-a e))) (evren-nesne-b e) (evren-nesne-c e))][else e]))
; kötü kod

(define (kursun-cikti-mi? n)
  (cond [(< (v-y (nesne-yer n)) (image-width (nesne-imaj n))) false] [else true]))












(define (tuş-vektör t)
  (cond [
         (string=? t "up") (v 0 -12)]
        [(string=? t "down") (v 0 12)]
        [(string=? t "left") (v -12 0)]
        [(string=? t "right") (v 12 0)]
        [else (v 0 0)]))

(define (tuş-ateş e t)
  (cond
    [(< (length (evren-b-liste e)) 5)
     (cond [(string=? t "k")
            (cons (nesne (rectangle 20 30 "solid" "red")
                         (v (v-x (nesne-yer (evren-nesne-a e)))
                            (- (v-y (nesne-yer (evren-nesne-a e)))
                                                                   (/ (image-height (nesne-imaj (evren-nesne-a e))) 2)))
                         (v 0 -30) (v 0 0) 0 0)
                  (evren-b-liste e))]
           [else (evren-b-liste e)])]
    [else (evren-b-liste e)]))

(define (hız-değiştir n v1)
  (nesne (nesne-imaj n)
         (v+ (nesne-yer n) v1)
         (nesne-hız n)
         (nesne-ivme n)
         (nesne-can n)
         (nesne-puan n)))

(define (evren-tuş e t)
  (evren (evren-arkaplan e)
         (hız-değiştir (evren-nesne-a e) (tuş-vektör t))
         (evren-nesne-b e)
         (evren-nesne-c e)
         (evren-nesne-d e)
         (evren-nesne-e e)
         (tuş-ateş e t)
         (evren-puan e)))

(define (evren-fare e x y m)
  e)



 

(define FRAME-RATE 24)

(define yaradılış (evren BACKGROUND oyuncu nesne2 nesne3 nesne4 nesne5 bullet-list 0))

;; alttan sek nesne-imaj -> nesne
;; nesnenin alt kenardan sekmesini sağlamak

(define (alttan-sek n imaj)
  (cond [
         (>= (+ (v-y (nesne-yer n)) (/ (image-height (nesne-imaj n)) 2 )) (image-height imaj)) (nesne (nesne-imaj n)
         (v (random (+ 0 (/ (image-width (nesne-imaj n)) 2)) (- (image-width BACKGROUND) (/ (image-width (nesne-imaj n)) 2))) (+ 0 (/ (image-height (nesne-imaj n)) 2))) (v 0 (random 1 10))(nesne-ivme n) (nesne-can n) (nesne-puan n))] [else n]))

(define (ekrandan-cik n imaj)
  (cond [(< (v-x (nesne-yer n)) 0)
         (nesne (nesne-imaj n) (v (image-width imaj) (v-y (nesne-yer n))) (nesne-hız n) (nesne-ivme n) (nesne-can n) (nesne-puan n))]
        [(> (v-x (nesne-yer n)) (image-width imaj)) (nesne (nesne-imaj n) (v 0 (v-y (nesne-yer n))) (nesne-hız n) (nesne-ivme n)
                                                           (nesne-can n) (nesne-puan n))] [else n]))


(define (catisma-puan n k)
  (cond [(and (and (< (- (v-x (nesne-yer n)) (/ (image-width (nesne-imaj n)) 2)) (v-x (nesne-yer k)))
                   (< (v-x (nesne-yer k)) (+ (v-x (nesne-yer n)) (/ (image-width (nesne-imaj n)) 2))))
              (< (v-y (nesne-yer k)) (+ (image-width (nesne-imaj n)) (v-y (nesne-yer n))))) 10] [else 0]))

(define (catisma-olmadı-mı? n k)
  (cond
    [(and
      (and
       (< (- (v-x (nesne-yer n)) (/ (image-width (nesne-imaj n)) 2)) (v-x (nesne-yer k)))
       (< (v-x (nesne-yer k)) (+ (v-x (nesne-yer n)) (/ (image-width (nesne-imaj n)) 2))))
      (< (v-y (nesne-yer k)) (+ (image-width (nesne-imaj n)) (v-y (nesne-yer n))))) false]
    [else true]))

(define (evren-çatışma n e)
  (evren (evren-arkaplan e)
         (evren-nesne-a e)
         (evren-nesne-b e)
         (evren-nesne-c e)
         (evren-nesne-d e)
         (evren-nesne-e e)
         (filter (curry catisma-olmadı-mı? n) (evren-b-liste e))
         (+ (evren-puan e)
            (foldr + 0
                   (map (curry catisma-puan n)
                         (evren-b-liste e))))))

(define (nesnelere-dokunuldu-mu? e n)
  (cond [(and (and (>= (- (v-x (nesne-yer (evren-nesne-a e))) (/ (image-width (nesne-imaj n)) 2))
                       (- (v-x (nesne-yer n)) (/ (image-width (nesne-imaj n)) 2))
                       )
                   (<= (+ (v-x (nesne-yer (evren-nesne-a e))) (/ (image-width (nesne-imaj n)) 2))
                       (+ (v-x (nesne-yer n)) (/ (image-width (nesne-imaj n)) 2))
                       ))
              (and (>= (+ (v-y (nesne-yer (evren-nesne-a e))) (/ (image-height (nesne-imaj n)) 2))
                       (+ (v-y (nesne-yer n)) (/ (image-height (nesne-imaj n)) 2))
                       )
                   (<= (- (v-y (nesne-yer (evren-nesne-a e))) (/ (image-height (nesne-imaj n)) 2))
                       (- (v-y (nesne-yer n)) (/ (image-height (nesne-imaj n)) 2))
                       )))
         (nesne (nesne-imaj n)
         (v (random (+ 0 (/ (image-width (nesne-imaj n)) 2)) (- (image-width BACKGROUND) (/ (image-width (nesne-imaj n)) 2)))
            (+ 0 (/ (image-height (nesne-imaj n)) 2))) (v 0 (random 1 10))(nesne-ivme n) (nesne-can n) (nesne-puan n))] [else n]))


;; SES herhangbirşey ses-dosyası-metin -> herhangibirşey
;; birinci paramatresini aynen dönsürüyor, sesi çalarak
(ÖRNEK (SES 0 "ses/bark.wav") 0)

(test)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Sabit kod bundan sonra                               ;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(yut (big-bang yaradılış
  (on-tick evren-güncelle (/ 1.0 FRAME-RATE))
  (on-draw evren-çiz)
  (on-key evren-tuş)
  (on-mouse evren-fare)))


(define (factorial n)
  (cond ((<= n 0) 1)
        (else (* n (factorial (- n 1))))))

(define (daireler n)
  (cond ((<= n 0) (circle 5 "solid" "red"))
        (else (beside (circle (* 5 n) "solid" "red") (daireler (- n 1))))))