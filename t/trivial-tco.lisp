#|
This file is a part of trivial-tco project.
Copyright (c) 2013 Ralph Möritz (ralph.moeritz@outlook.com)
|#

(in-package :trivial-tco-test)

(defsuite with-tail-call-optimization-suite ())

(deffixture with-tail-call-optimization-suite (@body)
  #+ (or sbcl allegro)
  (let ()
    (declare (optimize (speed 0) (space 0)))
    @body)
  #+ (or lispworks ccl)
  (let ()
    (declare (optimize (debug 3)))
    @body))

(deftest raw-code-causes-stack-overflow (with-tail-call-optimization-suite)
  (assert-condition serious-condition
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
