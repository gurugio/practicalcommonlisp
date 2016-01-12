

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

(let ((p 2))
  ;; variable p:
  ;; start form (next-prime p)
  ;; step form (next-prime (+ 1 p)
  ;; end form (> p 19)
  (do ((p (next-prime p) (next-prime (+ 1 p))))
      ((> p 19))
    (format t "~d " p)))
     
(defmacro do-primes ((var start end) &body body)
  `(do ((,var (next-prime ,start) (next-prime (+ 1 ,var))))
       ((> ,var ,end))
     ,@body))

(do-primes (ppp 0 19) (format t "~d " ppp))
(print (macroexpand-1 '(do-primes (ppp 0 19) (format t "~d " ppp))))

(print (random 100))
(do-primes (p 0 (random 100)) (format t "~d " p))
;; random is called at every loop
(print (macroexpand-1 '(do-primes (p 0 (random 100)) (format t "~d " p))))

;; random is called once
(defmacro do-primes ((var start end) &body body)
  `(do ((ending-value ,end)
	(,var (next-prime ,start) (next-prime (+ 1 ,var))))
       ((> ,var ending-value))
     ,@body))
(do-primes (p 0 (random 100)) (format t "~d " p))
(print (macroexpand-1 '(do-primes (p 0 (random 100)) (format t "~d " p))))


;; solve leak of order of start and end	
(defmacro do-primes ((var start end) &body body)
  `(do ((,var (next-prime ,start) (next-prime (+ 1 ,var)))
	(ending-value ,end))
       ((> ,var ending-value))
     ,@body))
(do-primes (p 0 (random 100)) (format t "~d " p))
(print (macroexpand-1 '(do-primes (p 0 (random 100)) (format t "~d " p))))

;; following has naming leak
;; (DO ((ENDING-VALUE 10)
;;      (ENDING-VALUE (NEXT-PRIME 0) (NEXT-PRIME (+ 1 ENDING-VALUE))))
;;     ((> ENDING-VALUE ENDING-VALUE))
;;   (FORMAT T "~d " ENDING-VALUE)) 
(print (macroexpand-1
	'(do-primes (ending-value 0 10) (format t "~d " ending-value))))

;; (DO ((P (NEXT-PRIME 0) (NEXT-PRIME (+ 1 P)))
;;      (ENDING-VALUE 10))
;;     ((> P ENDING-VALUE))
;;   (INCF ENDING-VALUE P)
;;  ENDING-VALUE) 
(print (macroexpand-1
	(let ((ending-value 0))
	  '(do-primes (p 0 10) (incf ending-value p) ending-value))))


(defmacro do-primes ((var start end) &body body)
  (let ((ending-value-name (gensym)))
    `(do ((,var (next-prime ,start) (next-prime (+ 1 ,var)))
	  (,ending-value-name ,end))
	 ((> ,var ,ending-value-name))
       ,@body)))
(print (macroexpand-1
	'(do-primes (ending-vaue 0 10) (print ending-value))))
(print (macroexpand-1
	(let ((ending-value 0))
	  '(do-primes (p 0 10) (incf ending-value p) ending-value))))


(defmacro with-gensyms ((&rest names) &body body)
  `(let ,(loop for n in names collect `(,n (gensym)))
     ,@body))

(print (loop for n in '(a b c) collect `(,n (gensym))))
(print (macroexpand-1 '(with-gensyms (a b c) (body bodyy))))

(defmacro do-primes ((var start end) &body body)
  (with-gensyms (ending-value-name)
    `(do ((,var (next-prime ,start) (next-prime (+ 1 ,var)))
	  (,ending-value-name ,end))
	 ((> ,var ,ending-value-name))
       ,@body)))

(print (macroexpand-1
	'(do-primes (ending-vaue 0 10) (print ending-value))))
;; (DO ((ENDING-VAUE (NEXT-PRIME 0) (NEXT-PRIME (+ 1 ENDING-VAUE)))
;;      (#:G840 10))
;;     ((> ENDING-VAUE #:G840))
;;   (PRINT ENDING-VALUE))


  
