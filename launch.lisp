
(in-package #:cl-user)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (require :asdf))

(eval-when (:compile-toplevel :load-toplevel :execute)
  (asdf:operate 'asdf:load-op :pacontrol))

(pacontrol:run)
(quit)
