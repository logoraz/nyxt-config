(defpackage :nx-nord-themes/ice-dark
    (:nicknames :ice-dark)
    (:use :cl :nyxt
          :color-palette)
    (:export #:*ice-dark-theme*))

(in-package #:nx-nord-themes/ice-dark)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Ice Dark Theme

(defparameter *font-regular* "Iosevka Aile")
(defparameter *font-monospace* "Fira Code")

;;; Nord Theme (Based off Invader-2 Theme)
(defvar *ice-dark-theme*
  (make-instance 'theme:theme
                 :font-family           *font-regular*
                 :monospace-font-family *font-monospace*
                 
                 :background-color-     *nord00-*   ;; Dark Black
                 :background-color      *nord00=*   ;; Black
                 :background-color+     *nord01=*
                 :on-background-color   *nord06+*   ;; White (Brighter)

                 :primary-color-        *nord10=*
                 :primary-color         *nord09=*   ;; Blue/Gray
                 :primary-color+        *nord09+*
                 :on-primary-color      *nord00-*

                 :secondary-color-      *nord01=*
                 :secondary-color       *nord03=*   ;; Gray
                 :secondary-color+      *nord02=*
                 :on-secondary-color    *nord06+*   ;; White (Brighter)

                 :action-color-         *nord08=*
                 :action-color          *nord08=*   ;; Metallic Blue lighter
                 :action-color+         *nord08=*
                 :on-action-color       *nord00-*

                 :success-color-        *nord08=*
                 :success-color         *nord08=*   ;; Metallic Blue lighter
                 :success-color+        *nord08=*
                 :on-success-color      *nord00-*

                 :highlight-color-      *nord15-*
                 :highlight-color       *nord15=*   ;; Purple (Pastel)
                 :highlight-color+      *nord15+*
                 :on-highlight-color    *nord00-*

                 :warning-color-        *nord11-*
                 :warning-color         *nord11=*   ;; Red (Brick)
                 :warning-color+        *nord11+*
                 :on-warning-color      *nord00-*))
