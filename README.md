# trivial-tco

A Common Lisp library to assist in ensuring certain code is executed with tail
call optimizations enabled.

## Installation

```
cd ~/quicklisp/local-projects
git clone https://github.com/rmoritz/trivial-tco
```

## Usage

```common-lisp
(ql:quickload :trivial-tco)

(tco:with-tail-call-optimization ()
  (labels ((sum-aux (acc x)
             (if (zerop x)
                 acc
                 (sum-aux (+ acc x) (- x 1))))
           (sum (n)
             (sum-aux 0 n)))
    (sum 1000000)))
```

## Status

There is a small test suite that can be executed via `(ql:quickload
:trivial-tco-test)` or `(asdf:test-system :trivial-tco)`. I've only run it on
[CCL](http://ccl.clozure.com).

## Bugs

If you believe you've found a bug, please do
[report it](https://github.com/rmoritz/trivial-tco/issues).

## Author

* Ralph Möritz (ralphmoritz@outlook.com)

## License

Copyright (c) Ralph Möritz 2013.

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

**THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  SOFTWARE.**
