(defpackage :nxconfig-init
  (:use :cl :nyxt)
  (:local-nicknames (:lt :local-time))
  (:documentation "nxconfig System Initialization."))
(in-package :nxconfig-init)


(asdf:initialize-source-registry
 (list :source-registry
       (list :tree (uiop:xdg-config-home "nyxt/"))
       :inherit-configuration))

(defun current-time ()
  "Emits formated time using local-time"
  (lt:format-timestring nil (lt:now)
                        :format '(:year "-" :month "-" :day "-T"
                                  :hour ":" :min ":" :sec)))

(defun save-log-file (pathspec output)
  "Save log files for initializing nyxt-config"
  (with-open-file (strm (uiop:xdg-config-home pathspec)
                        :direction :output
                        :if-exists :append
                        :if-does-not-exist :create)
    (format strm "~A - Load nyxt-config output: ~A~%" (current-time) output)))

(multiple-value-bind (result error-condition)
    (ignore-errors
     (sb-ext:without-package-locks
       (asdf:load-system :nxconfig)))
  (if error-condition
      (save-log-file "nyxt/logs/config-error.log" error-condition)
    (save-log-file "nyxt/logs/config-startup.log" result)))
