
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



