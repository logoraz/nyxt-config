(defpackage :nxconfig/keepassxc-pwi
  (:use :cl :nyxt))
(in-package :nxconfig/keepassxc-pwi)


#+nil
(defvar *keepassxc-exe* (concatenate 'string
                                     "flatpak-spawn --host "
                                     "keepassxc-cli")
  "KeePassXC executable for password interface")

(defvar *keepassxc-db* "/home/logoraz/Documents/moses/keepassxc/p.kdbx")

(defvar *keepassxc-kf* "/home/logoraz/Documents/moses/keepassxc/pkf")

;; TODO: fix this default behavior, should only prompt if no keyfile is provided
;;       |--> submit PR when resolved...
(defvar *yubikey-slot* "") ; set as `empty string' to avoid propmt


(defmethod initialize-instance :after ((interface password:keepassxc-interface)
                                       &key &allow-other-keys)
  (setf (password:password-file interface) *keepassxc-db*
        (password:key-file interface) *keepassxc-kf*
        (password:yubikey-slot interface) *yubikey-slot*))

(define-configuration nyxt/mode/password:password-mode
  ((password-interface (make-instance 'password:keepassxc-interface))))


(define-configuration buffer
  ((default-modes `(nyxt/mode/password:password-mode ,@%slot-value%))))

;;; References
;;; 1. https://nyxt.atlas.engineer/documentation#keepassxc-support
;;; 2. https://github.com/aartaka/nyxt-config/tree/master
;;; 3. Look into `sera:resolve-executable'
;;;    (sera:resolve-executable "keepassxc-cli")
