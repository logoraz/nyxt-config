;; see nyxt/source/package.lisp (line 90)
(defpackage #:nx-code/core/base
  (:nicknames #:nx-code)
  (:use #:cl 
        #:nyxt
        #:alexandria-2)
  (:export *locutus*))

(in-package #:nx-code/core/base)

(defvar *locutus* "nx-code"
  "First contact from nx-code")

(define-command-global nx-code-first-contact (&optional (locutus *locutus*))
  "First Contact Command."
  (let* ((current-time (local-time:now))
         (current-day-as-string 
           (aref local-time:+day-names+
                 (local-time:timestamp-day-of-week current-time))))
    (echo "First Contact: ~a ~a." locutus current-day-as-string)))
