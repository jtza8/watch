; Use of this source code is governed by a BSD-style
; license that can be found in the license.txt file
; in the root directory of this project.

(in-package :watch)

(defclass watch ()
  ((time-marker :initform nil)
   (run-time :initform 0)
   (running :initform nil :reader running-p)
   (parent :initform nil
           :initarg :parent
           :reader parent)
   (time-func :initform nil)))

(defmethod initialize-instance :after ((watch watch) &key)
  (with-slots (time-func parent) watch
    (setf time-func
          (if (null parent)
              #'get-time
              (lambda () (lap parent))))))

(defmethod start ((watch watch))
  (with-slots (time-marker time-func run-time running) watch
    (if running
        nil
        (setf time-marker (- (funcall time-func) run-time)
              running t))))

(defmethod stop ((watch watch))
  (with-slots (time-marker time-func run-time running) watch
    (if running
        (progn (setf run-time (- (funcall time-func) time-marker)
                     running nil)
               t)
        nil)))

(defmethod lap ((watch watch))
  (with-slots (time-marker time-func running run-time) watch
    (if running
        (- (funcall time-func) time-marker)
        run-time)))

(defmethod reset ((watch watch) &optional (auto-start nil))
  (with-slots (time-marker running run-time) watch
    (setf time-marker nil
          run-time 0
          running nil))
  (when auto-start
    (start watch)))