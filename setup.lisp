(require :sb-posix)

(defpackage #:nx-setup
  (:use #:cl)
  (:local-nicknames (#:u #:uiop)
                    (#:posix #:sb-posix))
  (:export #:setup)
  (:documentation "Script to setup Nyxt config."))

(in-package #:nx-setup)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Create Symlinks (SBCL only)

(defun create-symlink (source target &key force)
  "Create a symlink from SOURCE to TARGET.
If FORCE is true, remove existing file/symlink at TARGET first.
Returns T if symlink was created, NIL if it already existed and FORCE was nil."
  (let ((source-path (u:native-namestring (u:ensure-pathname source)))
        (target-path (u:native-namestring (u:ensure-pathname target))))
    (when (probe-file target-path)
      (if force
          (progn
            (format t "Removing existing file at: ~A~%" target-path)
            (delete-file target-path))
          (progn
            (format t "Skipping (already exists): ~A~%" target-path)
            (return-from create-symlink nil))))
    (format t "Creating symlink: ~A -> ~A~%" target-path source-path)
    (posix:symlink source-path target-path)
    t))

;; TODO: Refactor to take in a list of deps as opposed to just a string?
(defun install-ocicl-deps (deps dir)
  "Install ocicl dependencies (DEPS) for nxconfig."
  (u:run-program (concatenate 'string "ocicl install "
                              deps)
                 :directory dir
                 :output :string))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Nyxt Config Scaffolding

(defun setup (&key (force nil) (nyxt-binary-path #P"~/Work/builds/nyxt/nyxt"))
  "Setup Nyxt config by creating symlinks from the current directory.
If FORCE is true, replace existing symlinks/files.
NYXT-BINARY-PATH specifies where the nyxt executable is located."
  
  (format t "~%Setting up Nyxt configuration...~%~%")
  
  ;; Get the directory where this script is located (current working directory)
  (let ((config-dir (u:getcwd)))
    (format t "Using config directory: ~A~%~%" config-dir)
    
    ;; Ensure config target directories exist
    (ensure-directories-exist (u:xdg-config-home #P"nyxt/"))
    
    ;; Ensure Nyxt executable target directories exist
    (ensure-directories-exist (u:xdg-config-home #P"nyxt/ocicl/"))
    (ensure-directories-exist #P"~/.local/bin/")
    
    ;; Create symlinks for config files
    (create-symlink (merge-pathnames "config.lisp" config-dir)
                    (u:xdg-config-home #P"nyxt/config.lisp")
                    :force force)

    (create-symlink (merge-pathnames "nxconfig.asd" config-dir)
                    (u:xdg-config-home #P"nyxt/nxconfig.asd")
                    :force force)

    (create-symlink (merge-pathnames "version.sexp" config-dir)
                    (u:xdg-config-home #P"nyxt/version.sexp")
                    :force force)
    
    (create-symlink (merge-pathnames "source/" config-dir)
                    (u:xdg-config-home #P"nyxt/source")
                    :force force)

    (create-symlink (merge-pathnames "extensions/" config-dir)
                    (u:xdg-config-home #P"nyxt/extensions")
                    :force force)

    (create-symlink (merge-pathnames "assets/bookmarks.lisp" config-dir)
                    (u:xdg-config-home #P"nyxt/bookmarks.lisp")
                    :force force)
    
    (create-symlink (merge-pathnames "assets/nyxt.desktop" config-dir)
                    (u:xdg-data-home #P"applications/nyxt.desktop")
                    :force force)

    ;; Create symlink for nyxt binary
    (create-symlink nyxt-binary-path
                    #P"~/.local/bin/nyxt"
                    :force force)

    ;; Install nxconfig dependencies - see nxconfig.asd
    (install-ocicl-deps "micros slynk swank"
                        (u:xdg-config-home #P"nyxt/"))

    (format t "~%Setup complete!~%")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Run Setup

;; To force overwrite existing symlinks, use: (setup :force t)
;; To specify a different nyxt binary location:
;; (setup :nyxt-binary-path #P"/path/to/nyxt")
(setup)
(sb-ext:quit)
