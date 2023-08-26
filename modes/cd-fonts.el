(defun cd-set-font()
  (cond ((eq window-system 'pgtk)
         (set-face-attribute  'default nil :height 140 :family "WenQuanYi Micro Hei Mono"))
        (t
         (let ((emacs-font-size 14)
               (chinese-font-name "TsangerJinKai03-6763")
               english-font-name)
           (cond
             ((featurep 'cocoa)
              (setq english-font-name "Monaco"))
             ((string-equal system-type "gnu/linux")
              (setq english-font-name "WenQuanYi Micro Hei Mono")))
           (when (display-grayscale-p)
             (set-frame-font (format "%s-%s" (eval english-font-name) (eval emacs-font-size)))
             (set-fontset-font (frame-parameter nil 'font) 'unicode (eval english-font-name))

             (dolist (charset '(kana han symbol cjk-misc bopomofo))
               (set-fontset-font (frame-parameter nil 'font) charset (font-spec :family (eval chinese-font-name))))
             )))))

(cd-set-font)

;; This is hacking to fix Emacs 29 will decrease font after standby.
(add-function :after after-focus-change-function #'cd-set-font)

;; (dolist (hook (list
;;                'c-mode-common-hook
;;                'c-mode-hook
;;                'emacs-lisp-mode-hook
;;                'lisp-interaction-mode-hook
;;                'lisp-mode-hook
;;                'sh-mode-hook
;;                'makefile-gmake-mode-hook
;;                'python-mode-hook
;;                'css-mode-hook
;;                'web-mode-hook
;;                'markdown-mode-hook))
;;   (add-hook hook #'(lambda () (cd-set-font))))


;; (defun cd-set-font (&optional frame)
;;   (when frame
;;     (select-frame frame))
;;   (condition-case nil
;;       (set-frame-font
;;        "WenQuanYi Micro Hei Mono")
;;     (error
;;      (ignore-errors
;;        (set-frame-font
;; 	"Lucida Sans Typewriter")))))
;; (cd-set-font)
;; (set-face-attribute 'default nil :height 220)

(add-hook 'after-make-frame-functions 'cd-set-font)

(provide 'cd-fonts)
