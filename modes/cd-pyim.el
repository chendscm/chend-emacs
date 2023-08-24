(require 'pyim)
(require 'pyim-basedict)

(pyim-basedict-enable)

;; 设置emacs默认输入法
(setq default-input-method "pyim")
;; 设置侯选词数
(setq pyim-page-length 10)

(pyim-default-scheme 'quanpin)

(global-set-key (kbd "c-\\") 'toggle-input-method)

(provide 'cd-pyim)
