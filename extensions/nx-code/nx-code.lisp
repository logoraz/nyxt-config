;;; Only for nxyt-4 or greater
(nyxt:define-package #:nx-code)
(in-package #:nx-code)

(defvar *locutus* "nx-code"
  "First contact from nx-code")

(define-command-global nx-code-first-contact (&optional (locutus *locutus*))
  "First Contact Command."
  (let* ((current-time (local-time:now))
         (current-day-as-string 
           (aref local-time:+day-names+
                 (local-time:timestamp-day-of-week current-time))))
    (echo "First Contact: ~a ~a." locutus current-day-as-string)))


;; Currently only java is available for Fedora 42
;; sudo dnf install libtree-sitter-java-devel (or libtree-sitter-java)

;; Load a language grammar
(treesitter:include-language "java")
(defvar *java-lang* (treesitter:make-language "java"))

;; parse to stringified node
#+(or)
(let ((parser (treesitter:make-parser :language *java-lang*)))
  (treesitter:node-string
   (treesitter:tree-root-node
    (treesitter:parser-parse-string parser "1+1;"))))

;; make a query
#+(or)
(line-up-first
 (treesitter:make-parser :language *java-lang*)
 (treesitter:parser-parse-string "int func() { return 0; return 1; }")
 (treesitter:tree-root-node)
 (treesitter:query "(return_statement) @x"))