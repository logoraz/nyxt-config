;;; Only for nxyt-3 or greater
(nyxt:define-package :nx-code
  #+nil
  (:local-nicknames (#:t #:transducers)
                    (#:re #:cl-ppcre)))
(in-package :nx-code)


(defvar *locutus* "nx-code"
  "First contact from nx-code")

(define-command-global nx-code-first-contact (&optional (locutus *locutus*))
  "First Contact Command."
  (let* ((current-time (local-time:now))
         (current-day-as-string (aref local-time:+day-names+
                                      (local-time:timestamp-day-of-week current-time))))
    (echo "First Contact: ~a ~a." locutus current-day-as-string)))
