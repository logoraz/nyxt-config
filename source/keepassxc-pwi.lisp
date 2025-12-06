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
(defvar *yubikey-slot* "") ; set as `empty string' to avoid propmt

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
