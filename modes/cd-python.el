(require 'python)
(setq-default python-shell-interpreter "python3")

(require 'lpy)

;;;###autoload
(defun cd-python-hook ()
  (setq python-environment-virtualenv
        '("virtualenv" "--system-site-packages" "--quiet" "--python" "/usr/bin/python3"))
  (lpy-mode))

(provide 'cd-python)
