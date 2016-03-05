
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




  


   

	
