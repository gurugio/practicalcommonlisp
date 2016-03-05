

;; t => *standard-output*
(format t "blablabla")
(format *standard-output* "blablabla")
;; string is printed and return value is nil
(print (format *standard-output* "blablabla"))

(format nil "blabla") ; no print
(print (format nil "blabla")) ; but return valus is "blabla"


;;; format directives

(print pi) ;3.141592653589793d0
(format t "~$" pi) ; 3.14
(format t "~5$" pi)

(format t "~d" 10000000)
(format t "~:d" 10000000)
(format t "~@d" 10000000)
(format t "~@:d" 10000000)

;;; basic formatting

(format nil "value=~a" "foo")
(print (format nil "value=~a" nil)) ; "value=NIL"

(print (format nil "value=~s" "foo")) ; "value=\"foo\""

(format t "this~%~%~%is new-line") ; three new-lines
(format t "this~&~&~&is new-line") ; only one new-line


;;; character and integer directives

(format t "character: ~:c" #\a)

(format t "~9d" 1234)
(format t "~9d" 123456789)

(format t "~4d-~2,'0d-~2,'0d" 2016 3 5) ; 2016-03-05

(format t "0x~x" 1024)
(format t "~o" 1024)
(format t "~b" (- 1024 1))


;;; floting-point directives

(format t "~f" pi)
(format t "~,4f" pi)
(format t "~e" pi)
(format t "~,4e" (* pi 10000000000000)) ; 3.1416d+13


;;; English-language directives

(format t "~r" 1234)
(format t "~:r" 1234)

(format t "~@r" 1234) ; roman!!!
(format t "file~p" 10)
(format t "file~p" 1)

(format t "~r file~:p" 1)
(format t "~r file~:p" 10)
(format t "~r file~:p" 0)

(format t "~r famil~:@p" 1)
(format t "~r famil~:@p" 10)
(format t "~r famil~:@p" 0)

(format t "~a" "LARGE")
(format t "~(~a~)" "SMALL")


;;; conditional formatting

(format t "~[one~;two~;three~]" 0)
(format t "~[one~;two~;three~]" 1)
(format t "~[one~;two~;three~]" 2)
(format t "~[one~;two~;three~]" 3) ; ""

(format t "~[one~;two~:;three~]" 100)

; WHAT THE???
(defparameter *list-etc*
  "~#[NONE~;~a~;~a and ~a~:;~a, ~a~]~#[~; and ~a~:;, ~a, etc~].")
(format t *list-etc*) ;                ==> "NONE."
(format t *list-etc* 'a) ;             ==> "A."
(format t *list-etc* 'a 'b) ;          ==> "A and B."
(format t *list-etc* 'a 'b 'c) ;       ==> "A, B and C."
(format t *list-etc* 'a 'b 'c 'd) ;    ==> "A, B, C, etc."
(format t *list-etc* 'a 'b 'c 'd 'e) ; ==> "A, B, C, etc."


;; from chapter 9
(format t "~:[fail~;pass~]" t)
(format t "~:[fail~;pass~]" nil)

(format t "~@[x = ~a ~]~@[y = ~a~]" 10 20)
(format t "~@[x = ~a ~]~@[y = ~a~]" 10 nil)
(format t "~@[x = ~a ~]~@[y = ~a~]" nil 20)
(format t "~@[x = ~a ~]~@[y = ~a~]" nil nil)

;;; iteration

(format t "~{~a, ~}" '(1 2 3 4))
(format t "~{~a~^, ~}" '(1 2 3 4)) ; remove the last comma and space
(format t "~{~a~#[~;, and ~:;, ~]~}" '(1 2 3 4))
