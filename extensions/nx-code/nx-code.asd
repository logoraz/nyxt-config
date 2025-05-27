(defsystem #:nx-code
  :description "Modern Emacs-like Editor/IDE for Nyxt."
  :author "Erik P Almaraz"
  :license "MIT"
  :version "0.0.1"
  :serial t
  :depends-on (#:cl-treesitter)
  :components ((:file "nx-code")))
