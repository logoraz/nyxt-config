(defpackage :nyxt-config-init
  (:use :cl
        :nyxt))
(in-package :nyxt-config-init)

;;Add nyxt-config to ASDF registery and load nyxt-config system
(let ((asdf:*central-registry*
        (append (list (asdf:system-source-directory :nyxt)
                      #P"~/.config/nyxt/")
                asdf:*central-registry*)))
  (asdf:load-system :nyxt-config))
