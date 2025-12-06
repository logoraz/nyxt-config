(defpackage #:nxconfig/browser
  (:use #:cl #:nyxt)
  (:import-from #:ice-dark
                #:*ice-dark-theme*)
  (:documentation "Configure base browser features for Nyxt."))

(in-package #:nxconfig/browser)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Browser Configuration

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

(define-configuration document-buffer
  ((keep-search-marks-p nil)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Theme Configuration

(define-configuration :browser
  ((theme *ice-dark-theme*)))

(define-configuration :status-buffer
  ((style (str:concat %slot-value%
                      (theme:themed-css (theme *browser*))))))

