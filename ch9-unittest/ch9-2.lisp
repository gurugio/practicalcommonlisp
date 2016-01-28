
(defun report-result (result form)
  (format t "~:[FAIL~;pass~] ... ~a~%" result form)
  result)

(defmacro with-gensyms ((&rest names) &body body)
  `(let ,(loop for n in names collect `(,n (gensym)))
     ,@body))

(defmacro combine-results (&body forms)
  (with-gensyms (result)
    `(let ((,result t))
       ,@(loop for f in forms collect `(unless ,f (setf ,result nil)))
       ,result)))

(defmacro check (&body forms)
  `(combine-results
    ,@(loop for f in forms collect `(report-result ,f ',f))))

(defun test-+ ()
  (check
    (= (+ 1 2) 3)
    (= (+ 1 2 3) 6)
    (= (+ -1 -2) -3)))
(test-+) ; DO not return T
(print (test-+)) ; DO return T

(defun test-* ()
  (check
    (= (* 2 2) 4)
    (= (* 3 5) 15)))
(print (test-*))

(defun test-arithmetic ()
  (combine-results
    (test-+)
    (test-*)))
(print (test-arithmetic))
;; GOOOOOOD!!!
;; CL-USER> (test-arithmetic)
;; pass ... (= (+ 1 2) 3)
;; pass ... (= (+ 1 2 3) 6)
;; pass ... (= (+ -1 -2) -3)
;; pass ... (= (* 2 2) 4)
;; pass ... (= (* 3 5) 15)
;; T
;; CL-USER> 

;;;========== Better Result Reporting ================
(defvar *test-name* nil)

(defun report-result (result form)
  (format t "~:[FAIL~;pass~] ... ~a: ~a~%" result *test-name* form)
  result)

(defun test-+ ()
  (let ((*test-name* 'test-+))
    (check
      (= (+ 1 2) 3)
      (= (+ 1 2 3) 6)
      (= (+ -1 -2) -3))))

(defun test-* ()
  (let ((*test-name* 'test-*))
    (check
      (= (* 2 2) 4)
      (= (* 3 5) 15))))

(print (test-arithmetic))
;;;==================================================
