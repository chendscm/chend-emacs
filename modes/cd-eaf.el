(require 'eaf)
(require 'eaf-browser)
(require 'eaf-pdf-viewer)

;; Local proxy
;; (setq eaf-proxy-type "socks5")
;; (setq eaf-proxy-host "127.0.0.1")
;; (setq eaf-proxy-port "1080")

;; Make `eaf-browser-restore-buffers' restore last close browser buffers.
(setq eaf-browser-continue-where-left-off t)

(setq eaf-webengine-default-zoom 1.5)
(setq eaf-browser-aria2-proxy-host "127.0.0.1")
(setq eaf-browser-aria2-proxy-port "9888")
(setq eaf-browser-enable-adblocker nil)
(setq eaf-browser-enable-autofill t)
(setq eaf-webengine-font-family "WenQuanYi Micro Hei Mono")
(setq eaf-webengine-fixed-font-family "WenQuanYi Micro Hei Mono")
(setq eaf-webengine-serif-font-family "TsangerJinKai03-6763")
(setq eaf-webengine-font-size 18)
(setq eaf-webengine-fixed-font-size 18)

(provide 'cd-eaf)
