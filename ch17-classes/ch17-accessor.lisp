
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
;; The name of function should be LIST of setf and customer-name
(defmethod (setf customer-name) (value (account bank-account))
  (setf (slot-value account 'customer-name) value))
(defmethod customer-name ((account bank-account))
  (slot-value account 'customer-name))

(print (customer-name *account*))
;; How to call setf function = the same to normal setf function
(setf (customer-name *account*) "gioh222") ; change name
(print (customer-name *account*))
