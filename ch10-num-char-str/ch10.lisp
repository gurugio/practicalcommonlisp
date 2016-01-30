
;;; All are 10.
(print 10)
(print 20/2)
(print #xa)

;;; canonicalized
(print (= 3/4 6/8))
(print 3/4) ; 3/4
(print 6/8) ; 3/4

(print #x10) ; 16
(print #o10) ; 8
(print 2/-1) ; error
(print #b10101) ; 21
(print #12r10) ; 12
(print #16r10) ; 16
(print #10r10) ; 10

(print 2e3) ; 2000
(print 123e0) ; 123.0
(print .123) ; 0.123
(print 123e-3) ; 0.123
(print 123E-3) ; 0.123

(print (* #c(1 1) #c(1 -1))) ; (1+i)(1-i) = 2
(print (/ 1 3)) ; 1/3
(print (/ 10 2)) ; 5
(print (+ 3 (/ 1 3))) ; 10/3
(print (+ 1 2.0)) ; 3.0
(print (/ 2 3.0)) ; 0.6666667

(print (mod 21 4)) ; 1
(print (rem 21 4)) ; 1
(print (mod -21 4)) ; 3
(print (rem -21 4)) ; -1

(print (floor (/ 21 4))) ; 5
(print (floor (/ 22 4))) ; 5
(print (truncate (/ 21 4))) ; 5
(print (truncate (/ 22 4))) ; 5

(print (floor (/ -20 4))) ; -5
(print (floor (/ -21 4))) ; -6 round-down against 0
(print (floor (/ -22 4))) ; -6 round-down against 0

(print (truncate (/ -21 4))) ; -5 round-up to 0
(print (truncate (/ -22 4))) ; -5 round-up to 0

(defvar *x* 0)
(print (incf *x*)) ; 1
(print *x*) ; 1
(print (decf *x*)) ; 0
(print *x*) ; 0

(print (= 2 2.0 (* #c(1 1) #c(1 -1)))) ; T
(print (< 2 3 4)) ; t
(print (<= 2 2 3)) ; t
(print (>= 2 2 1)) ; t

(print (max 1 4 9 6 4 5 3 6 3 8)) ; 9
(print (min -12 -10 -9)) ; -12

;;; character equality
(print (char= 'a 'a)) ; error, not of type CHARACTER
(print (char= #\a #\a)) ; T
(print (char= #\space #\space)) ; T
(print (char= #\newline #\newline)) ; T
(print (char= #\a #\A)) ; nil
(print (char-equal #\a #\A)) ; T

;;; compare character
(print (char< #\a #\b)) ; T
(print (char<= #\a #\b #\b #\c)) ; T

;;; string
(print "foobar")
(print "foo\"bar") ; REPL shows "foo\"bar"
(print "foo\\bar") ; REPL shos "foo\\bar"
(format t "foo\"bar") ; foo"bar
(format t "foo\\bar") ; foo\bar

(print (string= "foobar" "foobar")) ; t
(print (string/= "foobar" "notfoobar")) ; 0
(print (string< "aaaa" "aaac")) ; 3 = length of aaa
(print (string< "aaaa" "aaaccc")) ; 3 = length of the same characters
(print (string< "aaac" "aaaa")) ; nil
(print (string<= "aaaa" "aaaa")) ; 4
(print (string<= "aaaa" "aaa")) ; nil
(print (string= "foobar" "bar" :start1 3 :end1 6)) ; t

(print (string= "asdf" "ASDF")) ; nil
(print (string-equal "asdf" "ASDF")) ; t

;;; length results the length of an array => string is also the array
(print (length "asdfasdf")) ; 8
(print (length '(a b c d))) ; 4
