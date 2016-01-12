
(defun report-result (result form)
  (format t "~:[FAIL~;pass~] ... ~a~%" result form))

(report-result (= (+ 1 2) 3) '(= (+ 1 2) 3))
(report-result (= (+ 1 2) 4) '(= (+ 1 2) 4))
