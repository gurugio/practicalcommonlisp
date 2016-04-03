

(defun read-u2 (in)
  (let ((u2 0))
    (setf (ldb (byte 8 8) u2) (read-byte in))
    (setf (ldb (byte 8 0) u2) (read-byte in))
    u2))

(defun write-u2 (out value)
  (write-byte (ldb (byte 8 8) value) out)
  (write-byte (ldb (byte 8 0) value) out))
  
(defconstant +null+ (code-char 0))

(defun read-null-terminated-ascii (in)
  (with-output-to-string (s)
    (loop for char = (code-char (read-byte in))
       until (char= char +null+) do (write-char char s))))

(defun write-null-terminated-ascii (string out)
  (loop for char across string
     do (write-byte (char-code char) out))
  (write-byte (char-code +null+) out))

;;; Start to define macro genering id3-tag
;; (defclass id3-tag ()
;;   ((identifier    :initarg :identifier    :accessor identifier)
;;    (major-version :initarg :major-version :accessor major-version)
;;    (revision      :initarg :revision      :accessor revision)
;;    (flags         :initarg :flags         :accessor flags)
;;    (size          :initarg :size          :accessor size)
;;    (frames        :initarg :frames        :accessor frames)))

;;; from ch08
(defmacro with-gensyms ((&rest names) &body body)
  `(let ,(loop for n in names collect `(,n (gensym)))
     ,@body))


(define-bynary-class id3-tag
    ((file-identifier (iso-8859-1-string :length 3))
     (major-version u1)
     (revision u1)
     (flags u1)
     (size id3-tag-size)
     (frames (id3-frames :tag-size size))))

(defun as-keyword (sym) (intern (string sym) :keyword))

;;; get (name type) form and generate slot of class
;; (slot->defclass-slot '(major-version u1))
;; (MAJOR-VERSION :INITARG :MAJOR-VERSION :ACCESSOR MAJOR-VERSION)
(defun slot->defclass-slot (spec)
  (let ((name (first spec)))
    `(,name :initarg ,(as-keyword name) :accessor ,name)))

(defmacro define-binary-class (name slots)
  `(defclass ,name ()
     ,(mapcar #'slot->defclass-slot slots)))
(print (macroexpand-1
	'(define-binary-class id3-tag ((identifier u1) (major-version u1)))))
(print (macroexpand-1
	'(define-binary-class id3-tag
	  ((identifier      (iso-8859-1-string :length 3))
	   (major-version   u1)
	   (revision        u1)
	   (flags           u1)
	   (size            id3-tag-size)
	   (frames          (id3-frames :tag-size size))))))

(defun slot->read-value (spec stream)
  (destructuring-bind (name (type &rest args)) (normalize-slot-spec spec)
    `(setf ,name (read-value ',type ,stream ,@args))))

(defun normalize-slot-spec (spec)
  (list (first spec) (mklist (second spec))))

(defun mklist (x) (if (listp x) x (list x)))

(print (slot->read-value '(major-version u1) 'stream))


;;;
;;; macro generating class and read-value/write-value method at once
;;;
(defgeneric read-value (type stream &key)
  (:documentation "Read a value of the given type from the stream"))

(defgeneric write-value (type stream value &key)
  (:documentation "Write a value as the given type to the stream"))

(defun slot->read-value (spec stream)
  (destructuring-bind (name (type &rest args)) (normalize-slot-spec spec)
    `(setf ,name (read-value ',type ,stream ,@args))))

(defun slot->write-value (spec stream)
  (destructuring-bind (name (type &rest args)) (normalize-slot-spec spec)
    `(write-value ',type ,stream ,name ,@args)))

(defmacro define-binary-class (name slots)
  (with-gensyms (typevar objectvar streamvar)
    `(progn
       (defclass ,name ()
	 ,(mapcar #'slot->defclass-slot slots))
       
       (defmethod read-value ((,typevar (eql ',name)) ,streamvar &key)
	 (let ((,objectvar (make-instance ',name)))
	   (with-slots ,(mapcar #'first slots) ,objectvar
	     ,@(mapcar #'(lambda (x) (slot->read-value x streamvar)) slots))
	   ,objectvar))

       (defmethod write-value ((,typevar (eql ',name)) ,streamvar ,objectvar &key)
	 (with-slots ,(mapcar #'first slots) ,objectvar
	   ,@(mapcar #'(lambda (x) (slot->write-value x streamvar)) slots))))))


(print (macroexpand-1 '(define-binary-class id3-tag
			((identifier      (iso-8859-1-string :length 3))
			 (major-version   u1)
			 (revision        u1)
			 (flags           u1)
			 (size            id3-tag-size)
			 (frames          (id3-frames :tag-size size))))))
;; (PROGN
;;  (DEFCLASS ID3-TAG NIL
;;            ((IDENTIFIER :INITARG :IDENTIFIER :ACCESSOR IDENTIFIER)
;;             (MAJOR-VERSION :INITARG :MAJOR-VERSION :ACCESSOR MAJOR-VERSION)
;;             (REVISION :INITARG :REVISION :ACCESSOR REVISION)
;;             (FLAGS :INITARG :FLAGS :ACCESSOR FLAGS)
;;             (SIZE :INITARG :SIZE :ACCESSOR SIZE)
;;             (FRAMES :INITARG :FRAMES :ACCESSOR FRAMES)))
;;  (DEFMETHOD READ-VALUE ((#:G848 (EQL (QUOTE ID3-TAG))) #:G850 &KEY)
;;    (LET ((#:G849 (MAKE-INSTANCE 'ID3-TAG)))
;;      (WITH-SLOTS (IDENTIFIER MAJOR-VERSION REVISION FLAGS SIZE FRAMES)
;;          #:G849
;;        (SETF IDENTIFIER (READ-VALUE 'ISO-8859-1-STRING #:G850 :LENGTH 3))
;;        (SETF MAJOR-VERSION (READ-VALUE 'U1 #:G850))
;;        (SETF REVISION (READ-VALUE 'U1 #:G850))
;;        (SETF FLAGS (READ-VALUE 'U1 #:G850))
;;        (SETF SIZE (READ-VALUE 'ID3-TAG-SIZE #:G850))
;;        (SETF FRAMES (READ-VALUE 'ID3-FRAMES #:G850 :TAG-SIZE SIZE)))
;;      #:G849))
;;  (DEFMETHOD WRITE-VALUE ((#:G848 (EQL (QUOTE ID3-TAG))) #:G850 #:G849 &KEY)
;;    (WITH-SLOTS (IDENTIFIER MAJOR-VERSION REVISION FLAGS SIZE FRAMES)
;;        #:G849
;;      (WRITE-VALUE 'ISO-8859-1-STRING #:G850 IDENTIFIER :LENGTH 3)
;;      (WRITE-VALUE 'U1 #:G850 MAJOR-VERSION)
;;      (WRITE-VALUE 'U1 #:G850 REVISION)
;;      (WRITE-VALUE 'U1 #:G850 FLAGS)
;;      (WRITE-VALUE 'ID3-TAG-SIZE #:G850 SIZE)
;;      (WRITE-VALUE 'ID3-FRAMES #:G850 FRAMES :TAG-SIZE SIZE)))) 
	   
		      
