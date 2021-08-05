#lang racket
(require "teachpacks/evren-teachpack.rkt")

(define flame (list (bitmap "imaj/flame_0.gif")
                    (bitmap "imaj/flame_1.gif")
                    (bitmap "imaj/flame_2.gif")
                    (bitmap "imaj/flame_3.gif")
                    (bitmap "imaj/flame_4.gif")
                    (bitmap "imaj/flame_5.gif")
                    (bitmap "imaj/flame_6.gif")
                    (bitmap "imaj/flame_7.gif")
                    ))



;; STRUCT v - vektör
;; x : sayı - x koordinatı
;; y : sayı - y koordinatı

(STRUCT v (x y))

;; v*
;; v sayı -> v
;; bir vektörün her iki kompnentini bir sayı ile çarparak yeni bir vektör,
;; örnekler
(ÖRNEK (v* (v 2 3) 5) (v 10 15))
(ÖRNEK (v* (v -2 -3) 5) (v -10 -15))
(ÖRNEK (v* (v -2 -3) 0) (v 0 0))
(ÖRNEK (v* (v -2 -3) -5) (v 10 15))
;; template
;;(define (v* vk s)
;;  (v ..... (v-x vk)  .... (v-y vk)))
;;
(define (v* vk s)
  (v (* s (v-x vk))  (* s (v-y vk))))



;;v+
;;v v -> v
;;iki vektörün her iki kompnententi x ler kendi arasında y ler kendi arasında olacak şekilde toplanır yeni bir vektör verir.
;;örnekler
(ÖRNEK (v+ (v 5 8) (v 2 1)) (v 7 9))
(ÖRNEK (v+ (v -6 3) (v 5 4)) (v -1 7))
(ÖRNEK (v+ (v -9 2) (v 9 -2)) (v 0 0))
(ÖRNEK (v+ (v -2 -4) (v -2 -6)) (v -4 -10))
;;template
;;(define (v+ va vb)
;; (v ..... (v-x va) ... (v-x vb)  ..... (v-y va) ... (v-y vb)))
;;
(define (v+ va vb)
  ( v (+ (v-x va) (v-x vb)) (+ (v-y va) (v-y vb))))



;;v-
;; v v -> v
;;iki vektörün her iki kompnententi x ler kendi arasında y ler kendi arasında olacak şekilde çıkartılır yeni bir vektör verir.
;;örnekler
(ÖRNEK (v- (v 6 9) (v 3 5)) (v 3 4))
(ÖRNEK (v- (v 2 0) (v 7 2)) (v -5 -2))
(ÖRNEK (v- (v 3 4) (v 3 4)) (v 0 0))
(ÖRNEK (v- (v -8 10) (v -10 3)) (v 2 7))
;;template
;;(define ( v- va vb)
;; (v ..... (v-x va) (v-x vb) ..... (v-y va) (v-y vb)))
;;
(define (v- va vb)
  ( v (- (v-x va) (v-x vb)) (- (v-y va) (v-y vb))))




;; v. - vektör dot çarpma
;; v v -> sayı
;;iki vektörün her iki kompententi x ler kendi arasında y ler kendi arasında olacak şekilde çarpılır ve iki sonuç toplanır
;;ve toplam değeri verir.
;;örnekler
(ÖRNEK (v. (v 2 5) (v 3 3)) 21)
(ÖRNEK (v. (v -1 4) (v 5 2)) 3)
(ÖRNEK (v. (v -2 -4) (v 3 1)) -10)
(ÖRNEK (v. (v 1 7) (v -8 1)) -1)
(ÖRNEK (v. (v 3 4) (v 3 4)) (+ (* 3 3) (* 4 4)))
(ÖRNEK (v. (v 4 5) (v 4 5)) (+ (* 4 4) (* 5 5)))
;;template
;;(define (v. va vb)
;; (v ..... (v-x va) (v-x vb) ..... (v-y va) (v-y vb)))
;;
;; 
(define (v. va vb)
 (+ (* (v-x va) (v-x vb)) (* (v-y va) (v-y vb))))

;; v-mag - vektör uzunluğu
;; v -> sayı
;;
(ÖRNEK (v-mag (v 6 8)) (sqrt (+ (sqr 6) (sqr 8))))
(ÖRNEK (v-mag (v 3 4)) (sqrt (+ (sqr 3) (sqr 4))))

(define (v-mag v1) (sqrt (+ (sqr (v-x v1)) (sqr (v-y v1)))))

;;v-unit vektör aynı yöne unit vektörüne çevirmek
;; v-unit v -> v 
;(ÖRNEK (v-unit (v 3 4)) (v 0.6 0.8)) 
(define (v-unit v) (v* v (max 0.0001 (/ 1 (+ 0.0001 (v-mag v))))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Hediye vektör çizim fonksiyonları
; Vektör STRUCT tanıttıktan sonra bu fonkisyonları uncomment edebilirsiniz
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;place-image/v
; resim v sahne -> sahne
; bir sahneye vectöre göre bir imaj yerleştir
; template :
; (define (place-image/v im v1 sahne)
;  (... im ... (v-x v1) ... (v-y v1) ...)

(define test-circle (circle 30 "solid" "red"))
(define test-circle2 (circle 40 "solid" "green"))
(define test-square (circle 300 "solid" "red"))
(define test-square2 (square 40 "solid" "green"))

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


;;STRUCT anim
;; devamlı : boolean
;; değişim-sıklığı : sayı;
;; zaman : sayı
;; resimler : görüntü listesi
(STRUCT anim (devamlı değişim-sıklığı zaman resimler))

; anim-çiz anim -> görüntü
; bir animden uygun resim seçmek
(define (anim-çiz a)
  (list-ref (anim-resimler a)
            (modulo (quotient (anim-zaman a) (anim-değişim-sıklığı a))
                    ( length (anim-resimler a)))))

;; anim-zaman-güncelle sayı sayı sayı boolean-> sayı
;; zaman, değişim sıklığı resim sayısı devlılığından yeni zaman hesaplar 
(ÖRNEK (anim-zaman-güncelle 11 3 4 true) 0)
(ÖRNEK (anim-zaman-güncelle 11 3 4 false) 11)
(define (anim-zaman-güncelle z sık uzun devam)
  (cond
    (devam (modulo (+ z 1) (* sık uzun)))
    (else (min (+ z 1) (- (* sık uzun) 1)))))



; anim-güncelle anim -> anim
; bir animden bir sonraki anim yapmak
(define (anim-güncelle a)
  (anim
   (anim-devamlı a)
   (anim-değişim-sıklığı a)
   (anim-zaman-güncelle (anim-zaman a) (anim-değişim-sıklığı a) ( length (anim-resimler a))
                        (anim-devamlı a))
   (anim-resimler a))) 


;;UNION tipi imaj - ya görüntü ya anim
;; imaj->görüntü    : imaj -> görüntü
(define (imaj->görüntü i)
  (cond
    ((anim? i) (anim-çiz i))
    (else i)))

;; imaj-güncelle : imaj ->imaj
;; imajı güncell
(define (imaj-güncelle i)
  (cond
    ((anim? i) (anim-güncelle i))
    (else i)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Googly eyes functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;gözler-ekle: nesne im ---> im
;karakter nesnesi
;mouse v
;dirken imaj
;sözler imaja çiziliyor

(define (gözler-ekle n mv im)
  (let
      ((göz-merkezi-1 (v+ (nesne-yer n)
                          (v 0 -18)))
       (göz-merkezi-2 (v+ (nesne-yer n)
                          (v +11 -18)))
       (gb-mesafesi 3))
    (göz-bebek-çiz göz-merkezi-1 gb-mesafesi mv
                   (göz-bebek-çiz göz-merkezi-2 gb-mesafesi mv im))))

(define (göz-bebek-çiz göz-bebeği gm gbm mv im)
  (place-image/v göz-bebeği
                 (göz-bebek-vektörü gm mv gbm) im))

;; göz-bebek-vektörü v v sayı
;; gözbebeğin yerin belirle
;; gözmerkezi, mouse vektörü ve göz bebek mesafesinden
;(ÖRNEK (göz-bebek-vektörü (v 10 10) (v 40 50) 5) (v 13 14))

(define (göz-bebek-vektörü gm mv gbm)
  (v+ (v* (v-unit (v- mv gm)) gbm) gm))
                     





; STRUCT nesne
;; imaj : imaj - nesnenin imajı
;; yer : v - nesnenin ekrandaki yeri
;; hız : v - nesnenin hızı
;; ivme : v - nesnenin ivmesi
(STRUCT nesne (imaj yer hız ivme))

;;nesne-güncelle
;;nesne -> nesne
;;bir nesne alıp bir saniye sonraki halini üreterek yeni nesneyi verir.

;;template
;;(define (nesne-güncelle a)
;; (nesne ... (nesne-imaj a) ... (nesne-yer a) ... (nesne-hız a) ... (nesne-ivme a)... ) )
;;

;;örnekler:

(ÖRNEK (nesne-güncelle (nesne (circle 10 "solid" "purple") (v 3 5) (v 2 6) (v 3 5))) (nesne (circle 10 "solid" "purple") (v 5 11) (v 5 11) (v 3 5)))
(ÖRNEK (nesne-güncelle (nesne (star 5 "outline" "black") (v 6 7) (v 0 3) (v 2 1))) (nesne (star 5 "outline" "black") (v 6 10) (v 2 4) (v 2 1)))
(ÖRNEK (nesne-güncelle (nesne (triangle 8 "solid" "blue") (v 7 9) (v 1 5) (v 3 8))) (nesne (triangle 8 "solid" "blue") (v 8 14) (v 4 13) (v 3 8)))
(ÖRNEK (nesne-güncelle (nesne (circle 3 "outline" "yellow") (v 2 2) (v 6 3) (v 5 1))) (nesne (circle 3 "outline" "yellow") (v 8 5) (v 11 4) (v 5 1)))

(define (nesne-güncelle a) 
  (nesne (imaj-güncelle (nesne-imaj a)) (v+ (nesne-yer a) (nesne-hız a)) (v+ (nesne-hız a) (nesne-ivme a)) (nesne-ivme a)))


; nesne-sek imaj sayı nesne-> nesne
; nesne verilen imajın sınırlarından verilen enerji kaybı oranıyle sek
(define (nesne-sek bg oran n)
  (let* (
         (bgx (image-width bg))
         (bgy (image-height bg))
         (im (imaj->görüntü (nesne-imaj n)))
         (nx (/ (image-width im) 2))
         (ny (/ (image-height im) 2))
         (x1 (+ 0 nx))
         (x2 (- bgx nx))
         (y1 (+ 0 ny))
         (y2 (- bgy ny)))
    (nesne-sek-x-limit x1 < oran 
                       (nesne-sek-x-limit x2 > oran 
                                          (nesne-sek-y-limit y1 < oran 
                                                             (nesne-sek-y-limit y2 > oran n))))))




;; nesne-sek-x-limit limit compare sayı nesne -> nesne
(define (nesne-sek-x-limit limit compare oran n)
  (cond
    ((and (compare (v-x (nesne-yer n)) limit) (compare (v-x (nesne-hız n)) 0))
     (struct-copy nesne n (hız (struct-copy v (nesne-hız n) (x (* -1 oran (v-x (nesne-hız n))))))))
    (else n)))

;; nesne-sek-y-limit limit compare sayı nesne -> nesne
(define (nesne-sek-y-limit limit compare oran n)
  (cond
    ((and (compare (v-y (nesne-yer n)) limit) (compare (v-y (nesne-hız n)) 0))
     (struct-copy nesne n (hız (struct-copy v (nesne-hız n) (y (* -1 oran (v-y (nesne-hız n))))))))
    (else n)))





;;nesne-çiz
;;nesne imaj -> imaj
;;bir nesnenin imajını nesnenin yerine göre verilen sahneye yerleştir.
;; nesne içindeki koordinatlarını nesnenin imajını sahneye yerleştirmek için kullanacağız
;; template
;; (define (nesne-çiz n im)
;;    ... (nesne-imaj n) ... (nesne-yer n) .... im)
;; örnekler
(ÖRNEK (nesne-çiz (nesne test-circle (v 10 15) (v 2 3) (v 4 5)) test-square)
       (place-image/align test-circle 10 15 "center" "center" test-square))
(ÖRNEK (nesne-çiz (nesne test-circle (v 7 6) (v 3 2) (v 1 7)) test-square)
       (place-image/align test-circle 7 6 "center" "center" test-square))
(ÖRNEK (nesne-çiz (nesne test-circle2 (v 10 3) (v 2 5) (v 1 8)) test-square)
       (place-image/align test-circle2 10 3 "center" "center" test-square))
(ÖRNEK (nesne-çiz (nesne test-circle (v 5 9) (v 1 8) (v 3 1)) test-square2)
       (place-image/align test-circle 5 9 "center" "center" test-square2))



(define (nesne-çiz n im)
  (place-image/v (imaj->görüntü (nesne-imaj n)) (nesne-yer n) im))
 


;; STRUCT evren
;; arkaplanı : görüntü - oyun arka planı
;;
(STRUCT evren (arkaplanı n1 n2 n3))

(define (nesne-sek-güncelle e oran n)
  (nesne-sek (evren-arkaplanı e) 0.95 (nesne-güncelle n)))

(define (evren-güncelle e)
  (evren
   (evren-arkaplanı e)
   (nesne-sek-güncelle e 0.95 (evren-n1 e))
   (nesne-sek-güncelle e 0.95 (evren-n2 e))
   (nesne-sek-güncelle e 0.95 (evren-n3 e))
   ))

(define (evren-çiz e)
  (nesne-çiz (evren-n1 e)
             (nesne-çiz (evren-n2 e)
                        (nesne-çiz (evren-n3 e)
                                   (evren-arkaplanı e)))))

(define (evren-tuş e t)
  e)

(define (evren-fare e x y m)
  e)


(define BACKGROUND (bitmap "imaj/kutuphane.jpg")) 

(define FRAME-RATE 24)
;(define nstart1 (nesne (circle 30 "solid" "red") (v 20 20) (v 10 0) (v 0 1)))
(define nstart1 (nesne (anim true 3 4 flame) (v 20 20) (v 10 0) (v 0 1)))
(define nstart2 (nesne (circle 30 "solid" "green") (v 900 500) (v -10 -10) (v 0 1)))
(define nstart3 (nesne (circle 30 "solid" "blue") (v 400 600) (v 2 -10) (v 0 1)))

(define yaradılış (evren BACKGROUND nstart1 nstart2 nstart3))

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

