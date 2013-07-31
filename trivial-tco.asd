#|
  This file is a part of trivial-tco project.
  Copyright (c) 2013 Ralph Möritz (ralph.moeritz@outlook.com)
|#

(in-package :cl-user)
(defpackage trivial-tco-asd
  (:use :cl :asdf))
(in-package :trivial-tco-asd)

(defsystem trivial-tco
  :version "0.1"
  :author "Ralph Möritz"
  :license "MIT"
  :components ((:module "src"
                :serial t
                :components
                ((:file "package")
                 (:file "trivial-tco"))))
  :description "A library to assist in ensuring certain code is executed with tail call optimizations enabled."
  :long-description
  #.(with-open-file (stream (merge-pathnames
                             #p"README.md"
                             (or *load-pathname* *compile-file-pathname*))
                            :if-does-not-exist nil
                            :direction :input)
      (when stream
        (let ((seq (make-array (file-length stream)
                               :element-type 'character
                               :fill-pointer t)))
          (setf (fill-pointer seq) (read-sequence seq stream))
          seq))))
