(in-package #:nyxt-user)

(defun make-search-engine (name shortcut control-url)
  "Construtor function for class search-engine for slots:
:NAME, :SHORTCUT, and :CONTROL-URL."
  (make-instance 'search-engine
                 :name name
                 :shortcut shortcut
                 :control-url control-url))

(defvar *search-engines-list*
  '(("Google"      "ggl" "https://www.google.com/?q=~A") ; I know - using the King of evils...
    ("GitHub"      "ghb" "https://github.com/search?q=~A&type=repositories")
    ("Codeberg"    "cbg" "https://codeberg.org/explore/repos?q=~A&only_show_relevant=true&sort=recentupdate")
    ("Fedora Pkgs" "fpk" "https://packages.fedoraproject.org/search?query=~A")
    ("CL NovaSpec" "nvs" "https://novaspec.org/cl/")) ; For now ignore query text and just bring up NovaSpec...
  "List of search engines defined for make-search-engine constructor.")

(define-configuration browser
  "Configure BROWSER class."
  ((search-engines ; TODO: create keybinding for `query-selection-in-search-engine
    (append (mapcar (lambda (engine) (apply #'make-search-engine engine))
                    *search-engines-list*)
            %slot-default%))
   (window-make-hook ; Hack to get rid of white echo-area (v4 pre-releases)
    (hooks:add-hook %slot-value% 
                    (lambda (_) (echo ""))))))

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

(defextsystem keepassxc-pwi
  :config t
  :files ("keepassxc-pwi"))
(defextsystem nx-nord-theme)
(defextsystem nx-lis)
(defextsystem nx-code)


;;; Hacks

;; Borrowed from aartaka
(defmethod files:resolve ((profile nyxt:nyxt-profile)
                          (file nyxt/mode/bookmark:bookmarks-file))
  "Re-route bookmarks to the `.config/nyxt/' directory."
  #P"/home/logoraz/.config/nyxt/bookmarks.lisp")

