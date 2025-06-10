(uiop:define-package :nyxt-config/source/all
  (:nicknames :nyxt-config)
  (:use :cl
        :nyxt)
  (:use-reexport
   #:nyxt-config/source/browser
   #:nyxt-config/source/keepassxc-pwi
   #:nyxt-config/source/extensions
   #:nyxt-config/source/hacks))
(in-package :nyxt-config/source/all)
