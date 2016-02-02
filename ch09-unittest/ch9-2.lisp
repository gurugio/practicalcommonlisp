
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

;;; Each test prints the result, test name and equation.
;; CL-USER> (test-arithmetic)
;; pass ... TEST-+: (= (+ 1 2) 3)
;; pass ... TEST-+: (= (+ 1 2 3) 6)
;; pass ... TEST-+: (= (+ -1 -2) -3)
;; pass ... TEST-*: (= (* 2 2) 4)
;; pass ... TEST-*: (= (* 3 5) 15)
;; T
;; CL-USER> 


;;;========= An Abstraction Emerges ============
(defmacro deftest (name parameters &body body)
  `(defun ,name ,parameters
     (let ((*test-name* ',name))
       ,@body)))
(print (macroexpand-1 '(deftest test-+ ()
			(check (= (+ 1 2) 3) (= (+ 3 4) 6)))))
(deftest test-+ ()
  (check (= (+ 1 2) 3) (= (+ 2 3) 5)))
(print (test-+))

(deftest test-* ()
  (check (= (* 1 2) 2) (= (* 3 4) 12)))
(print (test-*))

;; high-level test-function can be defined with deftest
(deftest test-arithmetic ()
  (combine-results
    (test-+)
    (test-*)))
(print (test-arithmetic))


;;;========= A Hierarchy of Tests ==========
(defvar *test-name* nil)

(defmacro deftest (name parameters &body body)
  `(defun ,name ,parameters
     (let ((*test-name* (append *test-name* (list ',name))))
       ,@body)))
(print (macroexpand-1 '(deftest test-+ ()
			(check (= (+ 1 2) 3) (= (+ 3 4) 6)))))

;; The lowest test-function work the same.
(deftest test-+ ()
  (check (= (+ 1 2) 3) (= (+ 2 3) 5)))
(print (test-+))

(deftest test-* ()
  (check (= (* 1 2) 2) (= (* 3 4) 12)))
(print (test-*))

(deftest test-arithmetic ()
  (combine-results
    (test-+)
    (test-*)))
(print (test-arithmetic))
;;; include high-level test
;; CL-USER> (test-arithmetic)
;; pass ... (TEST-ARITHMETIC TEST-+): (= (+ 1 2) 3)
;; pass ... (TEST-ARITHMETIC TEST-+): (= (+ 2 3) 5)
;; pass ... (TEST-ARITHMETIC TEST-*): (= (* 1 2) 2)
;; pass ... (TEST-ARITHMETIC TEST-*): (= (* 3 4) 12)
;; T
;; CL-USER> 

(deftest test-math ()
  (test-arithmetic))


;;;======================================

;; test-+ is equivalent to following:
(let ((ret t))
  (unless (report-result (= (+ 1 2) 3) '(= (+ 1 2) 3)) (setf ret nil))
  (unless (report-result (= (+ 2 2) 4) '(= (+ 2 2) 4)) (setf ret nil))
  (unless (report-result (= (+ 3 2) 5) '(= (+ 3 2) 5)) (setf ret nil))
  (unless (report-result (= (+ 4 2) 6) '(= (+ 4 2) 6)) (setf ret nil))
  ret)
