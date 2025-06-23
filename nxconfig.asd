(defsystem "nxconfig"
  :author "Erik P Almaraz"
  :license "MIT"
  :version (:read-file-form "version.sexp" :at (0 1))
  :description "Nyxt Configuration."
  :class :package-inferred-system
  :depends-on ("nyxt"
               "nxconfig/source/all"
               ;; Extensions
               "nx-nord-themes"
               "nxcode")
  :long-description "
Personal configuration for the highly extensible Nyxt Browser with batteries
included. This configuration scaffold is set up as its own modern CL system 
(package-inferred-system type) so as to keep things modular.")
