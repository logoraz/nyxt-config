(defpackage #:nxconfig-init
  (:use #:cl #:nyxt)
  (:import-from #:asdf
                #:initialize-source-registry
                #:load-system)
  (:import-from #:uiop
                #:xdg-config-home)
  (:import-from #:uiop/filesystem
                #:ensure-directories-exist)
  (:import-from #:sb-ext
                #:without-package-locks)
  (:import-from #:local-time
                #:now
                #:format-timestring)
  (:documentation "nxconfig System Initialization."))

(in-package #:nxconfig-init)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; ASDF Registry

(initialize-source-registry
 (list :source-registry
       (list :tree (xdg-config-home "nyxt/"))
       :inherit-configuration))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Logging Facilities (:nxconfig)

(defun current-time ()
  "Emits formatted time using local-time, with error handling."
  (handler-case
      (format-timestring nil (now)
                         :format '(:year "-" :month "-" :day "-T"
                                   :hour ":" :min ":" :sec))
    (error (condition)
      (format nil "Error getting current time: ~A" condition))))

(defun save-log-file (pathspec output)
  "Save log files for initializing nxconfig, with improved error handling."
  (handler-case
      (let ((path (xdg-config-home pathspec)))
        (ensure-directories-exist path)  ; Ensures/creates parents, follows symlinks safely
        (with-open-file (strm path
                              :direction :output
                              :if-exists :append
                              :if-does-not-exist :create
                              :external-format :utf-8)  ; Explicit encoding for portability
          (format strm "~A - Load nxconfig output: ~A~%" (current-time) output))
        t)  ; Return success
    (file-error (condition)
      (format t "File error while saving log ~A: ~A~%" pathspec condition)
      nil)
    (error (condition)
      (format t "Unexpected error while saving log ~A: ~A~%" pathspec condition)
      nil)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Load System

(multiple-value-bind (result error-condition)
    (ignore-errors
     (without-package-locks
       (load-system :nxconfig)))
  (if error-condition
      (save-log-file "nyxt/logs/config-error.log" error-condition)
    (save-log-file "nyxt/logs/config-startup.log" result)))

