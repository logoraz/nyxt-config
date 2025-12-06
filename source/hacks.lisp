(defpackage #:nxconfig/hacks
  (:use #:cl #:nyxt)
  (:import-from #:nfiles
                #:resolve)
  (:import-from #:nhooks
                #:add-hook)
  (:documentation "Nyxt Configuration Hacks."))

(in-package #:nxconfig/hacks)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Hacks
;;;
;;; Borrowed from aartaka

(defmethod resolve ((profile nyxt:nyxt-profile)
                    (file nyxt/mode/bookmark:bookmarks-file))
  "Re-route bookmarks to the `.config/nyxt/' directory."
  (uiop:xdg-config-home #P"nyxt/bookmarks.lisp"))

(define-configuration browser
  ((window-make-hook
    (add-hook %slot-value%
              (lambda (_) (echo "")))
    :doc "Hack to get rid of white echo-area (v4 pre-releases)")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Notes for reference

;; (defmethod customize-instance ((document-buffer document-buffer) &key)
;;            "Set Zoom Ratio to account for HiDPI on StumpWM. Need to adjust minibuffer"
;;            (setf (slot-value document-buffer 'zoom-ratio-default) 1.7))

;; (define-configuration :status-buffer
;;   ((height 50)
;;    (style (str:concat %slot-value%
;;                       (theme:themed-css (theme *browser*)
;;                         '(*
;;                           :font-size "24px"
;;                           :line-height "30px"))))))

;; (define-configuration :prompt-buffer
;;   ((style (str:concat %slot-value%
;;                       (theme:themed-css (theme *browser*)
;;                         '(*
;;                           :font-size "24px"
;;                           :line-height "34px"))))))
