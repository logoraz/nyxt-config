(defpackage :nxconfig-init
  (:use :cl :nyxt))
(in-package :nxconfig-init)


(progn
  (asdf:initialize-source-registry
   (list :source-registry
         (list :tree (uiop:xdg-config-home "nyxt/"))
         #+nil
         (list :tree (uiop:xdg-data-home "nyxt/extensions/"))
         :inherit-configuration))
  (asdf:load-system :nxconfig))
