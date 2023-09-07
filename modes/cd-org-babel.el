(require 'org)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((shell . t)
   (python . t)
   (emacs-lisp . t)))

(provide 'cd-org-babel)
