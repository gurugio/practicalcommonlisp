(defvar *count* 0
  "count of something")

(defvar *uninit-count*)
(print *uninit-count*) ; unbound variable error

(defvar *x* 10)
(defun foo () (format t "X: ~d~%" *x*))

(defun bar ()
  (foo)
  (let ((*x* 20)) (foo))
  (foo))
(print (bar))

(defun foo2 ()
  (format t "Before assignment~18tX: ~d~%" *x*)
  (setf *x* (+ 1 *x*))
  (format t "After assignment~18tX: ~d~%" *x*))

(defun bar2 ()
  (foo2)
  (let ((*x* 20)) (foo2))
  (foo2))
(print (bar2))

(print (setf *count* 10))
(print (setf *x* (setf *count* 20)))
(print *x*)

(let ((a 3) (b 7) (c 11))
  (rotatef a b c)
  (format t "~a : ~a : ~a~%" a b c))

(let ((a 3) (b 7) (c 11))
  (format t "ret:~a~%" (shiftf a b c))
  (format t "~a : ~a : ~a~%" a b c))

