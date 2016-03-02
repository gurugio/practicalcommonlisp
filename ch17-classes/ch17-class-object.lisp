

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
		 

;;; Usage :after, :before

(defparameter *account-numbers* 0)
(defclass bank-account ()
  ((customer-name
    :initarg :customer-name
    :initform (error "must specify a customer name"))
   (balance
    :initarg :balance
    :initform 0)
   (account-number
    :initform (incf *account-numbers*))
   account-type))

;; define after method on primary method initialize-instance
(defmethod initialize-instance :after ((account bank-account) &key)
  (let ((balance (slot-value account 'balance)))
    (format t "initialize-instance:after: ~a~%"
	    (slot-value account 'customer-name))
    (setf (slot-value account 'account-type)
	  (cond
	    ((>= balance 10000) :gold)
	    ((>= balance 5000)  :silver)
	    (t :bronze)))))

;; In :before method, bank-account cannot be accessed
(defmethod initialize-instance :before ((account bank-account) &key)
  (format t "initialize-instance:before:~a~%"
	  (slot-value account 'balance))) ; error at make-instance
(defmethod initialize-instance :before ((account bank-account) &key)
  (format t "initialize-instance:before:~%"))
  
;; initialize-instance is called by make-instance
;; No need to call initialize-instance explicitly
(defparameter *account-after*
  (make-instance 'bank-account
		 :customer-name "gio-after"
		 :balance 6000))
(print (slot-value *account-after* 'account-type))

;; around method remove :before and :after
;; only :around is called
(defmethod initialize-instance :around ((account bank-account) &key)
  (format t "initialize-instance:around:~a~%"
	  (slot-value account 'customer-name))) ; ERROR
(defmethod initialize-instance :around ((account bank-account) &key)
  (format t "initialize-instance:around:~%"))
  
(defparameter *account-around*
  (make-instance 'bank-account
		 :customer-name "gio-after"
		 :balance 6000))
(print (slot-value *account-around* 'customer-name)) ; ERROR
(print (slot-value *account-around* 'account-type)) ; ERROR


;;; &key parameter

(defparameter *account-numbers* 0)
(defclass bank-account ()
  ((customer-name
    :initarg :customer-name
    :initform (error "must specify a customer name"))
   (balance
    :initarg :balance
    :initform 0)
   (account-number
    :initform (incf *account-numbers*))
   account-type))

;; define after method on primary method initialize-instance
(defmethod initialize-instance :after ((account bank-account)
				       &key opening-bonus-percentage)
  (print "initialize-instance:after:key-para")
  (when opening-bonus-percentage
    (incf (slot-value account 'balance)
	  (* (slot-value account 'balance)
	     (/ opening-bonus-percentage 100)))))
(defparameter *account-keypara*
  (make-instance 'bank-account
		 :customer-name "gio-keypara"
		 :balance 6000
		 :opening-bonus-percentage 10))
(print (slot-value *account-keypara* 'balance))


