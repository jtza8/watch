; Use of this source code is governed by a BSD-style
; license that can be found in the license.txt file
; in the root directory of this project.

(in-package :watch)

(defclass watch-test (test-case)
  ())

(def-test-method test-watch ((test watch-test))
  ())