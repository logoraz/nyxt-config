(defsystem #:nx-code
  :description "Modern Emacs-like Editor/IDE for Nyxt."
  :author "Erik P Almaraz"
  :license "MIT"
  :version "0.0.1"
  :class :package-inferred-system
  :depends-on (#:nyxt
               #:nx-code/core/base))

(register-system-packages "alexandria" '(#:alexandria #:alexandria-2))
