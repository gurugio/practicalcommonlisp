
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
