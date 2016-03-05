
;; example of defining condition
(define-condition malformed-log-entry-error (error)
  ((text :initarg :text :reader text)))


