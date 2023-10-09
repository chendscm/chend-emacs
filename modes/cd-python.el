;; (require 'python)
;; (setq-default python-shell-interpreter "python3")

;; (require 'lpy)
;; (setq
;;    ;; python-shell-interpreter "/run/current-system/profile/bin/ipython"
;;    python-shell-interpreter "ipython"
;;    python-shell-interpreter-args ""
;;    python-shell-prompt-regexp "In \\[[0-9]+\\]: "
;;    python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
;;    python-shell-completion-setup-code
;;    "from IPython.core.completerlib import module_completion"
;;    python-shell-completion-module-string-code
;;    "';'.join(module_completion('''%s'''))\n"
;;    python-shell-completion-string-code
;;    "';'.join(get_ipython().Completer.all_completions('''%s'''))\n")

;;;###autoload
;; (defun cd-python-hook ()
;;   ;; (setq python-environment-virtualenv
;;   ;;       '("virtualenv" "--system-site-packages" "--quiet" "--python" "/run/current-system/profile/bin/ipython"))
;;   (python-mode)
;;   )

(defun cd-python-mode-config ()
  (setq
   ;; python-shell-interpreter "/run/current-system/profile/bin/ipython"
   python-shell-interpreter "ipython"
   python-shell-interpreter-args ""
   python-shell-prompt-regexp "In \\[[0-9]+\\]: "
   python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
   python-shell-completion-setup-code
   "from IPython.core.completerlib import module_completion"
   python-shell-completion-module-string-code
   "';'.join(module_completion('''%s'''))\n"
   python-shell-completion-string-code
   "';'.join(get_ipython().Completer.all_completions('''%s'''))\n")
  )

(add-hook 'python-mode-hook 'cd-python-mode-config)

(provide 'cd-python)
