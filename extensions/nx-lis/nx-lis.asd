(defsystem :nx-lis
  :author "Erik P Almaraz"
  :license "BSD 3-clause"
  :version "0.0.1"
  :description "Connect to Nyxt with Swank/Slynk/Micros servers."
  :serial t
  :depends-on (:nyxt
               :micros
               :swank
               :slynk)
  :components ((:file "nx-lis")))
