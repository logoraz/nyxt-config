(defsystem "nyxt-config"
  :author "Erik P Almaraz"
  :license "MIT"
  :version "0.0.1"
  :description "Nyxt Configuration."
  :class :package-inferred-system
  :depends-on ("nyxt"
               "nyxt-config/source/all"
               "nyxt-config/extensions/nx-lis/all"
               "nyxt-config/extensions/nx-code/all")
  :long-description "
Personal configuration for the highly extensible Nyxt Browser with batteries
included. This configuration scaffold is set up as its own modern CL system 
(package-inferred-system type) so as to keep things modular.")

(register-system-packages "alexandria" '(:alexandria-2))
