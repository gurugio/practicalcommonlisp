
;;; load files including packages for spam package
(load "pathnames.lisp")

;;; define spam package
(defpackage :com.gigamonkeys.spam
  (:use :common-lisp :com.gigamonkeys.pathnames))
