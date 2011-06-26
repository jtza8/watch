; Use of this source code is governed by a BSD-style
; license that can be found in the license.txt file
; in the root directory of this project.

(in-package :watch)

(define-foreign-library rt
  (:unix "librt.so"))
(use-foreign-library rt)

(defcstruct timespec
  (sec :uint32)
  (nsec :long))

(defcenum clock-id
  (:realtime 0)
  (:monotonic 1)
  #+linux
  (:monotonic-raw 4)
  (:process-cputime-id 2)
  (:thread-cputime-id 3))

(defcfun (clock-get-time "clock_gettime") :int
  (clock-id clock-id) (timespec :pointer))

(defun get-time ()
  (with-foreign-object (spec 'timespec)
    (clock-get-time :monotonic spec)
    (with-foreign-slots ((sec nsec) spec timespec)
      (+ (* sec 1000000000) nsec))))