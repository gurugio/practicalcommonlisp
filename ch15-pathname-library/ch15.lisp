

;;; Listing directory

;; #P"/home/gurugio/*.*" 
(print (make-pathname :name :wild :type :wild :defaults "/home/gurugio/"))

(print (directory "/home/gurugio/*.*"))
(print (directory "/home/gurugio/"))
(print (directory "/home/gurugio"))
(print (directory "/home/gurugio/l*"))

;; Following is not /home/gurugio, but /home/*.*
;; because gurugio is not directory format.
(print (make-pathname :name :wild :type :wild :defaults "/home/gurugio"))


(defun component-present-p (value)
  (and value (not (eql value :unspecific))))

;; eg) p == /home/gurugio
;; (pathname-name p) => gurugio
;; (pathname-type p) -> nil
;; eg) p == /home/gurugio/
;; (pathname-name p) => nil
;; (pathname-type p) -> nil
(defun directory-pathname-p (p)
  (and
   (not (component-present-p (pathname-name p)))
   (not (component-present-p (pathname-type p)))
   p))
(print (directory-pathname-p "/home/gurugio")) ; nil
(print (directory-pathname-p "/home/gurugio/")) ; "/home/gurugio/"

(describe #'pathname) ; convert a string into a pathname object
(print (pathname "/dirname")) ; #P"/dirname"
(print (wild-pathname-p "/home/*")) ; (:WILD :WILD-INFERIORS)
(print (wild-pathname-p "/home/")) ; NIL
(print (pathname-directory "/home/gurugio/asdf")) ;(:ABSOLUTE "home" "gurugio")
(print (pathname-directory "/home/gurugio/")) ;(:ABSOLUTE "home" "gurugio")
(print (pathname-directory "/home/gurugio")) ;(:ABSOLUTE "home")

(defun pathname-as-directory (name)
  (let ((pathname (pathname name)))
    (when (wild-pathname-p pathname)
      (error "Can't convert wild pathnames"))
    (if (not (directory-pathname-p name))
	(make-pathname
	 :directory (append (or (pathname-directory pathname) (list :relative))
			    (list (file-namestring pathname)))
	 :name nil
	 :type nil
	 :defaults pathname)
	pathname)))
;; add "/" and convery string into pathname objects
(print (pathname-as-directory "/home/gurugio/"))
(print (pathname-as-directory "/home/gurugio"))
(print (pathname-as-directory "/home/gurugio/not-dir"))
(print (pathname-as-directory "not-dir"))
(print (pathname-as-directory "./not-dir"))
(print (pathname-as-directory "./not-dir/*")) ; error!


(defun directory-wildcard (dirname)
  (make-pathname
   :name :wild
   :type #-clisp :wild #+clisp nil
   :defaults (pathname-as-directory dirname)))
(print (directory-wildcard "/home/gurugio/"))
(print (directory-wildcard "/home/gurugio"))
(print (directory-wildcard "gurugio"))

(defun list-directory (dirname)
  (when (wild-pathname-p dirname)
    (error "Can only list concrete directory names"))
  (let ((wildcard (directory-wildcard dirname)))
    #+(or sbcl cmu lispworks) (directory wildcard)
    #+clisp (nconc
	     (directory wildcard)
	     (directory (clisp-subdirectories-wildcard wildcard)))
    #-(or sbcl cmu lispworks clisp) (error "Fuck dir")))
(print (list-directory "/home/gurugio/"))

#+clisp
(defun clisp-subdirectories-wildcard (wildcard)
  (make-pathname
   :directory (append (pathname-directory wildcard) (list :wild))
   :name nil
   :type nil
   :defaults wildcard))
    

;;; testing a file's existence

(print (probe-file "/home/gurugio/"))
(print (probe-file "/home/nodir/")) ; nil
(print (probe-file "/home/gurugio")) ; #P"/home/gurugio/"
(print (probe-file "/home/gurugio/.bashrc"))

(defun file-exists-p (pathname)
    #+(or sbcl lispworks openmcl) (probe-file pathname)
    #+clisp (or (ignore-errors (probe-file (pathname-as-file pathname)))
		(ignore-errors
		  (let ((directory-form (pathname-as-directory pathname)))
		    (when (ext:probe-directory directory-form)
		      directory-form))))
    #-(or sbcl lispworks openmcl clisp) (error "not implemented"))
		      
(defun pathname-as-file (name)
  (let ((pathname (pathname name)))
    (when (wild-pathname-p pathname)
      (error "Can't convert wild pathnames"))
    (if (directory-pathname-p name)
	(let* ((directory (pathname-directory pathname))
	       (name-and-type (pathname (first (last directory)))))
	  (print directory)
	  (print name-and-type)
	  (make-pathname
	   :directory (butlast directory)
	   :name (pathname-name name-and-type)
	   :type (pathname-type name-and-type)
	   :defaults pathname))
	pathname)))
	   
(print (pathname-as-file "/home/gurugio"))
(print (pathname-as-file "/home/gurugio/"))
	

;;; Walking a directory tree
(defun walk-directory (dirname fn &key directories (test (constantly t)))
  (labels
      ((walk (name)
	 (cond
	   ((directory-pathname-p name)
	    (when (and directories (funcall test name))
	      (funcall fn name))
	    (dolist (x (list-directory name)) (walk x)))
	   ((funcall test name) (funcall fn name)))))
    (walk (pathname-as-directory dirname))))
(walk-directory "/home/gurugio" #'print) ; do not run, takes long time
	    
