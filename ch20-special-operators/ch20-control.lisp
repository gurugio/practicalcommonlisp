
;; labels
(defparameter *nested-tree*
  '(((1) (2 3 (4 (5 6) (7 8)) (9) (((((10)) (11 (12 (13 (14 (15))) 17)))))))))
(defun collect-leaves (tree)
  (let ((leaves ()))
    (labels ((walk (tree)
	       (cond
		 ((null tree))
		 ((atom tree) (push tree leaves))
		 (t (walk (car tree))
		    (walk (cdr tree))))))
      (walk tree))
    (nreverse leaves)))
;; (1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 17)
(print (collect-leaves *nested-tree*))


;; return
(dotimes (i 10)
  (let ((answer (random 100)))
    (print answer)
    (if (> answer 70) (return))))

(tagbody
 top
   (print 'hello)
   (if (> 70 (random 100)) (go top)))

(tagbody
 a (print 'a) (if (zerop (random 2)) (go c))
 b (print 'b) (if (zerop (random 2)) (go a))
 c (print 'c) (if (zerop (random 2)) (go b))
   (print 'end))


;;; unwinding the stack

(defun foo ()
  (format t "Entering foo~%")
  (block a
    (format t "Entering block~%")
    (bar #'(lambda () (return-from a)))
    (format t "Leaving block~%"))
  (format t "Leaving foo~%"))

(defun bar (fn)
  (format t "  Entering bar~%")
  (baz fn)
  (format t "  Leaving bar~%"))

(defun baz (fn)
  (format t "    Entering baz~%")
  (funcall fn)
  (format t "    Leaving baz~%"))
(foo) ; winding call-stack and go out of block-a


;;; multiple values

;; values-list returns multiple values
;; but only the primary value is used
(print (values-list '(1 2))) ; 1
(print (apply #'values '(1 2))) ; 1

(print (+ (values-list '(1 2)) (values-list '(3 7)))) ; 4
(print (funcall #'+ (values-list '(1 2)) (values-list '(3 7)))) ; 4
(print (multiple-value-call #'+ (values-list '(1 2)) (values-list '(3 7)))) ; 13

;; values == values-list
(print (multiple-value-bind (a b) (values-list '(3 5)) (+ a b)))
(print (multiple-value-bind (a b) (values 3 5) (+ a b)))

;; multiple-values -> list
(print (multiple-value-list (values 1 2)))

;; list -> multiple-values
;; print function prints only the primary value
;; REPL can print both values
;; CL-USER> (values-list (multiple-value-list (values 1 2)))
;; 1
;; 2
(values-list (multiple-value-list (values 1 2)))

(defparameter *x* 0)
(defparameter *y* 0)
(print (floor (/ 57 34))) ; print 1 but actually multiple-values
(print (multiple-value-list (floor (/ 57 34)))) ; print (1 23/34)
(setf (values *x* *y*) (floor (/ 57 34)))
(print *x*)
(print *y*)
	
