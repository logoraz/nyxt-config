(defsystem #:nx-code
  :description "Modern Emacs-like Editor/IDE for Nyxt."
  :author "Erik P Almaraz"
  :license "MIT"
  :version "0.0.1"
  :class :package-inferred-system
  :depends-on (#:nyxt
               #:alexandria
               #:cl-treesitter
               #:nx-code/core/base))

;; Internal
(register-system-packages "nx-code/core/base" '(#:base))

;; External
(register-system-packages "cl-treesitter" '(#:treesitter))