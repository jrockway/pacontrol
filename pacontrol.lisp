(defpackage #:pacontrol
  (:use #:common-lisp #:cffi)
  (:export #:run))

(in-package #:pacontrol)

(define-foreign-library pulseaudio
  (:unix "libpulse.so.0"))

(use-foreign-library pulseaudio)

(defctype mainloop :pointer :int)
(defcfun ("pa_mainloop_new" %mainloop-new) mainloop)
(defcfun ("pa_mainloop_free" %mainloop-free) :void (handle mainloop))
(defcfun ("pa_mainloop_iterate" %mainloop-iterate) :int
  (mainloop mainloop)
  (block :int)
  (retval :pointer :int))

(defctype sample-spec :pointer)
(defcstruct pa-server-info
  (user-name :string)
  (host-name :string)
  (server-version :string)
  (server-name :string)
  (sample-spec sample-spec)
  (default-sink-name :string)
  (default-source-name :string)
  (cookie :uint32))

(defctype proplist :pointer)
(defcfun ("pa_proplist_to_string" %proplist-tostring) :string (p proplist))
(defcfun ("pa_xfree" %xfree) :void (thingie :pointer))

(defcstruct pa-client-info
  (index :uint32)
  (name :string)
  (owner-module :uint32)
  (driver :string)
  (proplist proplist))

(defun run nil
  (let ((mainloop (%mainloop-new))
        (return   (foreign-alloc :int :initial-element 42)))
    (%mainloop-iterate mainloop 0 return)
    (format t "got ~d ~%" (mem-ref return :int))
    (foreign-free return))
  (format t "It works! ~%"))
