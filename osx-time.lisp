; Use of this source code is governed by a BSD-style
; license that can be found in the license.txt file
; in the root directory of this project.

(in-package :watch)

(eval-when (:compile-toplevel)
  (defcstruct timebase-info-data
    (numer :uint32)
    (denom :uint32))

  (defcfun (timebase-info "mach_timebase_info") :int
    (data :pointer)))

(defcfun (absolute-time "mach_absolute_time") :uint64)

(defmacro make-get-time ()
  (with-foreign-object (info 'timebase-info-data)
    (timebase-info info)
    (with-foreign-slots ((numer denom) info timebase-info-data)
      `(progn
         (declaim (inline get-time))
         (defun get-time ()
           ,(if (= numer denom)
                `(absolute-time)
                `(* (absolute-time) ,(float (/ numer denom)))))))))

(make-get-time)