(require 'awesome-tray)

(setq awesome-tray-active-modules '("location" "pdf-view-page" "belong" "file-path" "mode-name" "last-command" "battery" "date"))
(setq awesome-tray-separator "|")
(setq awesome-tray-date-format "%m-%d %H:%-M")

(awesome-tray-mode 1)

(provide 'cd-awesome-tray)
