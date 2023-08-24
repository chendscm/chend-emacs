(require 'auto-save)
(require 'ws-butler)

(auto-save-enable)
(setq auto-save-silent t)

(ws-butler-global-mode)

(provide 'cd-auto-save)
