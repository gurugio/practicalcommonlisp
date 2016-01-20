
(defun report-result (result form)
  (format t "~:[FAIL~;pass~] ... ~a~%" result form))

(report-result (= (+ 1 2) 3) '(= (+ 1 2) 3))
(report-result (= (+ 1 2) 4) '(= (+ 1 2) 4))


(defmacro check (&body forms)
  `(progn
     ,@(loop for f in forms collect `(report-result ,f ',f))))

(print (macroexpand-1 '(check (= (+ 1 2) 3) (= (+ 1 2) 4))))
;; (PROGN
;;  (REPORT-RESULT (= (+ 1 2) 3) '(= (+ 1 2) 3))
;;  (REPORT-RESULT (= (+ 1 2) 4) '(= (+ 1 2) 4))) 

(check
  (= (+ 1 2) 3)
  (= (+ 1 2) 4)
  (= (- 3 2) 1))

(defun report-result (result form)
  (format t "~:[FAIL~;pass~] ... ~a~%" result form)
  result)

(defmacro with-gensyms ((&rest names) &body body)
  `(let ,(loop for n in names collect `(,n (gensym)))
     ,@body))

(print (macroexpand-1 '(with-gensyms (result1 result2) (aaa) (bbb))))

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

(defmacro check (&body forms)
  `(combine-results
    ,@(loop for f in forms collect `(report-result ,f ',f))))
(print (macroexpand-1 '(check
			(= (+ 1 2) 3)
			(= (+ 1 2) 4)
			(= (- 3 2) 1))))
(print (macroexpand-1 '(combine-results
			(report-result (= (+ 1 2) 3) '(= (+ 1 2) 3)))))

;;--> not working
(LET ((#:G851 T) (aaa t))
  (print aaa)
  (print #:g851))

(LET ((res T))
  (UNLESS (REPORT-RESULT (= (+ 1 2) 3) '(= (+ 1 2) 3)) (SETF res NIL))
  res)
