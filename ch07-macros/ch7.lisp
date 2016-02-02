
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

(print (do ((n 0 (+ n 1))
	    (cur 0 next)
	    (next 1 (+ cur next)))
	   ((= 10 n) cur)
	 (format t "~a ~a ~a~%" n cur next)))

(do ((i 0 (+ i 1)))
    ((>= i 4))
  (print i))


(defvar *global-current-time* 0)

(defun current-time ()
  *global-current-time*)

(let ((future-time 15))
  (do ()
      ((> (current-time) future-time))
    (format t "Waiting~%")
    (sleep 5))
  (print "FINISH"))

;; repl and do are running concurrently
(setf *global-current-time* 10)
(setf *global-current-time* 15)
(setf *global-current-time* 20)

(let ((future-time 40))
  (loop (when (> (current-time) future-time) (return))
     (format t "Waiting:~a~%" future-time)
     (sleep 5)))
(setf *global-current-time* 45)
