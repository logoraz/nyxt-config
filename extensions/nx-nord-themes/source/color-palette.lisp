(defpackage #:nx-nord-themes/color-palette
  (:nicknames #:color-palette)
  (:use #:cl #:nyxt)
  (:export #:*nord00-*
           #:*nord00=*
           #:*nord01=*
           #:*nord02=*
           #:*nord03=*
           #:*nord04=*
           #:*nord05=*
           #:*nord06=*
           #:*nord06+*
           #:*nord07-*
           #:*nord07=*
           #:*nord07+*
           #:*nord08-*
           #:*nord08=*
           #:*nord08+*
           #:*nord09=*
           #:*nord09+*
           #:*nord10=*
           #:*nord11-*
           #:*nord11=*
           #:*nord11+*
           #:*nord12-*
           #:*nord12=*
           #:*nord12+*
           #:*nord13-*
           #:*nord13=*
           #:*nord13+*
           #:*nord14-*
           #:*nord14=*
           #:*nord14+*
           #:*nord15-*
           #:*nord15=*
           #:*nord15+*))

(in-package #:nx-nord-themes/color-palette)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Nord Color Palette
;; Tool used to add colors variation https://mdigi.tools/color-shades/#44475a

(defparameter *nord00-* "#242831")  ;; '- (darker)'
(defparameter *nord00=* "#2e3440")  ;; '= (base)'     Black
(defparameter *nord01=* "#3b4252")  ;; "= (base)'     Dark Gray
(defparameter *nord02=* "#434c5e")  ;; '= (base)'     Med Gray
(defparameter *nord03=* "#4c566a")  ;; '= (base)'     Gray
(defparameter *nord04=* "#d8dee9")  ;; '= (base)'     Light Gray
(defparameter *nord05=* "#e5e9f0")  ;; '= (base)'     Off-White
(defparameter *nord06=* "#eceff4")  ;; '= (base)'     White
(defparameter *nord06+* "#f7f8fa")  ;; '+ (lighter)'
(defparameter *nord07-* "#77aead")  ;; '- (darker)'  
(defparameter *nord07=* "#8fbcbb")  ;; '= (base)'     Blue/Green (Teal)
(defparameter *nord07+* "#97c1c0")  ;; '+ (lighter)'
(defparameter *nord08-* "#64adc2")  ;; '- (darker)'
(defparameter *nord08=* "#88c0d0")  ;; '= (base)'     Blue (Metallic)
(defparameter *nord08+* "#9acad7")  ;; '+ (lighter)'
(defparameter *nord09=* "#81a1c1")  ;; '= (base)'     Blue/Gray (Metallic)
(defparameter *nord09+* "#a1b9d1")  ;; '+ (lighter)'  
(defparameter *nord10=* "#5e81ac")  ;; '= (base)'     Dark Blue/Gray (Metallic)
(defparameter *nord11-* "#9a3e47")  ;; '- (darker)'
(defparameter *nord11=* "#bf616a")  ;; '= (base)'     Red (Brick)
(defparameter *nord11+* "#cf8990")  ;; '+ (lighter)'
(defparameter *nord12-* "#c36649")  ;; '- (darker)'
(defparameter *nord12=* "#d08770")  ;; '= (base)'     Orange (Pale)
(defparameter *nord12+* "#dca695")  ;; '+ (lighter)'
(defparameter *nord13-* "#e3b65c")  ;; '- (darker)'
(defparameter *nord13=* "#ebcb8b")  ;; '= (base)'     Yellow (Pale)
(defparameter *nord13+* "#f2ddb3")  ;; '+ (lighter)'
;; TODO Update color range based on (darker being the default - deviate from Nord slightly)
(defparameter *nord14-* "#83a864")  ;; '- (darker)'
(defparameter *nord14=* "#a3be8c")  ;; '= (base)'     Green (Pastel)
(defparameter *nord14+* "#d1dfc6")  ;; '+ (lighter)'
(defparameter *nord15-* "#926189")  ;; '- (darker)'
(defparameter *nord15=* "#b48ead")  ;; '= (base)'     Purple (Pastel)
(defparameter *nord15+* "#dbc9d8")  ;; '+ (lighter)'
