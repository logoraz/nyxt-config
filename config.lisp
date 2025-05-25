(in-package #:nyxt-user)

(defvar *search-engines*
  (list
   (make-instance 'search-engine
                  :name "Google"
                  :shortcut "ggl"
                  :control-url
                  "https://www.google.com/?q=~a")
   (make-instance 'search-engine
                  :name "DDG"
                  :shortcut "ddg"
                  :control-url
                  "https://duckduckgo.com/?q=~a")
   (make-instance 'search-engine
                  :name "MDN"
                  :shortcut "mdn"
                  :control-url
                  "https://developer.mozilla.org/en-US/search?q=~a")))

(defun make-search-engine (name curl ))


(define-configuration browser
  ((search-engine-suggestions-p nil)
   (search-engines `(%slot-default% ,@*search-engines*))))

(define-configuration buffer
    ((default-modes `(nyxt/mode/emacs:emacs-mode ,@%slot-value%))))

(define-configuration input-buffer
  ((default-modes `(nyxt/mode/emacs:emacs-mode ,@%slot-value%))
   (conservative-word-move t)))

(define-configuration web-buffer
  ((default-modes `(nyxt/mode/reduce-tracking:reduce-tracking-mode
                    ;; TODO: configure NYXT/MODE/BLOCKER:HOSTLISTS %slot%
                    nyxt/mode/blocker:blocker-mode
                    nyxt/mode/force-https:force-https-mode
                    ,@%slot-value%))))

(define-configuration document-buffer
  ((keep-search-marks-p nil)))

(define-configuration prompt-buffer
  ((mouse-support-p nil)))

#+(or) ;; Keep for reference
(define-configuration search-buffer-mode
  ((keyscheme-map
    (keymaps:define-keyscheme-map "custom" (list :import %slot-value%)
      nyxt/keyscheme:emacs
      (list "C-f" 'nyxt/mode/search-buffer:search-buffer)))))

(define-configuration hint-mode
  ((nyxt/mode/hint:show-hint-scope-p nil)
   (keyscheme-map
    (keymaps:define-keyscheme-map "custom" (list :import %slot-value%)
      nyxt/keyscheme:emacs
      (list "M-f" 'nyxt/mode/hint:follow-hint)))))

(define-configuration autofill-mode
  ((nyxt/mode/autofill:autofills
    (list (nyxt/mode/autofill:make-autofill :name "Name"
                                            :fill "Erik Almaraz")
          (nyxt/mode/autofill:make-autofill :name "Email"
                                            :fill "erikalmaraz@fastmail.com")))))

(define-configuration status-buffer ((glyph-mode-presentation-p t)))
(define-configuration force-https-mode ((glyph "HTTPS")))
(define-configuration blocker-mode ((glyph "block")))
(define-configuration reduce-tracking-mode ((glyph "no-track")))


;;; Nyxt Extensions
;; Loads extentions from #P"~/.local/share/nyxt/extensions/"
;; TODO 1: Change extensions path to #P"$XDG_CONFIG_HOME/nyxt/extensions" 
;; |--> (default to #P"$XDG_DATA_HOME/nyxt/extensions").
;; |--> nyxt:describe-variable?variable=%1B%2Aextensions-directory%2A
;; |--> nyxt:*extensions-directory*
(defmacro defextsystem (system &key files config &allow-other-keys)
  "Helper macro to load configuration for extensions & user config files.
Loads a newly-generated ASDF system depending on SYSTEM.
FILES, if provided, is loaded after the generated system successfully
loads.
CONFIG, if true, provides only components to top-level user config. 
"
  `(define-nyxt-user-system-and-load ,(gensym "NYXT-USER/")
     ,@(cond ((and config files)
              `(:components (,@files)))
             (files
              `(:depends-on (,system))
              `(:components (,@files)))
             (t
              `(:depends-on (,system))))))

(defextsystem nx-nord-theme)
(defextsystem keepassxc-pwi
  :config t
  :files ("keepassxc-pwi"
          "keepassxc-3431"))
(defextsystem nx-lis)
(defextsystem nx-code)


;;; Hacks

;; Borrowed from aartaka
(defmethod files:resolve ((profile nyxt:nyxt-profile)
                          (file nyxt/mode/bookmark:bookmarks-file))
  "Re-route bookmarks to the `.config/nyxt/' directory."
  #P"/home/logoraz/.config/nyxt/bookmarks.lisp")

;; Hack to get rid of white echo-area (v4 pre-release 3)
(define-configuration browser
  ((window-make-hook
    (hooks:add-hook %slot-value% 
                    (lambda (_) (echo ""))))))

#+(or)
(defvar *my-search-engines*
  (list
   '("alp" "https://archlinux.org/packages/?q=~a" "https://archlinux.org/packages")
   '("alw" "https://wiki.archlinux.org/?search=~a" "https://wiki.archlinux.org")
   '("aur" "https://aur.archlinux.org/packages?K=~a" "https://aur.archlinux.org")
   '("yt"  "https://youtube.com/results?search_query=~a" "https://youtube.com")
   '("ytm" "https://music.youtube.com/search?q=~a" "https://music.youtube.com")
   '("ghb" "https://github.com/search?q=~a" "https://github.com/MaskedRedstonerProZ")
   '("glb" "https://gitlab.com/search?search=~a" "https://gitlab.com/MaskedRedstonerProZ")
   '("ddg" "https://duckduckgo.com/?q=~a" "https://duckduckgo.com"))
  "List of search engines.")

#+(or)
(define-configuration :browser ;;:context-buffer
  "Go through the search engines above and `make-search-engine' out of them."
  ((search-engines
    (append
     %slot-default%
     (mapcar (lambda (engine) (apply 'make-search-engine engine))
             *my-search-engines*))))
  )

;; Also, get the compiler warning: `<WARN> [20:55:33] Not found slot SEARCH-ENGINES in class CONTEXT-BUFFER, generating the wrapper method for configuration.` however, seems to run w/o warning when applied to class `browser` rather than `context-buffer` in `define-configuration`