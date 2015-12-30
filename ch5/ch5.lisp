(defun print-reverse-array (arr)
  (reverse arr))

(print (print-reverse-array '(1 2 3)))
(print (print-reverse-array 1))

(defun var-parameter (fir sec &rest others)
  (format t "FIRST:~a~%" fir)
  (format t "SECOND:~a~%" sec)
  (print others))

(format t "first:~a~%" "asdf")
(var-parameter "abc" "def")
(var-parameter "abc" "def" "ghi")
(var-parameter "abc" "def" "ghi" "qwe")
