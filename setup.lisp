(require 'asdf)
(require 'uiop)
(require 'sb-posix)

(eval-when (:load-toplevel :execute))

(defun setup ()
  "Thunk to setup Nyxt config utilizing extensions."

  ;; Ensure that ~/.local/share/nyxt directory exists
  (ensure-directories-exist (uiop:xdg-data-home #P"nyxt")
                            :mode #o700)
  
  ;; Symlink extensions dir to ~/.local/share/nyxt/extensions
  (sb-posix:symlink (uiop:xdg-config-home #P"nyxt/extensions")
                    (uiop:xdg-data-home #P"nyxt/extensions"))
  t)

(setup)
(sb-ext:quit)
