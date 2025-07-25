(defsystem "nx-nord-themes"
  :description "Nord themes for Nyxt."
  :author "Erik P Almaraz"
  :license "MIT"
  :version (:read-file-form "version.sexp" :at (0 1))
  :depends-on ("nyxt")
  :components
  ((:module "source"
    :components
    ((:file "color-palette")
     (:file "invader-dark"  :depends-on ("color-palette"))
     (:file "ice-dark"      :depends-on ("color-palette")))))
  :long-description "
Long description goes here...")
