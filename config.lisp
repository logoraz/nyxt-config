(defpackage :nxconfig-init
  (:use :cl :nyxt))
(in-package :nxconfig-init)


(asdf:initialize-source-registry
 (list :source-registry
       (list :tree (uiop:xdg-config-home "nyxt/"))
       :inherit-configuration))

(defun save-log-file (pathspec output)
  "Save log files for initializing nyxt-config"
  (with-open-file (strm (uiop:xdg-config-home pathspec)
                        :direction :output
                        :if-exists :append
                        :if-does-not-exist :create)
    (format strm "Load nyxt-config output: ~A~%" output)))

(multiple-value-bind (result error-condition)
    (ignore-errors
     (sb-ext:without-package-locks
       (asdf:load-system :nxconfig)))
  (if error-condition
      (save-log-file "nyxt/error.log" error-condition)
      (save-log-file "nyxt/startup.log" result)))
