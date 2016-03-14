

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

(defclass word-feature ()
  ((parsed-word
    :initarg :parsed-word
    :accessor parsed-word
    :initform (error "Must specify :word")
    :documentation "The word this feature represents.")
   (spam-count
    :initarg :spam-count
    :accessor spam-count
    :initform 0
    :documentation "Number of spam we've seen this feature.")
   (ham-count
    :initarg ham-count
    :accessor pam-count
    :initform 0
    :documentation "Number of ham we've seen this feature.")))
    
(defvar *feature-database* (make-hash-table :test #'equal))

(defun clear-database ()
    (setf *feature-database* (make-hash-table :test #'equal)))

(defun intern-feature (word)
  (or (gethash word *feature-database*)
      (setf (gethash word *feature-database*)
	    (make-instance 'word-feature :parsed-word word))))

;; cl-ppcre package should be installed before compile extract-words()
;; How to install cl-ppcre package via asdf
;; CL-USER> (ql:quickload :cl-ppcre)
(ql:quickload :cl-ppcre) ; load cl-ppcre package
(defun extract-words (text)
  (delete-duplicates
   (cl-ppcre:all-matches-as-strings "[a-zA-Z]{3,}" text)
   :test #'string=))

(print (extract-words "I am a boy you are a boy"))
(print (extract-words "foo bar baz foo bar"))

(defun extract-features (text)
  (mapcar #'intern-feature (extract-words text)))

;; add instances into database
(extract-features "foo bar baz foo bar")
(print *feature-database*)
(print (slot-value (gethash "foo" *feature-database*) 'parsed-word)) ; "foo"
(print (slot-value (gethash "bar" *feature-database*) 'parsed-word))
(print (slot-value (gethash "foo" *feature-database*) 'ham-count)) ; 0
(print (slot-value (gethash "foo" *feature-database*) 'spam-count))

(defun classify (text)
  (classification (score (extract-features text))))

