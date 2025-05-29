;; see nyxt/source/package.lisp (line 90)
(defpackage #:nx-code/core/base
  (:nicknames #:nx-code)
  (:use #:cl 
        #:nyxt
        #:alexandria-2)
  (:import-from #:treesitter
                #:include-language
                #:make-language
                #:node-string
                #:tree-root-node
                #:parser-parse-string
                #:make-parser
                #:query)
  (:export))

(in-package #:nx-code/core/base)

(defvar *locutus* "nx-code"
  "First contact from nx-code")

(define-command-global nx-code-first-contact (&optional (locutus *locutus*))
  "First Contact Command."
  (let* ((current-time (local-time:now))
         (current-day-as-string 
           (aref local-time:+day-names+
                 (local-time:timestamp-day-of-week current-time))))
    (echo "First Contact: ~a ~a." locutus current-day-as-string)))


;;; cl-treesitter example for now to test it out

;; Load a language grammar
;; Currently only java is available for Fedora 42
;; sudo dnf install libtree-sitter-java-devel (or libtree-sitter-java)
(treesitter:include-language "java")
(defvar *java-lang* (treesitter:make-language "java"))

;; parse to stringified node
(let ((parser (treesitter:make-parser :language *java-lang*)))
  (treesitter:node-string
   (treesitter:tree-root-node
    (treesitter:parser-parse-string parser "1+1;"))))

;; make a query
(line-up-first
 (treesitter:make-parser :language *java-lang*)
 (treesitter:parser-parse-string "int func() { return 0; return 1; }")
 (treesitter:tree-root-node)
 (treesitter:query "(return_statement) @x"))
