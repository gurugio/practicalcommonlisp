
;;; packages.lisp file includes all packages for spam
(load "packages.lisp")

(print (list-directory "/home/gurugio")) ; test including packages

(in-package :com.gigamonkeys.spam)

(defun classify (text)
  (classification (score (extract-features text))))




