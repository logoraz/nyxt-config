(defsystem "nx-nord-themes"
  :author "Erik P Almaraz"
  :license "MIT"
  :version (:read-file-form "version.sexp" :at (0 1))
  :version "0.0.1"
  :description "Nord themes for Nyxt."
  :class :package-inferred-system
  :depends-on ("nyxt"
               "nx-nord-themes/invader-dark")
  :long-description "

Long description goes here...

")
