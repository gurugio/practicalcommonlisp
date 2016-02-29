
;;; Generic functions and methods

(defgeneric withdraw (account amount)
  (:documentation "Withdraw the specified amount from the account.
Signal an error if the current balance is less than amount."))

(defmethod withdraw ((account bank-account) amount)
  (when (< (balance account) amount)
    (error "Account overdrawn"))
  (decf (balance account) amount)) ; increase amount

(defmethod withdraw ((account checking-account) amount)
  (let ((overdraft (- amount (balance account)))) ; check overdraft
    (when (plusp overdraft) ; if overdraft exists
      (withdraw (overdraft-account account) overdraft) ; withdraw from overdraft-account
      (incf (balance account) overdraft))) ; add overdraft into current bank-account
  (call-next-method)) ; go ahead into another method of back-account



