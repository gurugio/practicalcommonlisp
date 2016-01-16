
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

(defmacro combine-results (&body body)
  (with-gensyms (result)
    `(let ((,result 
