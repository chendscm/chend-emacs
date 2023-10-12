;;*
(global-set-key (kbd "C-x o") 'ace-window)

;;*
(defhydra hydra-one (:color pink
			    :hint nil
			    :foreign-keys run)
  "One"
  ("a" cd-move-beginning-of-line)
  ("h" backward-char)
  ("j" next-line)
  ("k" previous-line)
  ("l" forward-char)
  ("s" swiper)

  ("E" hydra-eaf/body :exit t)
  ("F" counsel-find-file "find-file" :exit t))

(define-key global-map "," 'hydra-one/body)

;;* hydra
(defhydra hydra-eaf ()
  "eaf"
  (""))
