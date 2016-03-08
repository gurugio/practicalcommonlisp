


;; 1:1
;; 2:2
;; 3:3
;; 4:4
(loop
   for num in '(1 2 3 4)
   for i from 1 to 10
   do (format t "~a:~a~%" num i))


(print (loop for i upto 10 collect i))
(print (loop for i from 3 upto 10 collect i))
(print (loop for i from 3 downto -10 collect i))
(loop repeat 3 do (print "repeat"))


(print (loop for i in '(1 2 3 4) by #'cdr collect i))
(print (loop for i in '(1 2 3 4) by #'cddr collect i))
(print (loop for i on '(1 2 3 4) collect i))
(print (loop for i on '(1 2 3 4) by #'cddr collect i))

(print (loop for c across "string" collect c))

(print (loop repeat 5
	  for x = 0 then y
	  for y = 1 then (+ x y)
	  collect y))
(print (loop repeat 5
	  for y = 1 then (+ x y)
	  for x = 0 then y
	  collect y))


(print (loop for (a b) in '((1 2) (3 4) (5 6))
	  do (format t "~a:~a~%" a b)))

(loop for cons on '(a b c d e f g)
   do (format t "~a" (car cons))
   when (cdr cons) do (format t ", "))
(loop for (item . rest) on '(a b c d e f g)
   do (format t "~a" item)
   when rest do (format t ", "))


(print (loop for i in '(1 2 3 4) append i)) ; error
(print (loop for i in '((1) (2) (3) (4)) append i)) ; (1 2 3 4)
(print (loop for i on '(1 2 3 4) append i)) ; (1 2 3 4 2 3 4 3 4 4) 

(defparameter *random* (loop repeat 100 collect (random 1000)))
(print *random*)
(print (loop for i in *random*
	  counting (evenp i) into evens
	  counting (oddp i) into odds
	  summing i into total
	  maximizing i into max
	  minimizing i into min
	  finally (return (list min max total odds evens))))


(loop
   for num in '(1 2 3 4)
   for i from 1 to 10
   do (progn
	(let ((s (+ num i)))
	  (format t "~a+~a=~a~%" num i s))))

(loop for i from 0 return 100)


(loop for i from 0 to 100
     do (if (evenp i) (print i)))

(print (loop for i from 0 to 100
	  when (evenp i) sum i))
(print (loop for i from 0 to 100
	  when (not (evenp i)) sum i))
(print (loop for i from 0 to 100
	  when (> i 0) sum i))

(loop for i from 1 to 100
   if (evenp i)
   minimize i into min-even and
   maximize i into max-even and
   unless (zerop (mod i 4))
   sum i into even-not-fours-total
   end
   and sum i into even-total
   do (format t "~a ~a ~a ~a~%" min-even max-even even-not-fours-total even-total))


(if (loop for n in '(2 4 6) always (evenp n))
    (print "all-even"))

(if (loop for n in '(2 4 6) never (oddp n))
    (print "all-even"))

(print (loop for ch across "abd123" thereis (digit-char-p ch)))
(print (loop for ch across "abd" thereis (digit-char-p ch)))



