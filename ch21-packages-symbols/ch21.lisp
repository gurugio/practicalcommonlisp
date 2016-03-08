
(defparameter *test-name* 1234)
(print (find-symbol "print"))
(print (find-symbol "*test-name*"))
(print (find-symbol "*TEST-NAME*")) ; LARGE characters
(print (find-symbol "PRINT"))

(print *package*)
(print common-lisp:*package*)
(print cl:*package*)

(print cl:*test-name*) ; error


;;; defining your own packages

(print *package*)
(defun hello-world () (print "hello-world"))
(hello-world)

(defpackage :com.gigamonkeys.email-db
  (:use :common-lisp))

(in-package :com.gigamonkeys.email-db)
(print *package*)
(defun hello-world () (print "hello-world from email-db"))
(hello-world)

(in-package :common-lisp-user)
(print *package*)
(hello-world)

(foo)
(use-package :com.gigamonkeys.email-db)
(defun foo () (print "foo"))
(foo)
(in-package :common-lisp-user)
(foo)
