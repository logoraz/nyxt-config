(uiop:define-package :nxconfig/source/all
  (:nicknames :nxconfig)
  (:use :cl :nyxt)
  (:use-reexport
   #:nxconfig/source/browser
   #:nxconfig/source/keepassxc-pwi
   #:nxconfig/source/tcp-servers
   #:nxconfig/source/hacks
   #+nil
   #:nxconfig/source/extensions))
(in-package :nxconfig/source/all)
