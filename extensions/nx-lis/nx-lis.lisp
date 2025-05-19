;;; Only for nxyt-3 or greater
(nyxt:define-package :nx-lis)
(in-package :nx-lis)


(defvar *micros-port* 4006
  "Default Micros server port for Nyxt")

(defvar *slynk-port* 4006
  "Default Slynk server port for Nyxt")

(defvar *swank-port* 4006
  "Default Swank server port for Nyxt")



(define-command-global start-micros (&optional (micros-port *micros-port*))
    "Start a Micros server."
  (micros:create-server :port micros-port :dont-close t)
  (echo "Micros server started at port ~a" micros-port))

(define-command-global stop-micros (&optional (micros-port *micros-port*))
    "Stop current Micros server."
  (micros:stop-server micros-port)
  (echo "Closing Micros server at port ~a" micros-port))



(define-command-global start-slynk (&optional (slynk-port *slynk-port*))
  "Start a Slynk server."
  (slynk:create-server :port slynk-port :dont-close t)
  (echo "Slynk server started at port ~a" slynk-port))

(define-command-global stop-slynk (&optional (slynk-port *slynk-port*))
  "Stop current Slynk server."
  (slynk:stop-server slynk-port)
  (echo "Closing Slynk server at port ~a" slynk-port))



(define-command-global start-swank (&optional (swank-port *swank-port*))
  "Start a Swank server."
  (swank:create-server :port swank-port :dont-close t)
  (echo "Swank server started at port ~a" swank-port))

(define-command-global stop-swank (&optional (swank-port *swank-port*))
  "Stop current Swank server."
  (swank:stop-server swank-port)
  (echo "Closing Swank server at port ~a" swank-port))

