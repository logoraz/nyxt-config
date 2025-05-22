(defpackage :nxconfig/browser
  (:use :cl
        :nyxt)
  (:import-from :nkeymaps
                #:define-keyscheme-map))
(in-package :nxconfig/browser)


(defvar *search-engines-list*
  '(("Google" "ggl" "https://www.google.com/?q=~A") ; I know - using the King of evils...
    ("GitHub" "ghb" "https://github.com/search?q=~A&type=repositories")
    ("Codeberg" "cbg" "https://codeberg.org/explore/repos?q=~A&only_show_relevant=true&sort=recentupdate")
    ("Fedora Pkgs" "fpk" "https://packages.fedoraproject.org/search?query=~A")
    ("CL NovaSpec" "nvs" "https://novaspec.org/cl/")) ; For now ignore query text and just bring up NovaSpec...
  "List of search engines defined for make-search-engine constructor.")

(defun make-search-engine (name shortcut control-url)
  "Construtor function for class search-engine for slots:
:NAME, :SHORTCUT, and :CONTROL-URL."
  (make-instance 'search-engine
                 :name name
                 :shortcut shortcut
                 :control-url control-url))

(define-configuration browser
  ((search-engines ; TODO: create keybinding for `query-selection-in-search-engine
    (append (mapcar (lambda (engine) (apply #'make-search-engine engine))
                    *search-engines-list*)
            %slot-default%)
    :doc "Add personalized search engines, must define *search-engines-list
and constructor function `make-search-engines'.")))

(define-configuration buffer
  ((default-modes `(nyxt/mode/emacs:emacs-mode ,@%slot-value%)
     :doc "Apply Emacs mode for buffers")))

(define-configuration input-buffer
  ((default-modes `(nyxt/mode/emacs:emacs-mode ,@%slot-value%))
   (conservative-word-move t)))

(define-configuration web-buffer
  ((default-modes `(nyxt/mode/reduce-tracking:reduce-tracking-mode
                    nyxt/mode/blocker:blocker-mode
                    nyxt/mode/force-https:force-https-mode
                    ,@%slot-value%)
     :doc "Enable base modes for web-buffer class.")))

#+nil
(define-configuration document-buffer
  ((keep-search-marks-p nil)))

(define-configuration status-buffer 
  ((glyph-mode-presentation-p t)))

(define-configuration nyxt/mode/force-https:force-https-mode
  ((glyph "HTTPS")))

(define-configuration nyxt/mode/blocker:blocker-mode 
  ((glyph "block")))

(define-configuration nyxt/mode/reduce-tracking:reduce-tracking-mode 
  ((glyph "no-track")))

(define-configuration nyxt/mode/hint:hint-mode
  ((nyxt/mode/hint:show-hint-scope-p nil)
   (nyxt/mode/keyscheme::keyscheme-map
    (define-keyscheme-map "custom" (list :import %slot-value%)
      nyxt/keyscheme:emacs
      (list "M-f" 'nyxt/mode/hint:follow-hint)))))

(define-configuration nyxt/mode/autofill:autofill-mode
  ((nyxt/mode/autofill:autofills
    (list (nyxt/mode/autofill:make-autofill :name "Name"
                                            :fill "Erik Almaraz")
          (nyxt/mode/autofill:make-autofill :name "Email"
                                            :fill "erikalmaraz@fastmail.com")))))


#+ (or) ;; TODO - add blocked host list
(progn
  (defvar *blocked-hosts-list* "tbd")

  (define-configuration nyxt/mode/blocker:blocker-mode
    ((nyxt/mode/blocker:hostlists
      (append (list *my-blocked-hosts*) %slot-default%)
      :doc \"You have to define *my-blocked-hosts* first.\")))
  )

#+(or) ;; Keep for reference
(define-configuration search-buffer-mode
  ((keyscheme-map
    (keymaps:define-keyscheme-map "custom" (list :import %slot-value%)
      nyxt/keyscheme:emacs
      (list "C-f" 'nyxt/mode/search-buffer:search-buffer)))))
