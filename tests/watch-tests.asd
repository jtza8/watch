; Use of this source code is governed by a BSD-style
; license that can be found in the license.txt file
; in the root directory of this project.

(asdf:defsystem "watch-tests"
  :author "Jens Thiede"
  :license "BSD-style"
  :depends-on ("watch" "xlunit")
  :serial t
  :components ((:file "package")
               (:file "watch-test")))