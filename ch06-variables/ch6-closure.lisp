
;; let cannot do followings:
(let* ((x 10)
       (y (+ x 10)))
  (print x)
  (print y))

(let ((x 10))
  (let ((y (+ x 10)))
    (print x)
    (print y)))

(defun plot (fn min max step)
  (loop for i from min to max by step do
       (loop repeat (funcall fn i) do (format t "*"))
       (format t "~%")))

(plot #'exp 0 4 1/2)

(defun plot-func (a)
  (let ((count 1))
    (lambda(b) (setf count (+ a b count)))))

(apply #'plot (apply #'plot-func '(3)) '(0 4 1/2))

;; test for 'closure'
;;count is inside lambda form and binding to count is live
(print (apply (apply #'plot-func '(3)) '(0))) ;count=a+b+count=3+0+1=4
(print (apply (apply #'plot-func '(3)) '(1/2))) ;count=3+1/2+4=7.5
(print (apply (apply #'plot-func '(3)) '(1))) ;count=3+1+7.5=11.5
(print (apply (apply #'plot-func '(3)) '(3/2))) ;count is increased again...
(print (apply (apply #'plot-func '(3)) '(2)))
(print (apply (apply #'plot-func '(3)) '(3)))

(dolist (v '(1 2 3)) (print v))
	  
(dolist (fff (let ((count 0))
	       (list
		#'(lambda () (incf count) (print count))
		#'(lambda () (decf count) (print count))
		#'(lambda () count))))
  (apply fff '())) ; no argument -> '()

	 
