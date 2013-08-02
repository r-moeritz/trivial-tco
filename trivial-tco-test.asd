#|
  This file is a part of trivial-tco project.
  Copyright (c) 2013 Ralph Möritz (ralph.moeritz@outlook.com)
|#

(in-package :cl-user)
(defpackage trivial-tco-test-asd
  (:use :cl :asdf))
(in-package :trivial-tco-test-asd)

(defsystem trivial-tco-test
  :author "Ralph Möritz"
  :license "MIT"
  :depends-on (:trivial-tco
               :clunit)
  :components ((:module "t"
                :serial t
                :components
                ((:file "package")
                 (:file "trivial-tco"))))
  :perform (load-op :after (op c) (asdf:clear-system c)))
