
(defun report-result (result form)
  (format t "~:[FAIL~;pass~] ... ~a~%" result form))

(report-result (= (+ 1 2) 3) '(= (+ 1 2) 3))
(report-result (= (+ 1 2) 4) '(= (+ 1 2) 4))


(defmacro check (&body forms)
  `(progn
     ,@(loop for f in forms collect `(report-result ,f ',f))))

(print (macroexpand-1 '(check (= (+ 1 2) 3) (= (+ 1 2) 4))))
;; (PROGN
;;   (REPORT-RESULT (= (+ 1 2) 3) '(= (+ 1 2) 3))
;;   (REPORT-RESULT (= (+ 1 2) 4) '(= (+ 1 2) 4)))

(check
  (= (+ 1 2) 3)
  (= (+ 1 2) 4)
  (= (- 3 2) 1))

(defun report-result (result form)
  (format t "~:[FAIL~;pass~] ... ~a~%" result form)
  result)
;; CL-USER> (report-result (= 1 2) '(= 1 2))
;; FAIL ... (= 1 2)
;; NIL
;; CL-USER> (report-result (= 2 2) '(= 2 2))
;; pass ... (= 2 2)
;; T

(defmacro with-gensyms ((&rest names) &body body)
  `(let ,(loop for n in names collect `(,n (gensym)))
     ,@body))
(print (macroexpand-1 '(with-gensyms (result1 result2) (aaa) (bbb))))
;; (LET ((RESULT1 (GENSYM)) (RESULT2 (GENSYM)))
;;   (AAA)
;;   (BBB)) 

(defmacro combine-results (&body forms)
  (with-gensyms (result)
    `(let ((,result t))
       ,@(loop for f in forms collect `(unless ,f (setf ,result nil)))
       ,result)))
(print (macroexpand-1 '(combine-results
			(= (+ 1 2) 3)
			(= (+ 1 2) 4)
			(= (- 3 2) 1))))
;; (LET ((#:G846 T))
;;   (UNLESS (= (+ 1 2) 3) (SETF #:G846 NIL))
;;   (UNLESS (= (+ 1 2) 4) (SETF #:G846 NIL))
;;   (UNLESS (= (- 3 2) 1) (SETF #:G846 NIL))
;;   #:G846) 

;; Basically above is equivalent to following.
(let ((aaa (gensym)))
  `(let ((,aaa t))
     (print ,aaa)))
;; Its value is another (LET ...) expression
(print (let ((aaa (gensym)))
	 `(let ((,aaa t))
	    (print ,aaa))))
;; (LET ((#:G853 T))
;;   (PRINT #:G853))
;; Evaluating it returns T
(eval (let ((aaa (gensym)))
	`(let ((,aaa t))
	   (print ,aaa))))


(defmacro check (&body forms)
  `(combine-results
    ,@(loop for f in forms collect `(report-result ,f ',f))))
(print (macroexpand-1 '(check
			(= (+ 1 2) 3)
			(= (+ 1 2) 4)
			(= (- 3 2) 1))))
;; (COMBINE-RESULTS
;;   (REPORT-RESULT (= (+ 1 2) 3) '(= (+ 1 2) 3))
;;   (REPORT-RESULT (= (+ 1 2) 4) '(= (+ 1 2) 4))
;;   (REPORT-RESULT (= (- 3 2) 1) '(= (- 3 2) 1))) 
(print (check
	 (= (+ 1 2) 3)
	 (= (+ 1 2) 4)
	 (= (- 3 2) 1))) ;; return NIL
(print (check
	 (= (+ 1 2) 3)
	 (= (- 3 2) 1))) ;; return T


;;--> not working
(LET ((bbb (gensym)) (aaa t))
  (print bbb)
  (print aaa))

(LET ((res T))
  (UNLESS (REPORT-RESULT (= (+ 1 2) 3) '(= (+ 1 2) 3)) (SETF res NIL))
  res)
