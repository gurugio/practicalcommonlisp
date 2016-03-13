

;;; I don't know how to use package system yet
;;; packages.lisp file includes all packages for spam
;; (load "packages.lisp")
;; (print (list-directory "/home/gurugio")) ; test including packages
;; (in-package :com.gigamonkeys.spam)

;;; compile
(load (compile-file "pathnames.lisp"))
(print (list-directory "/home/gurugio")) ; test including packages


;;; spam-filter starts

(defparameter *max-ham-score* .4)
(defparameter *min-spam-score* .6)

;; top-down approach??
;; high score is spam
(defun classification (score)
  (cond
    ((<= score *max-ham-score*) 'ham)
    ((>= score *min-spam-score*) 'spam)
    (t 'unsure)))

(defun classify (text)
  (classification (score (extract-features text))))




