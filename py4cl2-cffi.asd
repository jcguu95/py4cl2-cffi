(defsystem "py4cl2-cffi/config"
  :pathname #P"src/"
  :depends-on ("uiop")
  :serial t
  :components ((:file "config")))

(defsystem "py4cl2-cffi"
  :pathname #P"src/"
  :description "CFFI based alternative to PY4CL2, primarily developed for performance reasons."
  :author "Shubhamkar Ayare <shubhamayare@yahoo.co.in>"
  :license "MIT"
  :version "0.0.0" ; alpha
  :depends-on ("bordeaux-threads"
               "cffi"
               "uiop"
               "alexandria"
               "trivial-garbage"
               "iterate"
               "float-features"
               "split-sequence"
               "py4cl2-cffi/config")
  :serial t
  :components ((:file "package")
               (:static-file "py4cl-utils.c")
               (:file "shared-objects")
               (:static-file "libpychecks.so")
               (:file "numpy")
               (:file "features")
               (:file "pythonizers")
               (:file "python-process")
               (:file "lispifiers")
               (:file "callpython")
               (:file "arg-list")
               (:file "import-export"))
  :perform (test-op (o c)
             (declare (ignore o c))
             (handler-case (let ((system (asdf:find-system "py4cl2-tests/cffi")))
                             (asdf:test-system system))
               (asdf:missing-component (condition)
                 (declare (ignore condition))
                 (format *error-output* "Please find the tests at ~A~%"
                         "https://github.com/digikar99/py4cl2-tests")
                 (format *error-output*
                         "If you have already set up the tests, then something is wrong,
as asdf was unable to find \"py4cl2-tests/cffi\".")))))
