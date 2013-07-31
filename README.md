# trivial-tco

A library to assist in ensuring certain code is executed with tail call
optimizations enabled.

## Installation

```
cd ~/quicklisp/local-projects
git clone https://github.com/ralph-moeritz/trivial-tco
```

## Usage

```common-lisp
(defun fib (n)
  (labels ((fib-aux (n x y)
             (if (zerop n)
                 x
                 (fib-aux (1- n) y (+ x y)))))
    (fib-aux n 0 1)))

(tco:with-tail-call-optimization ()
  (fib 40))
```

## Status

Barely tested.

## Bugs

I'm not aware of any bugs, but if you believe you've found one, please do
[report it](https://github.com/ralph-moeritz/bt-semaphore/issues).

## Author

* Ralph Möritz (ralph.moeritz@outlook.com)

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
