(defsystem "nxcode"
  :description "Modern/Extensible Editor/IDE for Nyxt."
  :author "Erik P Almaraz"
  :license "MIT"
  :version (:read-file-form "version.sexp" :at (0 1))
  :class :package-inferred-system
  :depends-on ("nyxt"
               "nxcode/core")
  :long-description "

Long description here.

")

(register-system-packages "alexandria" '(:alexandria :alexandria-2))
