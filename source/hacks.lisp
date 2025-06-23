(defpackage :nxconfig/source/hacks
  (:use :cl
        :nyxt)
  (:import-from :nfiles
                #:resolve)
  (:import-from :nhooks
                #:add-hook))
(in-package :nxconfig/source/hacks)

;; Borrowed from aartaka
(defmethod resolve ((profile nyxt:nyxt-profile)
                    (file nyxt/mode/bookmark:bookmarks-file))
  "Re-route bookmarks to the `.config/nyxt/' directory."
  (uiop:xdg-config-home #P"nyxt/assets/bookmarks.lisp"))

(define-configuration browser
  ((window-make-hook
    (add-hook %slot-value%
              (lambda (_) (echo "")))
    :dock "Hack to get rid of white echo-area (v4 pre-releases)")))
