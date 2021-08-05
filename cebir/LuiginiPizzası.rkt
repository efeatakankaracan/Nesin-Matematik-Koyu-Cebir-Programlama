;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname LuiginiPizzası) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require "Teachpacks/fonksiyon-teachpack.rkt")
; maliyet : Metin-> Sayı
; bir Pizza malzemesi verildiğinde o malzemeyle yapılan pizzanın maliyetini hesaplar

;; Maliyet - String - Number
;; Gives us the price of the pizza that we want.

(ÖRNEK (maliyet "peynirli") 9.00)

(define (maliyet malzeme)
  (cond
    [(string=? malzeme "peynirli")    9.00]
    [(string=? malzeme "sucuklu") 10.50]
    [(string=? malzeme "tavuklu") 11.25]
    [(string=? malzeme "brokolili") 10.25]
    [else "Bu pizza bulunmamaktadır"])) 

;; Çalıştır'a basın ve etkileşim penceresinde maliyet hesabı yapmayı deneyin
;; mesele (maliyet "peynir") ifadesi 9'a değerlenmelidir.

