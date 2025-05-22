(defsystem "nxconfig"
  :author "Erik P Almaraz"
  :license "MIT"
  :version (:read-file-form "version.sexp" :at (0 1))
  :description "Nyxt Configuration."
  :depends-on ("nyxt"
               "micros" 
               "slynk" 
               "swank"
               ;; Local Systems (Extensions)
               "nx-nord-themes"
               "nxcode")
  :components
  ((:module "source"
     :serial t
     :components
     ((:file "browser")
      (:file "keepassxc-pwi")
      (:file "tcp-servers")
      (:file "hacks"))))
  :long-description "Personal configuration for the highly extensible Nyxt Browser
with batteries included. This configuration scaffold is set up as its own modern 
Common Lisp system so as to keep things modular.")
