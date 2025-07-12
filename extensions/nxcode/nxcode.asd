(defsystem "nxcode"
  :description "Modern/Extensible Editor/IDE for Nyxt."
  :author "Erik P Almaraz"
  :license "MIT"
  :version (:read-file-form "version.sexp" :at (0 1))
  :depends-on ("nyxt")
  :pathname "source"
  :serial t
  :components
  ((:file "core"))
  :long-description "
Long description here.")

(register-system-packages "alexandria" '(:alexandria :alexandria-2))
