(defpackage :nyxt-config-init
  (:use :cl :nyxt))
(in-package :nyxt-config-init)

;;Add nyxt-config to ASDF registery and load nyxt-config system
(let ((asdf:*central-registry*
        (append (list #P"~/.config/nyxt/"
                      #P"~/.config/nyxt/extensions/")
                asdf:*central-registry*)))
  (asdf:load-system :nyxt-config))
