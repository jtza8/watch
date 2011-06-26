; Use of this source code is governed by a BSD-style
; license that can be found in the license.txt file
; in the root directory of this project.

#-(or unix win32)
(error "Your platform is not supported.")

#+(and unix (not darwin))
(eval-when (:load-toplevel :execute)
  (asdf:operate 'asdf:load-op 'cffi-grovel))

(asdf:defsystem "watch"
  :author "Jens Thiede"
  :license "BSD-style"
  :depends-on ("cffi")
  :serial t
  :components ((:file "package")
               #+darwin
               (:file "osx-time")
               #+(and unix (not darwin))
               (:file "unix-time")
               #+win32
               (:file "windows-time")
               (:file "watch")))
