(defvar *db* nil)

(defun make-cd (title artist rating ripped)
  (list :title title :artist artist :rating rating :ripped ripped))

(getf (make-cd "title" "abc" 1 0) :title)
(getf (make-cd "title" "abc" 1 0) :rating)

(push (make-cd "aaa" "bbb" 1 t) *db*)
(push (make-cd "fly" "dixie chicks" 8 t) *db*)

;; ~{ => argument is a list, loop each element of a list
;; ~a => consume one argument and print
;; ~10t => emit spaces
;; ~} => end of loop
;; ~% => print newline
;; take one element of the list and print it and newline
(defun dump-db ()
  (dolist (cd *db*)
    (format t "~{~a:~10t~a~%~}~%" cd))) ; t=> *standard-output*



