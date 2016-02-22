
;;; lookup tables: alists and plists

;; alists
(print (assoc 'a '((a . 1) (b . 2) (c . 3))))
(print (assoc 'a (list (cons 'a 1) (cons 'b 2) (cons 'c 3))))
(print (cdr (assoc 'a (list (cons 'a 1) (cons 'b 2) (cons 'c 3)))))
(print (assoc "a" '(("a" . 1) ("b" . 2) ("c" . 3)))) ; ("a" . 1)

(defparameter *alist* '((a . 1) (b . 2) (c . 3)))
(print *alist*)
(print (cons (cons 'f 5) *alist*))
(print *alist*) ; not changed
(acons 'f 5 *alist*) ; non-destructive
(print *alist*)
(push (cons 'f 5) *alist*) ; destructive
(print *alist*)

(print (pairlis '(a b c) '(1 2 3)))

;; plists
(defparameter *plist* ())
(setf (getf *plist* :a) 1)
(print *plist*)
(print (getf *plist* :a))
(setf (getf *plist* :a) 2)
(print (getf *plist* :a))
(remf *plist* :a)
(print *plist*)

(setf (getf *plist* :a) 1)
(print *plist*)
(setf (get :a 1) "information") ; set "information" information of symbol
(print *plist*)
(print (get :a 1)) ; return "information"

;;; destructuring-bind
(print (destructuring-bind (&key x y z) (list :x 1 :y 2 :z 3)
	 (+ x y z)))

(print (destructuring-bind (x y z) '(1 2 3)
	 (list :x x :y y :z z)))
(print (getf (destructuring-bind (x y z) '(1 2 3)
	       (list :x x :y y :z z)) :y)) ;2
(print (destructuring-bind (x y z) (list 1 2 3)
	 (list :x x :y y :z z)))

(print (destructuring-bind (x y z) '(1 (20 40) 3)
	 (list :x x :y y :z z))) ; wrong
(print (getf (destructuring-bind (x y z) '(1 (20 40) 3)
	       (list :x x :y y :z z)) :y))
(print (car (getf (destructuring-bind (x y z) '(1 (20 40) 3)
		   (list :x x :y y :z z)) :y)))

(print (getf (destructuring-bind (x y z) (list 1 (list 20 40) 3)
	       (list :x x :y y :z z)) :y)) ; return (20 40)
(print (car (getf (destructuring-bind (x y z) (list 1 (list 20 40) 3)
		    (list :x x :y y :z z)) :y))) ; return 20

(print (car (getf (destructuring-bind (x y z) '(1 (20 40) 3)
		    (list :x x :y y :z z)) :y)))
(print (destructuring-bind (x (y1 y2) z) (list 1 (list 2 20) 3)
	 (list :x x :y1 y1 :y2 y2 :z z)))

(print (destructuring-bind (x (y1 &optional y2) z) (list 1 (list 2 20) 3)
	 (list :x x :y1 y1 :y2 y2 :z z)))
(print (destructuring-bind (x (y1 &optional y2) z) (list 1 (list 2) 3)
	 (list :x x :y1 y1 :y2 y2 :z z)))

(print (destructuring-bind (&key x y z) (list :x 1 :y 2 :z 3)
	 (list :x x :y y :z z)))
(print (destructuring-bind (&key x y z) (list :z 1 :x 2 :y 3)
	 (list :x x :y y :z z)))

(print (destructuring-bind (&whole whole &key x y z) (list :z 1 :x 2 :y 3)
	 (list :x x :y y :z z :whole whole)))



