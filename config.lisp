(defpackage :nxconfig-init
  (:use :cl :nyxt))
(in-package :nxconfig-init)

;;Add nyxt-config to ASDF registery and load nyxt-config system
(progn
  (asdf:initialize-source-registry
   (list :source-registry
         (list :tree (uiop:xdg-config-home "nyxt/"))
         #+or
         (list :tree (uiop:xdg-data-home "common-lisp/bin/nyxt/"))
         :inherit-configuration))
  (asdf:load-system :nxconfig))
