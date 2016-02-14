;;; Combining recycling with shared structure
(defun upto (max)
  (let ((result nil))
    (dotimes (i max)
      (push i result))
    (nreverse result)))
(print (upto 10))

(defparameter *list-1* (list 1 2))
(defparameter *list-2* (list 3 4))
(defparameter *list-3* (append *list-1* *list-2*))
(print *list-1*)
(print *list-2*)
(print *list-3*)

(setf (first *list-2*) 0)
(print *list-2*) ; (0 4)
(print *list-3*)

(setf *list-3* (delete 4 *list-3*))
(print *list-3*) ; (1 2 0)
(print *list-2*) ; (0)

(setf *list-3* (remove 0 *list-3*))
(print *list-3*)
(print *list-2*) ; (0) now list-2 and list-3 are separated
(setf *list-3* (append *list-3* '(5 6)))
(print *list-3*)
(print *list-2*) ; still (0)

(defparameter *sort-list* (list 4 3 2 1))
(print (sort *sort-list* #'<)) ; sort returns (1 2 3 4)
(print *sort-list*) ; (3 4) but the original data is broken

;;; list-manipulation functions
(defparameter *list* '(1 2 3 4 5 6 7 8 9 10))
(print (first *list*))
(print (rest *list*))
(print (second *list*))
(print (third *list*))
(print (fourth *list*))
(print (nth 5 *list*)) ; 6
(print (nthcdr 5 *list*)) ; (6 7 8 9 10)
(setf (nth 5 *list*) 16)
(print *list*) ; 6->16
(setf (rest *list*) '(a b c d))
(print *list*) ; '(1 a b c d)
(print (consp *list*))

;;; mapping
(print (map 'list #'* '(1 2 3 4 5) '(1 2 3 4 5)))

;; return value of mapcar is the passed list
;; A 
;; B 
;; C 
;; "asdf" 
;; "qwer" 
;; (A B C "asdf" "qwer") 
(print (mapcar #'print '(a b c "asdf" "qwer")))

;; (1 2 3 4 5) 
;; (2 3 4 5) 
;; (3 4 5) 
;; (4 5) 
;; (5) 
(print (maplist #'print '(1 2 3 4 5)))

;; (1 2 3 4 5) 
(print (maplist #'(lambda (ll) (car ll))
		'(1 2 3 4 5)))

;; ((2 4 6 8 10) (4 6 8 10) (6 8 10) (8 10) (10)) 
(print (maplist #'(lambda (ll) (mapcar #'(lambda (x) (* 2 x)) ll))
		'(1 2 3 4 5)))


