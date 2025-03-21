;;;; Nyxt Configuration - Initialization File

;;; Commentary:
;;; Set buffer settings, password interface, Extensions & Hacks
;;;
(in-package #:nyxt-user)

;;; Reset ASDF registries to allow loading Lisp systems from
;;; everywhere...
;; (reset-asdf-registries)

(define-configuration buffer
    ((default-modes `(emacs-mode ,@%slot-value%))))

;; TODO: setup as a nyxt extension?
;; Loading files from the same directory (~/.config/nyxt/).
#-nyxt-4
(define-nyxt-user-system-and-load nyxt-user/basic-config
  :description "Nyxt Interface Configuration."
  :components ("keepassxc-pwi"
               "keepassxc-3431"))


;;; Nyxt Extensions
;; Borrowed from aartaka (see #:ref-1)
;; Loads extentions from #P"~/.local/share/nyxt/extensions/"
;; TODO: Change extensions path to #P"$XDG_CONFIG_HOME/nyxt/extensions" 
;; (default to #P"$XDG_DATA_HOME/nyxt/extensions").
;; nyxt:describe-variable?variable=%1B%2Aextensions-directory%2A
;; nyxt:*extensions-directory*
(defmacro defextsystem (system &optional file)
  "Helper macro to load configuration for extensions.
Loads a newly-generated ASDF system depending on SYSTEM.
FILE, if provided, is loaded after the generated system successfully
loads."
  `(define-nyxt-user-system-and-load ,(gensym "NYXT-USER/")
     :depends-on (,system) ,@(when file `(:components (,file)))))

(defextsystem #:nx-nord-theme)
(defextsystem #:nx-micros)
;; (defextsystem #:nx-code)


;;; Hacks

;; Borrowed from aartaka (see #:ref-1)
(defmethod files:resolve ((profile nyxt:nyxt-profile)
                          (file nyxt/mode/bookmark:bookmarks-file))
  "Re-route bookmarks to the `.config/nyxt/' directory."
  #P"~/.config/nyxt/bookmarks.lisp")

;; Hack to get rid of white echo-area
;; This still crashes: See https://github.com/atlas-engineer/nyxt/issues/3620
;; (define-configuration browser
;;   ((window-make-hook
;; 	(hooks:add-hook %slot-value% (lambda (_)
;;           (echo "")))))
