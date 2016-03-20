

;;; I don't know how to use package system yet
;;; packages.lisp file includes all packages for spam
;; (load "packages.lisp")
;; (print (list-directory "/home/gurugio")) ; test including packages
;; (in-package :com.gigamonkeys.spam)

;;; compile
(load (compile-file "pathnames.lisp"))
(print (list-directory "/home/gurugio")) ; test including packages


;;; spam-filter starts



;;; TOP-DOWN approach
;;; classify is the most top function
(defun classify (text)
  (classification (score (extract-features text))))


(defparameter *max-ham-score* .4)
(defparameter *min-spam-score* .6)

;; top-down approach??
;; high score is spam
(defun classification (score)
  (values
   (cond
     ((<= score *max-ham-score*) 'ham)
     ((>= score *min-spam-score*) 'spam)
     (t 'unsure))
   score))

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
    :accessor ham-count
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

;; generic method to print newly added objects
(defmethod print-object ((object word-feature) stream)
  (print-unreadable-object (object stream :type t)
    (with-slots (parsed-word ham-count spam-count) object
      (format stream "~s :hams ~d: spam ~d" parsed-word ham-count spam-count))))
;; generic method print-object is invoked
;; when make-instance creates an instance of the class
;; and instance is passed to print
(print (make-instance 'word-feature :parsed-word "asdf"))
;;; example of generic method print-object
(defclass bank-account ()
  ((customer-name
    :initarg :customer-name)
   (balance
    :initarg :balance)))
(defmethod print-object ((object bank-account) stream)
  (print-unreadable-object (object stream :type t)
    (with-slots (customer-name balance) object
      (format stream "~s : ~d" customer-name balance))))
(make-instance 'bank-account :customer-name "dfs" :balance 999999)
(print (make-instance 'bank-account :customer-name "dfs" :balance 999999))


;; print newly added objects automatically
(print (extract-features "foo bar baz foo bar"))
(print (extract-features "aaa bbb ccc aaa ccc"))


;;; top-down approach
(defun train (text type)
  (dolist (feature (extract-features text))
    (increment-count feature type))
  (increment-total-count type))

(defun increment-count (feature type)
  (ecase type
    (ham (incf (ham-count feature)))
    (spam (incf (spam-count feature)))))

(defun test-ecase (k)
  (ecase k
    (asdf (print "asdf"))
    (qwer (print "qwer"))))
(test-ecase 'asdf) ; ecase use eql to compare
(test-ecase 'qwer)
(print (eql 'asdf 'asdf)) ; T
(print (eql "asdf" "asdf")) ; NIL

(defvar *total-spams* 0)
(defvar *total-hams* 0)

(defun increment-total-count (type)
  (ecase type
    (ham (incf *total-hams*))
    (spam (incf *total-spams*))))

(defun clear-database ()
  (setf
   *feature-database* (make-hash-table :test #'equal)
   *total-spams* 0
   *total-hams* 0))
   
(defun spam-probability (feature)
  (with-slots (spam-count ham-count) feature
    (let ((spam-frequency (/ spam-count (max 1 *total-spams*)))
          (ham-frequency (/ ham-count (max 1 *total-hams*))))
      (/ spam-frequency (+ spam-frequency ham-frequency)))))

;; (defun classify (text)
;;   (classification (score (extract-features text))))

(train "Make money fast" 'spam)
(print (spam-probability (gethash "Make" *feature-database*)))

;; get a list of feature and return point
(defun score (features)
  (let ((spam-count 0)
	(ham-count 0))
    (dolist (feature features)
      (if (> (spam-count feature) (ham-count feature)) (incf spam-count)
	  (incf ham-count)))
    (/ spam-count (+ spam-count ham-count))))
      
(print (score (extract-features "Make money fast")))


;;; training filter
(clear-database)
(train "Make money fast" 'spam)
(print (multiple-value-list (classify "Make money fast")))
(print (multiple-value-list (classify "Wanna go to the movies?")))
(train "Do you have any money for the movies?" 'ham)
(print (multiple-value-list (classify "Make money fast")))
(print (multiple-value-list (classify "Want to go to the movies?")))
(print (multiple-value-list (classify "Make money fail")))


;;; Testing the filter

(defun add-file-to-corpus (filename type corpus)
  (vector-push-extend (list filename type) corpus))

;;; A little bit boring... let's go next chapter
