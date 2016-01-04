

(defun primep (number)
  (when (> number 1)
    (loop for fac from 2 to (isqrt number) never (zerop (mod number fac)))))

(defun next-prime (number)
  (loop for n from number when (primep n) return n))

(print (primep 5))
(print (primep 9))
(print (primep 17))
(print (next-prime 11))
(print (next-prime 15))
(print (next-prime 18))

(do ((p (next-prime p)) (next-prime (+ 1 p)))
    ((> p 19))
  (format t "~d ~d" p (next-prime (+ 1 p))))
     
