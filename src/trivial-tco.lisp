#|
  This file is a part of trivial-tco project.
  Copyright (c) 2013 Ralph Möritz (ralph.moeritz@outlook.com)
|#

(in-package :trivial-tco)

(defmacro with-tail-call-optimization ((&optional treat-warnings-as-errors) &body body)
  #+sbcl
  `(progn
     (declare (optimize (speed 3)))
     ,@body)
  #+ccl
  `(let ((saved-policy (ccl:current-compiler-policy))
         (new-policy (ccl:new-compiler-policy 
                      :allow-tail-recursion-elimination (lambda () t))))
     (unwind-protect
          (progn
            (ccl:set-current-compiler-policy new-policy)
            ,@body)
       (ccl:set-current-compiler-policy saved-policy)))
  #+lispworks
  `(progn
     (declare (optimize (debug 0)))
     ,@body)
  #+allegro
  `(let ((compiler:tail-call-non-self-merge-switch t)
         (compiler:tail-call-self-merge-switch t))
     ,@body)
  #-(or cmu sbcl ccl lispworks allegro)
  (let ((msg "Proper tail-call optimization is not available."))
    (if treat-warnings-as-errors
        (error msg)
        (progn 
          (warn msg)
          `(progn
             ,@body)))))


