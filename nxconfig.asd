(defsystem "nxconfig"
  :author "Erik P Almaraz"
  :license "MIT"
  :version (:read-file-form "version.sexp" :at (0 1))
  :description "Nyxt Configuration."
  :depends-on ("nyxt"
               ;; External Systems
               "micros" 
               "slynk" 
               "swank"
               ;; Local Systems (Extensions)
               "nx-nord-themes"
               "nxclide")
  :components
  ((:module "source"
     :components
     ((:file "browser")
      (:file "keepassxc-pwi")
      (:file "tcp-servers")
      (:file "hacks"))))
  :long-description "Personal configuration for the highly extensible Nyxt Browser
with batteries included. This configuration scaffold is set up as its own modern 
Common Lisp system so as to keep things modular.")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Register Systems
;;;
;; The function `register-system-packages' must be called to register packages
;; used or provided by your system when the name of the system/file that
;; provides the package is not the same as the package name
;; (converted to lower case).



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Secondary Systems
;;;
