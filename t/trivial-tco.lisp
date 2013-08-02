#|
  This file is a part of trivial-tco project.
  Copyright (c) 2013 Ralph Möritz (ralph.moeritz@outlook.com)
|#

(in-package :trivial-tco-test)

(defsuite with-tail-call-optimization-suite ())

(deffixture with-tail-call-optimization-suite (@body)
  #+sbcl
  (progn
    (declare (optimize (speed 0) (space 0)))
    @body)
  #+ccl
  (let ((saved-policy (ccl:current-compiler-policy))
        (new-policy (ccl:new-compiler-policy 
                     :allow-tail-recursion-elimination (lambda (_) nil))))
    (ccl:set-current-compiler-policy new-policy)
    (unwind-protect
          (progn
            @body)
      (ccl:set-current-compiler-policy saved-policy)))
  #+lispworks
  (progn
    (declare (optimize (debug 3)))
    @body)
  #+allegro
  (let ((compiler:tail-call-non-self-merge-switch nil)
        (compiler:tail-call-self-merge-switch nil))
    @body))

(deftest raw-code-causes-stack-overflow (with-tail-call-optimization-suite)
  (assert-condition condition
      (labels ((sum-aux (acc x)
                 (if (zerop x)
                     acc
                     (sum-aux (+ acc x) (- x 1))))
               (sum (n)
                 (sum-aux 0 n)))
        (sum 1000000))))

(deftest wrapped-code-evaluates-correctly (with-tail-call-optimization-suite)
  (assert-equal 500000500000
      (with-tail-call-optimization (t)
        (labels ((sum-aux (acc x)
                   (if (zerop x)
                       acc
                       (sum-aux (+ acc x) (- x 1))))
                 (sum (n)
                   (sum-aux 0 n)))
          (sum 1000000)))))

(run-suite 'with-tail-call-optimization-suite)
