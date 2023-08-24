(require 'lispy)

;;;###autoload
(defun cd-emacs-lisp-hook ()
  (ignore-errors
    (lispy-mode 1)))

(provide 'cd-elisp)
