;#lang scheme/gui
#lang racket
; make alarm, if kelebek goes out or over well kelebek burns up...
(require lang/prim
         lang/posn
         "bootstrap-common.rkt"
         (except-in htdp/testing test)
         (for-syntax scheme/base))
(provide (all-from-out "bootstrap-common.rkt"))
(provide kelebek-imajı-üret kuyu-imajı-üret bahçe-imajı-üret kuyu-x-üret kuyu-y-üret)
(provide-higher-order-primitive start (onscreen? bahçe kuyu kelebek kuyu-x kuyu-y initial-x initial-y))



(define kelebek-list (list
                      (bitmap "teachpack-images/kelebek-01.png")
                      (bitmap "teachpack-images/kelebek-02.png")
                      (bitmap "teachpack-images/kelebek-03.png")
                      ))
(define kuyu-list (list
                      (bitmap "teachpack-images/kuyu-01.png")
                      (bitmap "teachpack-images/kuyu-02.png")
                      (bitmap "teachpack-images/kuyu-03.png")
                      ))
(define bahçe-list (list
                      (bitmap "teachpack-images/bahçe-01.png")
                      (bitmap "teachpack-images/bahçe-02.png")
                      (bitmap "teachpack-images/bahçe-03.png")
                      (bitmap "teachpack-images/bahçe-04.png")
                      ))




(define (random-list-ref l)
  (list-ref l (random (length l))))

(define (random-list-ref-choose l random?)
  (cond
    (random? (random-list-ref l))
    (else (list-ref l 0))))

(define (kelebek-imajı-üret random?)
  (random-list-ref-choose kelebek-list random?))

(define (bahçe-imajı-üret random?)
  (random-list-ref-choose bahçe-list random?))

(define (kuyu-imajı-üret random?)
  (random-list-ref-choose kuyu-list random?))

(define (koord-üret içi dışı)
    (+ (random (- dışı içi)) (/ içi 2)))

(define (kuyu-x-üret bahçe kuyu random?)
  (cond
    (random? (koord-üret (image-width kuyu) (image-width bahçe)))
    (else 320)))

(define (kuyu-y-üret bahçe kuyu random?)
  (cond
    (random? (koord-üret (image-height kuyu) (image-height bahçe)))
    (else 200)))


(define flame (list (bitmap "teachpack-images/flame_0.gif")
                    (bitmap "teachpack-images/flame_1.gif")
                    (bitmap "teachpack-images/flame_2.gif")
                    (bitmap "teachpack-images/flame_3.gif")
                    (bitmap "teachpack-images/flame_4.gif")
                    (bitmap "teachpack-images/flame_5.gif")
                    (bitmap "teachpack-images/flame_6.gif")
                    (bitmap "teachpack-images/flame_7.gif")
                    ))

(define-struct world [bahçe kuyu kelebek kuyu-x kuyu-y x y burn])

(define (change-world w new-x new-y)
  (make-world  (world-bahçe w)(world-kuyu w)(world-kelebek w)(world-kuyu-x w)(world-kuyu-y w) new-x new-y(world-burn w)))

(define (change-burn w new-burn)
  (make-world  (world-bahçe w)(world-kuyu w)(world-kelebek w)(world-kuyu-x w)(world-kuyu-y w) (world-x w) (world-y w) new-burn))

;; move: World Number -> Number 
;; did the object move? 
(define (move w key)
  (let ((step 5))
    (cond
      [(not (string? key)) w]
      [(string=? key "left") 
       (change-world w (- (world-x w) step) (world-y w))]
      [(string=? key "right") 
       (change-world w (+ (world-x w) step) (world-y w))]
      [(string=? key "down") 
       (change-world w (world-x w) (- (world-y w) step))]
      [(string=? key "up") 
       (change-world w (world-x w) (+ (world-y w) step))]
      [else w])))

(define (tick w)
  (cond
;    ((>= (world-burn w) 0) (change-burn w (modulo (add1 (world-burn w)) (length flame)))); REPEAT FLAME
    ((>= (world-burn w) 0) (change-burn w (min (add1 (world-burn w)) (sub1 (length flame)))))
    (else w)))

(define (kelebek-image w)
  (cond
    ((< (world-burn w) 0) (world-kelebek w))
    (else (list-ref flame (world-burn w)))))

(define (burn? w)
  (let*
      ((kbx (world-x w))
       (kby (world-y w))
       (kbw/2 (/ (image-width (world-kelebek w)) 2))
       (kbh/2 (/ (image-height (world-kelebek w)) 2))
       (kb-sağ (+ kbx kbw/2))
       (kb-sol (- kbx kbw/2))
       (kb-üst (+ kby kbh/2))
       (kb-alt (- kby kbh/2))
       (kuyu-w/2 (/ (image-width (world-kuyu w)) 2))
       (kuyu-h/2 (/ (image-height (world-kuyu w)) 2))
       (kuyu-x (world-kuyu-x w))
       (kuyu-y (world-kuyu-y w))
       (kuyu-sağ (+ kuyu-x kuyu-w/2))
       (kuyu-sol (- kuyu-x kuyu-w/2))
       (kuyu-üst (+ kuyu-y kuyu-h/2))
       (kuyu-alt (- kuyu-y kuyu-h/2))
       (ak-sağ (image-width (world-bahçe w)))
       (ak-üst (image-height (world-bahçe w))))
    (or
     (not
      (and (< kb-sağ ak-sağ)
           (> kb-sol 0)
           (< kb-üst ak-üst)
           (> kb-alt 0)))
     (not
      (or (< kb-sağ kuyu-sol)
          (> kb-sol kuyu-sağ)
          (< kb-üst kuyu-alt)
          (> kb-alt kuyu-üst))))))
       
(define (check-burn w)
  (cond
    ((and (burn? w) (< (world-burn w) 0)) (change-burn w 0))
    (else w)))

;; ----------------------------------------------------------------------------
;; draw-world: World -> Image 
;; create an image that represents the world 
(define (draw-world w)
  (let* ((draw-kelebek 
          (lambda (w scene)
            (place-image (kelebek-image w) 
                         (world-x w) 
                         (- (image-height (world-bahçe w)) (world-y w))
                         scene)))
         (draw-text 
          (lambda (w scene)
            (overlay/align "middle" "top" 
             (text 
              (string-append "x koordinat: " 
                             (number->string (world-x w))
                             "   y koordinat: "
                             (number->string (world-y w)))
              14 'black)
             scene))))
    (draw-kelebek w 
                    (draw-text w (place-image  (world-kuyu w)
                                               (world-kuyu-x w) 
                                               (- (image-height (world-bahçe w)) (world-kuyu-y w))
                                               (world-bahçe w))))))


(define (start onscreen? bahçe kuyu kelebek kuyu-x kuyu-y initial-x initial-y)
  (let*
      ((onscreen?* (if (= (procedure-arity onscreen?) 2) 
                       onscreen?
                       (lambda (x y) (onscreen? x))))
       (update (lambda (w k) 
                 (if (onscreen?* (world-x (move w k)) 
                                 (world-y (move w k))) 
                     (check-burn (move w k))
                     w))))
    (big-bang (make-world bahçe kuyu kelebek kuyu-x kuyu-y initial-x initial-y -1)
      (on-draw draw-world)
      (on-key update)
      (on-tick tick 0.12))))
