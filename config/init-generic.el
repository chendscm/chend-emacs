;; Restore emacs session.
(setq initial-buffer-choice t)
(run-with-timer 1 nil #'(lambda () (bury-buffer)))

;; 增加长行处理性能
(setq bidi-inhibit-bpa t)
(setq-default bidi-paragraph-direction 'left-to-right)

;; 增加IO性能
(setq process-adaptive-read-buffering nil)
(setq read-process-output-max (* 1024 1024))

(fset 'yes-or-no-p 'y-or-n-p)        ;以 y/n 代表 yes/no
(blink-cursor-mode -1)               ;指针不闪动
(transient-mark-mode 1)              ;标记高亮
(global-subword-mode 1)              ;Word移动支持 FooBar 的格式
(setq use-dialog-box nil)            ;never pop dialog
(setq inhibit-startup-screen t)      ;inhibit start screen
(setq initial-scratch-message "")    ;关闭启动空白buffer,这个buffer会干扰session恢复
(setq-default comment-style 'indent) ;设定自动缩进的注释风格
(setq ring-bell-function 'ignore)    ;关闭出错时的提示声
(setq default-major-mode 'text-mode) ;设置默认的主模式为TEXT模式
(setq mouse-yank-at-point t)         ;粘贴与光标处,而不是鼠标指针处
(setq x-select-enable-clipboard t)   ;支持emacs和外部程序的粘贴
(setq split-width-threshold nil)     ;分屏的时候使用上下分屏
(setq inhibit-compacting-font-caches t) ;使用字体缓存,避免卡顿
(setq confirm-kill-processes nil)    ;退出自动杀掉进程
(setq async-bytecomp-allowed-packages nil) ;避免magit报错
(setq word-wrap-by-category t)       ;按照中文折行
; (add-hook 'find-file-hook 'highlight-parentheses-mode t) ;增强的括号高亮

(setq completion-auto-select nil)    ;避免默认自动选择

(setq ad-redefinition-action 'accept) ;不要redefine warning

;; 平滑地进行半屏滚动大,避免滚动后recenter操作
(setq scroll-step 1
      scroll-conservatively 10000)

;; 不显示 *scratch*
(defun remove-scratch-buffer ()
  (if (get-buffer "*scratch*")
      (kill-buffer "*scratch*")))
(add-hook 'after-change-major-mode-hook 'remove-scratch-buffer)

;; Don't ask me when close emacs with process is running
; (defadvice save-buffers-kill-emacs (around no-query-kill-emacs activate)
;  "Prevent annoying \"Active process exist\" query when you quit Emacs."
;  (require 'noflet)
;  (noflet ((process-list ())) ad-to-it))

;; Don't ask me when kill process buffer
(setq kill-buffer-query-functions
      (remq 'process-kill-buffer-query-function
            kill-buffer-query-functions))

(provide 'init-generic)
