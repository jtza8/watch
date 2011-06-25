; Use of this source code is governed by a BSD-style
; license that can be found in the license.txt file
; in the root directory of this project.

(defpackage #:watch
  (:use :cl :cffi)
  (:export #:watch
           #:running-p
           #:parent
           #:start
           #:stop
           #:lap
           #:reset))