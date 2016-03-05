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

(defgeneric access-low-balance-penalty (account))
(defparameter *minimum-balance* 100)
(defmethod access-low-balance-penalty ((account bank-account))
  (with-slots (balance) account
    (when (< balance *minimum-balance*)
      (decf balance (* balance .01)))))
(access-low-balance-penalty *account*)
(print (balance *account*))
(setf (slot-value *account* 'balance) 50)
(access-low-balance-penalty *account*) ; -1%
(print (balance *account*)) ; 49.5

(defmethod access-name-cancel ((account bank-account))
  (with-accessors ((name-to-cancel customer-name)) account
    (setf name-to-cancel "canceled-customer")))
(access-name-cancel *account*)
(print (customer-name *account*)) ; "canceled-customer"
