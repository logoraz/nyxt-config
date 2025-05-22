(defsystem "nx-nord-themes"
  :description "Nord themes for Nyxt."
  :author "Erik P Almaraz"
  :license "MIT"
  :version (:read-file-form "version.sexp" :at (0 1))
  :depends-on ("nyxt")
  :pathname "source"
  :serial t
  :components
  ((:file "invader-dark"))
  :long-description "
Long description goes here...")
