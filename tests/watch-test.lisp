; Use of this source code is governed by a BSD-style
; license that can be found in the license.txt file
; in the root directory of this project.

(in-package :watch)

(defclass watch-test (test-case)
  ())

(def-test-method test-watch ((test watch-test))
  (let* ((watch-1 (make-instance 'watch))
         (watch-2 (make-instance 'watch :parent watch-1)))
    (assert-equal 0 (lap watch-1))
    (start watch-1)
    (sleep 0.01)
    (stop watch-1)
    (assert-true (< (- (lap watch-1) 10000000) 200000) "A")
    (assert-equal 0 (lap watch-2))
    (start watch-2)
    (assert-equal 0 (lap watch-2))
    (reset watch-1 t)
    (sleep 0.01)
    (stop watch-1)
    (assert-true (< (- (lap watch-1) 10000000) 200000) "B")
    (reset watch-1)
    (reset watch-2 t)
    (assert-equal 0 (lap watch-1))
    (start watch-1)
    (assert-not-eql 0 (lap watch-1))
    (reset watch-1 t)
    (sleep 0.01)
    (stop watch-1)
    (assert-true (< (- (lap watch-1) 10000000) 200000) "C")
    (assert-true (< (- (lap watch-2) 10000000) 200000) "D")))