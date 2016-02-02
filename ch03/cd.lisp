(defvar *db* nil)

(defun make-cd (title artist rating ripped)
  (list :title title :artist artist :rating rating :ripped ripped))

;; ~{ => argument is a list, loop each element of a list
;; ~a => consume one argument and print
;; ~10t => emit spaces
;; ~} => end of loop
;; ~% => print newline
;; take one element of the list and print it and newline
(defun dump-db ()
  (dolist (cd *db*)
    (format t "~{~a:~10t~a~%~}~%" cd))) ; t=> *standard-output*

;; *query-io*: stdin
(defun prompt-read (prompt)
  (format *query-io* "~a: " prompt)
  (force-output *query-io*)
  (read-line *query-io*))

(defun prompt-for-cd ()
  (make-cd
   (prompt-read "Title")
   (prompt-read "Artist")
   (or (parse-integer (prompt-read "Rating") :junk-allowed t) 0)
   (y-or-n-p "Ripped [y/n]: ")))

(defun add-record (cd) (push cd *db*))

(defun add-cds ()
  (loop (add-record (prompt-for-cd))
     (if (not (y-or-n-p "Another? [y/n]: "))
         (return))))

(defun save-db (filename)
  (with-open-file (out filename :direction :output :if-exists :supersede)
    (with-standard-io-syntax (print *db* out))))

(defun load-db (filename)
  (with-open-file (in filename)
    (with-standard-io-syntax (setf *db* (read in)))))

(defun select-by-artist (artist)
  (remove-if-not #'(lambda (cd) (equal (getf cd :artist) artist))
                 *db*))

(load-db "./my-cds.db")

(select-by-artist "bbb")

(defun select (selector-fn)
  (remove-if-not selector-fn *db*))

(defun artist-selector (artist)
  #'(lambda (cd) (equal (getf cd :artist) artist)))

(defun foo (&key a b c) (list a b c))
(print (foo :a 1 :b 2 :c 3))
(print (foo :a 1 :c 4))

(defun foo2 (&key a (b 20) (c 30 c-p)) (list a b c c-p))
(print (foo2 :a 1 :b 2 :c 3))
(print (foo2 :a 1 :c 4))
(print (foo2 :a 1))
(print (foo2 :a 2 :c nil))
(print (foo2 :a 2 :c t))
(print (foo2))

(defun where (&key title artist rating (ripped nil ripped-p))
  #'(lambda (cd)
      (and
       (if title (equal (getf cd :title) title) t)
       (if artist (equal (getf cd :artist) artist) t)
       (if rating (equal (getf cd :rating) rating) t)
       (if ripped-p (equal (getf cd :ripped) ripped) t))))

(print (select (where :title "aaa")))
(print (select (where :title "aaa" :artist "bbb")))
(print (select (where :title "aaa" :rating 10)))
       
  
(defun update (selector-fn &key title artist rating (ripped nil ripped-p))
  (setf *db*
        (mapcar
         #'(lambda (row)
             (when (funcall selector-fn row)
               (if title (setf (getf row :title) title))
               (if artist (setf (getf row :artist) artist))
               (if rating (setf (getf row :rating) rating))
               (if ripped-p (setf (getf row :ripped) ripped)))
             row)
         *db*)))

(print (update (where :title "aaa" :rating 10) :rating 11))
(print (select (where :title "aaa" :rating 11)))

(defun delete-rows (selector-fn)
  (setf *db* (remove-if selector-fn *db*)))

(delete-rows (where :title "aaa" :rating 11))
(print *db*)

(defmacro backwards (expr) (reverse expr))
