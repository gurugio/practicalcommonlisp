
(print (vector))
(print (vector 1))
(print (vector 1 2 3 4)) ; #(1 2 3 4)
(print #(1 2 3 4))

(print (make-array 5 nil)) ; error:odd number of &key arguments
;;; slime-helper detects make-array and print key arguments
(print (make-array 5 :initial-element 1))

(print (make-array 5 :fill-pointer 0)) ; #()

(defparameter *x* (make-array 5 :fill-pointer 0))
(print (vector-push 'a *x*)) ; 0
(print (vector-push 'b *x*)) ; 1
(print (vector-push 'c *x*)) ; 2
(print (vector-push 'd *x*)) ; 3
(print (vector-push 'e *x*)) ; 4
(print (vector-push 'f *x*)) ; nil
(print *x*) ; #(a b c d e)
(print (vector-pop *x*)) ; e
(print (vector-pop *x*)) ; d
(print (vector-pop *x*)) ; c
(print (vector-pop *x*)) ; b
(print (vector-pop *x*)) ; a
(print (vector-pop *x*)) ; error: There is nothing left to pop

(defparameter *xxx* (make-array 5 :fill-pointer 0 :adjustable t))
(print (vector-push 'a *xxx*)) ; 0
(print (vector-push 'b *xxx*)) ; 1
(print (vector-push 'c *xxx*)) ; 2
(print (vector-push 'd *xxx*)) ; 3
(print (vector-push 'e *xxx*)) ; 4
(print (vector-push 'f *xxx*)) ; nil
(print *xxx*) ; #(a b c d e)
(print (length *xxx*))
(print (elt *xxx* 0))
(print (elt *xxx* 1))
(print (elt *xxx* 2))
(print (elt *xxx* 3))
(setf (elt *xxx* 3) 'c)
(print *xxx*)
(print (vector-push-extend 'f *xxx*)) ; vector-push-extend!!!
(print (vector-push-extend 'g *xxx*))
(print *xxx*)
(print (count 'c *xxx*))
(print (remove 'f *xxx*))
(print *xxx*) ; f is not removed
(defparameter *xxx2* (remove 'f *xxx*))
(print *xxx2*) ; no f
(print (substitute 'i 'c *xxx*)) ; c->i
(print (find 'c *xxx*))
(print (position 'c *xxx*))
(print (vector-pop *xxx*)) ; pop is the same

(print (count "fff" #("fff" "bar" "baz") :test #'string=))
(print (find 'c #((a 10) (b 20) (c 30) (d 40)) :key #'first))

(defparameter *v* #((a 10) (b 20) (a 30) (b 40)))
(defun verbose-first (x) (format t "Looking at ~s~%" x) (car x))
(print (count 'a *v* :key #'verbose-first))
(print (count 'a *v* :key #'verbose-first :from-end t))

(print (count-if #'evenp #(1 2 3 4 5)))
(print (count-if #'evenp '(1 2 3 4 5))) ; What is different?
(print (count-if-not #'evenp #(1 2 3)))
(print (position-if #'digit-char-p "abcd0123"))
(print (remove-if-not #'(lambda (x) (char= (elt x 0) #\f))
		      #("foo" "bar" "baz" "foom")))

(print (count-if #'evenp #((1 a) (2 b) (3 c) (4 d) (5 e)) :key #'first))
(print (count-if-not #'evenp #((1 a) (2 b) (3 c) (4 d) (5 e)) :key #'first))
(print (remove-if #'alpha-char-p #("foo" "bar" "123a")
		  :key #'(lambda (x) (elt x 0))))
(print (remove-if-not #'alpha-char-p #("foo" "bar" "123a")
		      :key #'(lambda (x) (elt x 0))))

(print (copy-seq #(a b c)))
(print (reverse #(1 2 3 4 5 6)))
(print (concatenate 'vector #(1 2) '(3 4 5 6)))
(print (concatenate 'list #(1 2 3) '(5 6 7)))
(print (concatenate 'string "asdf" '(#\q #\w #\e)))

(print (sort (vector "aaa" "bbb" "ccc") #'string<))
(print (sort (vector "aaa" "bbb" "ccc") #'string>))

(print (merge 'vector #(1 3 5) #(2 4 6) #'<))
(print (merge 'string "ace" "bdf" #'string<))

;;; subsequence manipulation
(defparameter *x* (copy-seq "abcdefghijk"))
(setf (subseq *x* 3 6) "XXX")
(print *x*)

;;; sequence predicates
(print (every #'evenp #(2 4 6)))
(print (some #'evenp #(1 3 6)))
(print (notany #'evenp #(1 3 4)))
(print (notany #'evenp #(1 3 5)))
(print (notevery #'evenp #(1 3 4)))
(print (notevery #'evenp #(1 3 5)))

(print (every #'> #(2 3 4 5) #(1 2 3 4)))
(print (some #'> #(2 3 4 5) #(3 4 5 4)))

;;; sequence mapping functions
(print (map 'vector #'* #(1 2 3 4) #(10 20 30 40))) ; #(10 40 90 160)
(print (reduce #'+ #(1 2 3 4 5 6 7 8 9 10))) ; sum(1~10)
(print (reduce #'* #(2 2 2 2 2))) ; 2**5
(print (reduce #'max #(6 4 7 3 6 3 4 3 8 2 3 5 6 4))) ; find max val
(print (reduce #'max #(6 4 5 4 3 2 1 3 8 2 3 5 6 4) :start 3 :end 6))
(print (reduce #'max #(6 4 5 4 3 2 1 3 8 2 3 5 6 4)
	       :from-end t :start 3 :end 6))

;;; hash tables
(print (eql "asdf" "asdf"))
(print (equal "asdf" "asdf"))

(defparameter *h* (make-hash-table))
(print (gethash 'foo *h*))
(setf (gethash 'foo *h*) 'quuu)
(print (gethash 'foo *h*))

(defun show-value (key hash-table)
  (multiple-value-bind (value present) (gethash key hash-table)
    (if present
	(format nil "Value ~a actually present" value)
	(format nil "Value ~a not found" value))))
(setf (gethash 'bar *h*) nil)
(print (show-value 'foo *h*))
(print (show-value 'bar *h*))
(print (show-value 'no *h*))

(remhash 'bar *h*)
(print (show-value 'bar *h*))

(clrhash *h*)
(print (show-value 'foo *h*))

;;; hash table iteration
(setf (gethash 'foo *h*) 'quuu)
(setf (gethash 'bar *h*) 'xoxo)
(print (maphash #'(lambda (k v) (format t "~a => ~a~%" k v)) *h*))


