

;;; slot specifiers

(defclass bank-account ()
  (customer-name
   balance))

;;; generate an instance of a class
;; #<BANK-ACCOUNT {BE13B99}> 
;; CL-USER> 
(print (make-instance 'bank-account))

(defparameter *account* (make-instance 'bank-account))
(setf (slot-value *account* 'customer-name) "gio")
(setf (slot-value *account* 'balance) 10000000000)

(print (slot-value *account* 'customer-name))
(print (slot-value *account* 'balance))

;;; object initialization

(defclass bank-account ()
  ((customer-name
    :initarg :customer-name)
   (balance
    :initarg :balance
    :initform 0)))

(defparameter *account*
  (make-instance 'bank-account
		 :customer-name "gioooo"
		 :balance 100000000000000))
(print (slot-value *account* 'customer-name))
(print (slot-value *account* 'balance))


;; howto use initform
(defvar *account-numbers* 0)

(defclass bank-account ()
  ((customer-name
    :initarg :customer-name
    :initform (error "must specify a customer name"))
   (balance
    :initarg :balance
    :initform 0)
   (account-number
    :initform (incf *account-numbers*))))

(defparameter *account*
  (make-instance 'bank-account
		 :balance 1000000000000000000)) ; generate error
(defparameter *account*
  (make-instance 'bank-account
		 :customer-name "giooooooo"
		 :balance 1000000000000000000)) ; ok
(print (slot-value *account* 'customer-name))
(print (slot-value *account* 'account-number)) ; 1

(defparameter *account2*
  (make-instance 'bank-account
		 :customer-name "giooooooo222"
		 :balance 2222222222222222222)) ; ok
(format t "~a:~a~%"
	(slot-value *account2* 'customer-name)
	(slot-value *account2* 'account-number)) ; 2
		 
    
