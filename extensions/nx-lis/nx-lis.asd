(defsystem "nx-lis"
  :author "Erik P Almaraz"
  :license "MIT"
  :version "0.0.1"
  :description "Connect to Nyxt with Swank/Slynk/Micros servers."
  :class :package-inferred-system
  :depends-on ("nyxt"
               "nx-lis/lisi"))
