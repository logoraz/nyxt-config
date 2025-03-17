(in-package #:nyxt-user)

(define-configuration buffer
    ((default-modes `(emacs-mode ,@%slot-value%))))

;;; Nyxt Extensions
;; Loads extentions from #P"~/.local/share/nyxt/extensions/"
;; TODO 1: Change extensions path to #P"$XDG_CONFIG_HOME/nyxt/extensions" 
;; |--> (default to #P"$XDG_DATA_HOME/nyxt/extensions").
;; |--> nyxt:describe-variable?variable=%1B%2Aextensions-directory%2A
;; |--> nyxt:*extensions-directory*
(defmacro defextsystem (system &key files user &allow-other-keys)
  "Helper macro to load configuration for extensions & user config files.
Loads a newly-generated ASDF system depending on SYSTEM.
FILES, if provided, is loaded after the generated system successfully
loads.
USER, if true, provides only components to top-level user. 
"
  `(define-nyxt-user-system-and-load ,(gensym "NYXT-USER/")
     ,@(cond ((and user files)
              `(:components (,@files)))
             (files
              `(:depends-on (,system))
              `(:components (,@files)))
             (t
              `(:depends-on (,system))))))

(defextsystem #:nx-nord-theme)
(defextsystem #:keepassxc-pwi
  :user t
  :files ("keepassxc-pwi"
          "keepassxc-3431"))
(defextsystem #:nx-micros)
(defextsystem #:nx-code)


;;; Hacks

;; Borrowed from aartaka (see #:ref-1)
(defmethod files:resolve ((profile nyxt:nyxt-profile)
                          (file nyxt/mode/bookmark:bookmarks-file))
  "Re-route bookmarks to the `.config/nyxt/' directory."
  #P"/home/logoraz/.config/nyxt/bookmarks.lisp")

;; Hack to get rid of white echo-area (v4 pre-release 3)
(define-configuration browser
  ((window-make-hook
    (hooks:add-hook %slot-value% 
                    (lambda (_) (echo ""))))))


