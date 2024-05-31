(require 'pyim)
(require 'pyim-basedict)
(require 'posframe)

(pyim-basedict-enable)

;; 设置emacs默认输入法
(setq default-input-method "pyim")
;; 设置侯选词数
(setq pyim-page-length 8)
(setq-default pyim-punctuation-translate-p '(no)) ; 半角标点

(setq pyim-page-tooltip 'posframe)
(pyim-default-scheme 'quanpin)

(global-set-key (kbd "C-\\") 'toggle-input-method)

(provide 'cd-pyim)
