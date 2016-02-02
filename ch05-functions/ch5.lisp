(defun print-reverse-array (arr)
  (reverse arr))

(print (print-reverse-array '(1 2 3)))
(print (print-reverse-array 1))

(defun var-parameter (fir sec &rest others)
  (format t "FIRST:~a~%" fir)
  (format t "SECOND:~a~%" sec)
  (print others))

(format t "first:~a~%" "asdf")
(var-parameter "abc" "def")
(var-parameter "abc" "def" "ghi")
(var-parameter "abc" "def" "ghi" "qwe")

(defun foo-key (&key a b c) (list a b c))
(print (foo-key))
(print (foo-key :a 3))
(print (foo-key :b 4 :a 1))

(defun foo-key-default (&key (a 0) (b 0 b-supplied-p) (c (+ a b)))
  (list a b c b-supplied-p))

(print (foo-key-default :a 1))
(print (foo-key-default :b 1))
(print (foo-key-default :a 2 :b 3 :c 1))

(defun foo-key-rest (a b &rest rest &key k1 k2 k3)
  (list a b rest k1 k2 k3))

(print (foo-key-rest 1 2))
(print (foo-key-rest 1 2 :k1 '111))
(print (foo-key-rest 1 2 :k1 'aaa :k3 'bbb))
(print (foo-key-rest 1 2 :k1 'aaa :k3 'bbb :k2 'ccc))

(defun foo-return-from (n)
  (dotimes (i 10)
    (dotimes (j 10)
      (when (> (* i j) n)
	(return-from foo-return-from (list i j))))))
(print (foo-return-from 80))

(defun foo-dotimes ()
  (dotimes (i 10) (print i)))
(print (foo-dotimes))

(print (function foo-dotimes))
(print #'foo-dotimes)

(defun plot (fn min max step)
  (loop for i from min to max by step do
       (format t "i=~a count=~a" i (funcall fn i))
       (loop repeat (funcall fn i) do (format t "*"))
       (format t "~%")))

(plot #'exp 0 4 1/2)
(print (loop for i from 1 to 10 by 2 do
	    (print i)))
(print (loop repeat 4 do (format t "*")))

(apply #'plot '(exp 0 4 1/2))
(apply #'plot #'exp '(0 4 1/2))
			  
(print (apply #'(lambda (a b c) (+ a b c)) '(1 2 3)))
(print (apply (lambda (a b c) (+ a b c)) '(1 2 3)))
(apply #'plot (lambda (v) (* v v)) '(0 4 1/2))

(print (funcall (lambda (a) (* a a a)) 3))
;;(print (funcall '(lambda (a) (* a a a)) 3)) ;wrong



