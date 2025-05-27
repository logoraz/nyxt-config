(require 'asdf)
(require 'uiop)
(require 'sb-posix)

(eval-when (:load-toplevel :execute))

(defun dir-pathname (pathspec)
  "Converts the non-wild pathname designator PATHSPEC to directory form."
  (uiop:ensure-directory-pathname pathspec))

(defun ensure-dir (pathspec &key (mode #o700))
  "Ensure directory in PATHSPEC exists"
  (let ((dir (dir-pathname pathspec)))
    (ensure-directories-exist dir :mode mode)))

(defun create-symlink (src lnk)
  "Create a symlink for SRC to LINK."
  (let ((src-dir (dir-pathname src))
        (lnk-dir (dir-pathname lnk)))
    (sb-posix:symlink src-dir lnk-dir)
    lnk-dir))

(defun setup ()
  "Thunk to setup Nyxt config utilizing extensions."

  ;; Ensure that ~/.local/share/nyxt directory exists
  (ensure-dir (uiop:xdg-data-home #P"nyxt"))
  
  ;; Symlink extensions dir to ~/.local/share/nyxt/extensions
  (create-symlink (uiop:xdg-config-home #P"nyxt/extensions")
                   (uiop:xdg-data-home #P"nyxt/extensions"))
  t)

(setup)
(sb-ext:quit)
