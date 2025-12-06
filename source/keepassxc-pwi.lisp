(defpackage #:nxconfig/keepassxc-pwi
  (:use #:cl #:nyxt)
  (:import-from #:nyxt/mode/password
                #:keepassxc-interface
                #:password-mode)
  (:import-from #:password
                #:password-file
                #:key-file
                #:yubikey-slot)
  (:documentation "Nyxt Password Interface Configuration for KeepassXC"))

(in-package #:nxconfig/keepassxc-pwi)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Configure KeepassXC

;;; Note: KeepassXC integration not working with Nyxt 4

#+nil
(defvar *keepassxc-exe* (concatenate 'string
                                     "flatpak-spawn --host "
                                     "keepassxc-cli")
  "KeePassXC executable for password interface")

(defvar *keepassxc-db* "/home/logoraz/Documents/moses/keepassxc/p.kdbx")

(defvar *keepassxc-kf* "/home/logoraz/Documents/moses/keepassxc/pkf")

;; TODO: fix this default behavior, should only prompt if no keyfile is provided
;;       |--> submit PR when resolved...
(defvar *yubikey-slot* nil) ; set as `empty string' to avoid propmt

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Update KeepassXC internals

#+nil
(defmethod password::execute :before
    ((password-interface password:keepassxc-interface) (arguments list)
     &rest run-program-args &key &allow-other-keys)
  (declare (ignore arguments run-program-args))
  (echo "Modified before method for password::execute..."))


#+nil
(defmethod password:complete-interface
    ((password-interface password:keepassxc-interface))
  (loop :until (password:password-correct-p password-interface)
        :unless (and (password::password-file password-interface)
                     (string-equal "kdbx"
                                   (pathname-type
                                    (pathname (password::password-file
                                               password-interface)))))
          :do (setf (password::password-file password-interface)
                    (uiop:native-namestring
                     (prompt1
                      :prompt "Password database file (.kdbx)"
                      :extra-modes 'nyxt/mode/file-manager:file-manager-mode
                      :sources (make-instance 'nyxt/mode/file-manager:file-source
                                              :extensions '("kdbx")))))
        :unless (password::key-file password-interface)
          :do (if-confirm ("Do you use key file for password database locking?")
                          (setf (password::key-file password-interface)
                                (uiop:native-namestring
                                 (prompt1
                                  :prompt "Password database key file"
                                  :extra-modes 'nyxt/mode/file-manager:file-manager-mode
                                  :sources (make-instance
                                            'nyxt/mode/file-manager:file-source)))))
        :when (password::yubikey-slot password-interface)
          :do (if-confirm ("Do you use Yubikey for password database locking")
                          (setf (password::yubikey-slot password-interface)
                                (prompt1 :prompt "Yubikey slot[:port]"
                                         :sources (make-instance 'prompter:raw-source))))
        :do (setf (password::master-password password-interface)
                  (prompt1
                   :prompt
                   (format nil "Database password for ~a (leave empty if none)"
                           (password::password-file password-interface))
                   :sources 'prompter:raw-source
                   :height :fit-to-prompt
                   :invisible-input-p t))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Enable KeepassXC Interface

(defmethod initialize-instance :after ((interface keepassxc-interface)
                                       &key &allow-other-keys)
  (setf (password-file interface) *keepassxc-db*
        (key-file interface) *keepassxc-kf*
        (yubikey-slot interface) *yubikey-slot*))

(define-configuration password-mode
  ((password-interface (make-instance 'keepassxc-interface))))

(define-configuration buffer
  ((default-modes `(password-mode ,@%slot-value%))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; References
;;; 1. https://nyxt.atlas.engineer/documentation#keepassxc-support
;;; 2. https://github.com/aartaka/nyxt-config/tree/master
;;; 3. Look into `sera:resolve-executable'
;;;    (sera:resolve-executable "keepassxc-cli")
