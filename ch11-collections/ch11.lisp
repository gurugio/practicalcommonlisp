
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
(print (vector-push-extend 'f *xxx*)) ; vector-push-extend!!!
(print (vector-push-extend 'g *xxx*))
(print *xxx*) ; #(A B C D E F G) 
(print (vector-pop *xxx*)) ; pop is the same



