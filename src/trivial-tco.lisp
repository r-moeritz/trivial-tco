#|
  This file is a part of trivial-tco project.
  Copyright (c) 2013 Ralph Möritz (ralph.moeritz@outlook.com)
|#

(in-package :trivial-tco)

(defmacro with-tail-call-optimization ((&optional treat-warnings-as-errors) &body body)
  #+ (or sbcl allegro)
  `(let ()
     (declare (optimize (speed 3)))
     ,@body)
  #+ (or lispworks ccl)
  `(let ()
     (declare (optimize (debug 0)))
     ,@body)
  #- (or cmu sbcl ccl lispworks allegro)
  (let ((msg "Proper tail-call optimization is not available."))
    (if treat-warnings-as-errors
        (error msg)
        (progn 
          (warn msg)
          `(progn
             ,@body)))))
