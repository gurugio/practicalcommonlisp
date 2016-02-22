
;;; reading file data
(let ((in (open "../README.md")))
  (format t "~a~%" (read-line in))
  (close in))

(let ((in (open "./not-exist.txt" :if-does-not-exist nil)))
  (if in
      (progn
	(format t "~a~%" (read-line in))
	(close in))
      (print "file error")))
      
(defparameter *s* (open "~/practicalcommonlisp/ch14-files-file-io/s_expr.txt"))
(print (read *s*))
(print (read *s*))
(print (read *s*))
(print (read *s*)) ; error
(close *s*)









