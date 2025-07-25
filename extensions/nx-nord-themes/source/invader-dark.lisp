(defpackage :nx-nord-themes/invader-dark
    (:nicknames :nord-dark)
    (:use :cl :nyxt))

(in-package :nx-nord-themes/invader-dark)

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


(defparameter *font-regular* "Iosevka Aile")
(defparameter *font-monospace* "Fira Code")

;;; Nord Theme (Based off Invader-2 Theme)
(defvar *nx-nord-theme*
  (make-instance 'theme:theme
                 :font-family           *font-regular*
                 :monospace-font-family *font-monospace*
                 
                 :background-color-    *nord00-*   ;; Dark Black
                 :background-color     *nord00=*   ;; Black
                 :background-color+    *nord01=*
                 :on-background-color  *nord06+*   ;; White (Brighter)

                 :primary-color-       *nord10=*
                 :primary-color        *nord09=*   ;; Blue/Gray
                 :primary-color+       *nord09+*
                 :on-primary-color     *nord00-*

                 :secondary-color-     *nord01=*
                 :secondary-color      *nord03=*   ;; Gray
                 :secondary-color+     *nord02=*
                 :on-secondary-color   *nord06+*   ;; White (Brighter)

                 :action-color-        *nord14-*
                 :action-color         *nord14-*   ;; Green (Pastel) darker
                 :action-color+        *nord14-*
                 :on-action-color      *nord00-*

                 :success-color-       *nord14-*
                 :success-color        *nord14-*   ;; Green (Pastel) darker
                 :success-color+       *nord14-*
                 :on-success-color     *nord00-*

                 :highlight-color-     *nord15-*
                 :highlight-color      *nord15=*   ;; Purple (Pastel)
                 :highlight-color+     *nord15+*
                 :on-highlight-color   *nord00-*

                 :warning-color-       *nord11-*
                 :warning-color        *nord11=*   ;; Red (Brick)
                 :warning-color+       *nord11+*
                 :on-warning-color     *nord00-*))

(define-configuration :browser
    ((theme *nx-nord-theme*)))

(define-configuration :status-buffer
    ((style (str:concat %slot-value%
                        (theme:themed-css (theme *browser*))))))
