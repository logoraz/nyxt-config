;; see nyxt/source/package.lisp (line 90)
(defpackage :nxcode/core
  (:use :cl :nyxt)
  (:import-from :alexandria-2)
  (:import-from :local-time)
  (:import-from :cl-ppcre)
  (:export #:*locutus*
           #:nxcode-first-contact)
  (:documentation "Base package for nx-code"))

(in-package :nxcode/core)

(defvar *locutus* "nx-code"
  "First contact from nx-code")

(define-command-global nx-code-first-contact (&optional (locutus *locutus*))
  "First Contact Command."
  (let* ((current-time (local-time:now))
         (current-day-as-string 
           (aref local-time:+day-names+
                 (local-time:timestamp-day-of-week current-time))))
    (echo "First Contact: ~a ~a." locutus current-day-as-string)))
