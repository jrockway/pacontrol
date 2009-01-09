(defpackage #:pacontrol-asd
  (:use :cl :asdf))

(in-package #:pacontrol-asd)

(defsystem pacontrol
  :name "pacontrol"
  :depends-on (cffi)
  :components ((:file "pacontrol")))
