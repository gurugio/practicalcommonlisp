
(defclass bank-account ()
  ((customer-name
    :initarg :customer-name
    :initform (error "must specify a customer name"))
   (balance
    :initarg :balance
    :initform 0)))

(defparameter *account*
  (make-instance 'bank-account
		 :customer-name "gioh"
		 :balance 1000000000000000000)) ; generate error
(print (slot-value *account* 'customer-name))
(setf (slot-value *account* 'balance) 999999999999)
(print (slot-value *account* 'balance))

;; define generic function
(defgeneric balance (account &key))

;; define method
(defmethod balance ((account bank-account) &key)
  (slot-value account 'balance))
(print (balance *account*)) ; get balance

;; define generic function to set customer-name
;; The name of function is 'LIST' of (setf customer-name)
(defgeneric (setf customer-name) (value account))
(defgeneric customer-name (account)) ; w/o &key

;; define method
;; The name of function should be "LIST of setf and customer-name"
(defmethod (setf customer-name) (value (account bank-account))
  (setf (slot-value account 'customer-name) value))
(defmethod customer-name ((account bank-account))
  (slot-value account 'customer-name))

(print (customer-name *account*))
;; How to call setf function = the same to normal setf function
(setf (customer-name *account*) "gioh222") ; change name
(print (customer-name *account*))

;; three slot options of DEFCLASS for generating reader/writer
(defclass bank-account ()
  ((customer-name
    :initarg :customer-name
    :initform (error "must specify a customer name")
    :reader customer-name         ; add reader
    :writer (setf customer-name)) ; add writer
   (balance
    :initarg :balance
    :initform 0
    :reader balance))) ; add reader


(defclass bank-account ()
  ((customer-name
    :initarg :customer-name
    :initform (error "must specify a customer name")
    :accessor customer-name) ; reader & writer
   (balance
    :initarg :balance
    :initform 0
    :reader balance))) ; add reader
(defparameter *account*
  (make-instance 'bank-account
		 :customer-name "gioh"
		 :balance 1000000000000000000)) ; generate error
;; no need to generic functions and define methods
(print (customer-name *account*))
(setf (customer-name *account*) "giohhhh")
(print (customer-name *account*))
(print (balance *account*))

;; documentation options
(defparameter *account-numbers* 0)
(defclass bank-account ()
  ((customer-name
    :initarg :customer-name
    :initform (error "Must supply a customer name")
    :accessor customer-name
    :documentation "Customer's name")
   (balance
    :initarg :balance
    :initform 0
    :reader balance
    :documentation "Current account balance")
   (account-number
    :initform (incf *account-numbers*)
    :reader account-number
    :documentation "Account number, unique within a bank")
   (account-type
    :reader account-type
    :documentation "Type of account, one of :gold, :silver or :bronze")))
(defmethod initialize-instance :after ((account bank-account) &key)
  (let ((balance (balance *account*)))
    (setf (slot-value account 'account-type)
	  (cond
	    ((>= balance 100000) :gold)
	    ((>= balance 50000)  :silver)
	    (t :bronze)))))
(defparameter *account*
  (make-instance 'bank-account
		 :customer-name "gioh"
		 :balance 1000000000000000000)) ; generate error
(print (customer-name *account*))
(print (balance *account*))
(print (account-number *account*))
(print (account-type *account*))
(setf (customer-name *account*) "giohhhhhhhhhhhhhhhhhh")
(print (customer-name *account*))
