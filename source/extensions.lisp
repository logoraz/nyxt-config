(defpackage :nxconfig/extensions
  (:use :cl :nyxt)
  (:import-from :nfiles
                #:resolve
                #:data-file))
(in-package :nxconfig/extensions)

;;; Nyxt Extensions
;; Loads extentions from #P"~/.local/share/nyxt/extensions/"
;; TODO 1: Change extensions path to #P"$XDG_CONFIG_HOME/nyxt/extensions" 
;; |--> (default to #P"$XDG_DATA_HOME/nyxt/extensions").
;; |--> nyxt:describe-variable?variable=%1B%2Aextensions-directory%2A
;; |--> nyxt:*extensions-directory*
(defmacro defextsystem (system &key files config &allow-other-keys)
  "Helper macro to load configuration for extensions & user config files.
Loads a newly-generated ASDF system depending on SYSTEM.
FILES, if provided, is loaded after the generated system successfully
loads.
CONFIG, if true, provides only components to top-level user config. 
"
  `(define-nyxt-user-system-and-load ,(gensym "NYXT-USER/")
     ,@(cond ((and config files)
              `(:components (,@files)))
             (files
              `(:depends-on (,system))
              `(:components (,@files)))
             (t
              `(:depends-on (,system))))))

;; Keep to illustrate example of proper Nyxt extension
#+nil
(defextsystem nx-nord-theme)

#+nil
(defmethod resolve ((profile nyxt:nyxt-profile)
                    (file data-file))
  "Re-route extensions directory to `.config/nyxt/extensions/' directory."
  (uiop:xdg-config-home #P"nyxt/extensions/"))

#+nil
(setf *extensions-directory*
      (make-instance 'extensions-directory
                     :base-path (uiop:xdg-config-home #P"nyxt/extensions/")))

