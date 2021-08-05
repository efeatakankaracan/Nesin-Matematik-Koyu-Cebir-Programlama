;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Bahçe) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require "Teachpacks/bahce-teachpack.rkt")

; gerçekten yazdığın kodu test etmek istiyorsan - random-imajler? true yap....
(define random-imajler? true)



(define kelebek (kelebek-imajı-üret random-imajler?))
(define kuyu (kuyu-imajı-üret random-imajler?))
(define bahçe (bahçe-imajı-üret random-imajler?))


;;;; Tanımların burada..bahçe boyutları, marjları
(define bahçe-genişliği (image-width bahçe))
(define bahçe-yüksekliği (image-height bahçe))
(define kelebek-genişliği (image-width kelebek))
(define kelebek-yüksekliği (image-height kelebek))
(define kuyu-genişliği (image-width kuyu))
(define kuyu-yüksekliği (image-height kuyu))
(define kuyu-x (kuyu-x-üret bahçe kuyu random-imajler?))
(define kuyu-y (kuyu-y-üret bahçe kuyu random-imajler?))
(define kelebek-ilk-x 470)
(define kelebek-ilk-y 350)


; sözleşme, amaç ve örneklerini unutmayınız


; bahçe-içinde-sol? : Sayı -> Mantıksal
; karakter bahçenin sol tarafından içinde mi?
(define (bahçe-içinde-sol? x)
  (> x (/ kelebek-genişliği 2)))


; bahçe-içinde-sağ? : Sayı -> Mantıksal
; karakter bahçenin sağ tarafından içinde mi?
(define (bahçe-içinde-sağ? x)
  (< x (- bahçe-genişliği (/ kelebek-genişliği 2))))

; bahçe-içinde-alt? : Sayı -> Mantıksal
; karakter bahçenin alt tarafından içinde mi?
(define (bahçe-içinde-alt? y)
  (> y (/ kelebek-yüksekliği 2)))


; bahçe-içinde-üst? : Sayı -> Mantıksal
; karakter bahçenin üst tarafından içinde mi?
(define (bahçe-içinde-üst? y)
  (< y (- bahçe-yüksekliği (/ kelebek-yüksekliği 2))))

;; bahçe-içinde-mi? : Sayı Sayı-> Mantıksal
;; Kelebeğin hepsi hala bahçe içinde mi?
(define (bahçe-içinde-mi? x y)
  (and (bahçe-içinde-üst? y) (bahçe-içinde-sağ? x) (bahçe-içinde-alt? y) (bahçe-içinde-sol? x)))

;;kuyu-dışında-sol? Sayı to Boolean
;;Kelebek kuyunun soldan dışında mı?

;;kelebeğin kuyunun solunda olduğunu kontrol eder
(define (kuyu-dışında-sol? x)
  (< (+ x (/ kelebek-genişliği 2)) (- kuyu-x (/ kuyu-genişliği 2))))
;; kelebeğin kuyunun sağında olduğunu kontrol eder
(define (kuyu-dışında-sağ? x)
  (> (- x (/ kelebek-genişliği 2)) (+ kuyu-x (/ kuyu-genişliği 2))))
;; kelebeğin kuyunun üstünde olduğunu kontrol eder
(define (kuyu-dışında-üst? y)
  (> (- y (/ kelebek-yüksekliği 2)) (+ kuyu-y (/ kuyu-yüksekliği 2))))
;; kelebeğin kuyunun altında olduğunu kontrol eder
(define (kuyu-dışında-alt? y)
  (< (+ y (/ kelebek-yüksekliği 2)) (- kuyu-y (/ kuyu-yüksekliği 2))))

;; kuyu-dışında-mı? : Sayı Sayı -> Mantıksal
;; Kelebeğin hepsi kuyu dışında mı?
(define (kuyu-dışında-mı? x y)
  (or (kuyu-dışında-sol? x) (kuyu-dışında-sağ? x) (kuyu-dışında-üst? y) (kuyu-dışında-alt? y)))

;; güvende-mi? : Sayı Sayı-> Mantıksal
;; Kelebek yanmadan hareket edebilir mi? ?
(define (güvende-mi? x y)
  (and (bahçe-içinde-mi? x y) (kuyu-dışında-mı? x y)))

;;;; Animasyon otomatik olarak başlar
;;;; Kelebeği hareket ettirmek için ok tuşlarını kullan!
(start güvende-mi? bahçe kuyu kelebek kuyu-x kuyu-y kelebek-ilk-x kelebek-ilk-y)



