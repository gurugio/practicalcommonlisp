
(defmacro my-when (condition &rest body)
  `(if ,condition (progn ,@body)))

(when (> 3 2) (print "of ") (print "course"))
(my-when (> 3 2) (print "of ") (print "course"))

(defmacro my-when-wrong-body (condition &rest body)
  `(if ,condition (progn ,body)))

(print (macroexpand-1 '(my-when (> 3 2) (print "yes"))))

;; why @ is needed:
;;(IF (> 3 2)
;;    (PROGN ((PRINT "yes")))) 
(print (macroexpand-1 '(my-when-wrong-body (> 3 2) (print "yes"))))


(defmacro my-cond (&rest body)
  `(dolist (clause (quote ,body)) (print clause)))
			      

(my-cond ((> 1 2) (print "no"))
	 ((> 2 1) (print "yes")))


(print (macroexpand-1 '(my-cond
			((> 1 2) (print "no"))
			((> 2 1) (print "yes")))))


