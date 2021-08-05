;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Oyun_efe_karacan) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require "Teachpacks/bootstrap-teachpack.rkt")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 0. Oyun başlığı: Oyununuzun adını burada yazın
(define BAŞLIK "Oyunum")
(define BAŞLIK-RENGİ "white")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Görüntüler - tehlike, hedef, ve oyuncu görselleri
(define ARKAPLAN (bitmap "photos/bg.jpg"))
(define TEHLİKE (bitmap "photos/asteroid.png"))
(define HEDEF (scale 0.8 (bitmap "photos/fuel.png")))
(define OYUNCU (bitmap "photos/rocket.png"))
(define mesafeler-göster false)

(define nesne-genişliği 50)

;; Bu oyunun bir ekran görüntüsü, OYUNCU (320, 240)'ta,
;; HEDEF (400 500)'ta ve TEHLİKE (150, 200)'ta
(define EKRANGÖRÜNTÜSÜ (put-image TEHLİKE
                                150 200
                                (put-image HEDEF
                                           500 400
                                           (put-image OYUNCU
                                                      320 240
                                                      ARKAPLAN))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 1. Tehlike, Hedef, ve oyuncu'yu hareket ettiriyoruz

; tehlike-güncelle: Sayı -> Sayı
; tehlike'nin x koordinatı verildiğinde bir sonraki x koordinatını döndür

;; tehlike-güncelle için örnekleri alta yazın

(ÖRNEK (tehlike-güncelle 100) 50)
(define (tehlike-güncelle x)
  (- x 50))


; hedef-güncelle : Sayı -> Sayı
; hedef'in x koordinatı verildiğinde bir sonraki x koordinatını döndür

;; hedef-güncelle için örnekleri alta yazın

(define (hedef-güncelle x)
  (+ x 50))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 2. Tehlike ve hedef'in ekrana geri dönmesini sağlıyoruz
;;    Nereye gittiklerini bilmemiz lazım
;;    Ekranın içindeler mi?

; ekran-solundan-çıkmamış? : Sayı -> Mantıksal
; Karakter oyun ekranının solundan içeride mi?

; Bunun doğru olduğu ve yanlış olduğu birer örnek yazın
(ÖRNEK (ekran-solundan-çıkmamış? 300) true)
(define (ekran-solundan-çıkmamış? x)
  (> x (- 0(/ nesne-genişliği 2))))

; ekran-sağından-çıkmamış? : Sayı -> Mantıksal
; Karakter oyun ekranının sağından içeride mi?

; Bunun doğru olduğu ve yanlış olduğu birer örnek yazın

(ÖRNEK (ekran-sağından-çıkmamış? 300) true)
(define (ekran-sağından-çıkmamış? x)
  (< x (+ (image-width ARKAPLAN) (/ nesne-genişliği 2))))

; ekranda? : Sayı -> Mantıksal
; Koordinat ekranın içinde mi belirler

;; ÖRNEKler:

(define (ekranda-görünüyor-mu? x)
  (and (ekran-solundan-çıkmamış? x) (ekran-sağından-çıkmamış? x)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 3. Oyuncuyu hareket ettirelim!

; oyuncu-günceller: Sayı Metin -> Sayı
; oyuncunun y koordinatı ve bir yön bilgisi verildiğinde bir sonraki y koordinatını döndürür

; ÖRNEKler:

(ÖRNEK (oyuncu-güncelle 320 "up") 325)

(define (oyuncu-güncelle y yön)
  (cond [
         (string=? yön "up") (+ y 10)]
[
 (string=? yön "down") (- y 10)]
[else y]))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 4. Çarpışmalar: Oyuncu hedefe veya tehlikeye yeterince yaklaştığında birşey olmalı!
;;    Burada "yeterince yakın"ın ne olduğunu bilmemiz gerek, ve nesnelerin birbirinden ne kadar uzak olduğunu bilmeliyiz

;; eğer mesafe-rengi "yellow" ise program oyuncu ve diğer nesneler arasında sarı bir üçgen çizer.
;; Bu üçgenin kenarlarında kenar uzunluğu gösterilir
;; ve mesafe ta hipotenüzte gösterilir (bu her renkte olur)
(define *mesafe-rengi* "")

; çizgi-uzunluğu: Sayı Sayı -> Sayı
; Bir sayı ekseni üzerinde iki nokta arasındaki çizginin uzunluğu
;; bazı örnekler - dikkat edin girdi değerlerinin sırası ne olursa olsun aynı değeri döndürmeliyiz

(ÖRNEK (çizgi-uzunluğu 20 10) 10)
(define (çizgi-uzunluğu a b)
  (cond [
         (> a b) (- a b)]
        [
         (< a b) (- b a)]
        [
         else 0]))
  
; mesafe : Sayı Sayı Sayı Sayı -> Sayı
; Ekrandaki iki nokta arasındaki mesafe
; Oyuncunun x ve y, ve bir nesnenin x ve y koordinatları verilmiş
; Ne kadar uzaktırlar?
; Örnekler:

(ÖRNEK (mesafe 20 20 20 30) 10)

(define (mesafe px py cx cy)
  (sqrt (+ (sqr (çizgi-uzunluğu px py)) (sqr (çizgi-uzunluğu cx cy)))))

; çarğıştı? : Sayı Sayı Sayı Sayı -> Mantıksal
; Ne kadar yakın yeterince yakındır?
; Oyuncunun x ve y koordinatları ve bir nesnenin x ve y koordinatları verilmiş
; Aralarındaki mesafeye bakıp çarpışıp çarpışmadıklarına karar veririz.
; Örnekler:
(define (çarpıştı-mı? px py cx cy)
  (<= (mesafe px py cx cy) 50))



; son bir sır:
(define GİZEMLİ (radial-star 5 25 10 "solid" "silver"))
(define (gizemli-güncelle x) 
  (+ x 50))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; VERİLEN KOD: Buraya dokunmayınız...

(define g (make-game BAŞLIK BAŞLIK-RENGİ 
                     ARKAPLAN 
                     TEHLİKE tehlike-güncelle
                     HEDEF hedef-güncelle
                     OYUNCU oyuncu-güncelle
                     GİZEMLİ gizemli-güncelle
                     mesafeler-göster çizgi-uzunluğu mesafe
                     çarpıştı-mı? ekranda-görünüyor-mu?))

;; bu satır oyunu otomatik olarak başlatır...
(play g)
