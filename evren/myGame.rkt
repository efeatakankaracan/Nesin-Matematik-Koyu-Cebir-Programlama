#lang racket
(require "teachpacks/evren-teachpack.rkt")
;;gerekli bazı fonksiyonlar
(define (yukseklik-scale resim yukseklik-degeri)
  (scale (/  yukseklik-degeri (image-height resim)) resim))
(define (genişlik-scale resim genişlik-degeri)
  (scale (/  genişlik-degeri (image-width resim)) resim))

(define arkaplan-list (list (bitmap "imaj/arena1.jpg")))
(define arkaplan-imaj-index (random (length arkaplan-list)))
(define arkaplan (genişlik-scale (list-ref arkaplan-list arkaplan-imaj-index) 1100))
(define arkaplan-yüksekliği (image-height arkaplan))
(define kurşun-img1 (genişlik-scale (bitmap "imaj/kurşuno1.png") 30))
(define kurşun-img2 (genişlik-scale (bitmap "imaj/kurşuno2.png") 30))
(define oyuncu1img (genişlik-scale (bitmap "imaj/oyuncu1img.png") 150))
(define oyuncu2img (genişlik-scale (bitmap "imaj/oyuncu2img.png") 150))

(STRUCT v(x y))
(STRUCT kurşun(imaj yer hız))

(define oyuncu1-kurşun-list (list empty))
(define oyuncu2-kurşun-list (list empty))

;list (kurşun kurşun-img2 (v 0 0) (v -1 0) ) (kurşun kurşun-img2 (v 0 0) (v -1 0)) (kurşun kurşun-img2 (v 0 0) (v -1 0)) (kurşun kurşun-img2 (v -1 0) (v 0 0)) (kurşun kurşun-img2 (v -1 0) (v 0 0))))
                 
(STRUCT oyuncu(imaj yer kurşunlar kalkanmı kalkancount))

(STRUCT evren(arkaplan oyuncu1 oyuncu2 ))

;;fonksiyonlar hareket falan;;








;;;;;;örnekler;;;;;;
(define örnekoyuncu1
  (oyuncu oyuncu1img (v 100  (/ arkaplan-yüksekliği 2)) oyuncu1-kurşun-list #false 5))

(define örnekoyuncu2
  (oyuncu oyuncu2img (v 1000 (/ arkaplan-yüksekliği 2)) oyuncu1-kurşun-list #false 5))

(define örnekevren
  (evren arkaplan örnekoyuncu1 örnekoyuncu2))
;;;;;;;;;;;;;;;;;;;;

;imajın üstüne nesne çizmek

(define(oyuncu-çiz oyuncum imajım)(place-image/align (oyuncu-imaj oyuncum) (v-x (oyuncu-yer oyuncum))(v-y (oyuncu-yer oyuncum)) "center" "center" imajım))
(define(evren-çiz e) (oyuncu-çiz (evren-oyuncu2 e)(oyuncu-çiz (evren-oyuncu1 e) arkaplan) ))

;;zor;

(define (evren-tuş tuş e) (
    (cond
      [(string=? tuş "up") (evren (evren-arkaplan e) (evren-oyuncu1 e) (oyuncu (oyuncu-imaj (evren-oyuncu2 e))
                                                                               (v (v-x(oyuncu-yer (evren-oyuncu2 e))) (- 10 (v-y(oyuncu-yer (evren-oyuncu2 e)))))
                                                                               (oyuncu-kurşunlar (evren-oyuncu2 e)) (oyuncu-kalkanmı (evren-oyuncu2 e)) (oyuncu-kalkancount (evren-oyuncu2 e))))]
      [(string=? tuş "down") (evren (evren-arkaplan e) (evren-oyuncu1 e) (oyuncu (oyuncu-imaj (evren-oyuncu2 e))
                                                                               (v (v-x(oyuncu-yer (evren-oyuncu2 e))) (+ 10 (v-y(oyuncu-yer (evren-oyuncu2 e)))))
                                                                               (oyuncu-kurşunlar (evren-oyuncu2 e)) (oyuncu-kalkanmı (evren-oyuncu2 e)) (oyuncu-kalkancount (evren-oyuncu2 e))))]

      [(string=? tuş "w") (evren (evren-arkaplan e) (evren-oyuncu1 e) (oyuncu (oyuncu-imaj (evren-oyuncu2 e))
                                                                               (v (- 10 (v-x(oyuncu-yer (evren-oyuncu2 e)))) (v-y(oyuncu-yer (evren-oyuncu2 e))))
                                                                               (oyuncu-kurşunlar (evren-oyuncu2 e)) (oyuncu-kalkanmı (evren-oyuncu2 e)) (oyuncu-kalkancount (evren-oyuncu2 e))))]
      
      [(string=? tuş "s") (evren (evren-arkaplan e) (evren-oyuncu1 e) (oyuncu (oyuncu-imaj (evren-oyuncu2 e))
                                                                               (v (+ 10 (v-x(oyuncu-yer (evren-oyuncu2 e)))) (v-y(oyuncu-yer (evren-oyuncu2 e))))
                                                                               (oyuncu-kurşunlar (evren-oyuncu2 e)) (oyuncu-kalkanmı (evren-oyuncu2 e)) (oyuncu-kalkancount (evren-oyuncu2 e))))])))



;(define (evren-tuş e tuş)
;   (evren
;   (evren-arkaplan e)
;   (oyuncuları-güncelle (evren-oyuncu1 e) e)
;   (oyuncuları-güncelle (evren-oyuncu2 e) e)))

(define (evren-güncelle e)e)

;;dokunma kısmı ig;
(define FRAME-RATE 12)

(define yaradılış örnekevren)

(yut (big-bang yaradılış
  (on-tick evren-güncelle (/ 1.0 FRAME-RATE))
  (on-draw evren-çiz)
  (on-key evren-tuş)))
