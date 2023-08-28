;;* Start
(require 'cl-lib)

(tool-bar-mode -1)        ;禁用工具栏
(menu-bar-mode -1)        ;禁用菜单栏
(scroll-bar-mode -1)      ;禁用滚动条

(defun add-subdirs-to-load-path (search-dir)
  (interactive)
  (let* ((dir (file-name-as-directory search-dir)))
    (dolist (subdir
             ;; 过滤不必要的目录,提升Emacs启动速度
             (cl-remove-if
              #'(lambda (subdir)
                  (or
                   ;; 不是目录的文件都移除
                   (not (file-directory-p (concat dir subdir)))
                   ;; 父目录,语言相关和版本控制目录都移除
                   (member subdir '("." ".."
                                    "dist" "node_modules" "__pycache__"
                                    "RCS" "CVS" "rcs" ".git" ".github"))))
              (directory-files dir)))
      (let ((subdir-path (concat dir (file-name-as-directory subdir))))
        ;; 目录下有 .el .so .dll 文件的路径才添加到 `load-path' 中,提升Emacs启动速度
        (when (cl-some #'(lambda (subdir-file)
                           (and (file-regular-p (concat subdir-path subdir-file))
                                ;; .so .dll 文件指非ELisp语言编写的Emacs动态库
                                (member (file-name-extension subdir-file) '("el" "so" "dll"))))
                       (directory-files subdir-path))

          ;; 注意: `add-to-list' 函数的第三个参数必须为t,表示加到列表末尾
          ;; 这样Emacs会从父目录到子目录的顺序搜索Elisp插件,顺序反过来会导致Emacs无法正常启动
          (add-to-list 'load-path subdir-path t))

        ;;继续递归搜索子目录
        (add-subdirs-to-load-path subdir-path)))))

(defvar emacs-d
  (file-name-directory
   (or load-file-name (buffer-file-name))))
(add-subdirs-to-load-path emacs-d)
(add-to-list 'load-path emacs-d)

;;* Bootstrap
;;** autoloads
(load (concat emacs-d "loaddefs.el") nil t)

;;* Init
;; 加速配置
(require 'cd-accelerate)

;; 字体设置
(require 'cd-fonts)

;; (server-start nil)

;; hooks
(require 'hooks)

(let (
      ;; 加载的时候临时增大 `gc-cons-threshold'以加速启动速度
      (gc-cons-threshold most-positive-fixnum)
      (gc-cons-percentage 0.6)
      ;; 清空避免加载远程文件的时候分析文件
      (file-name-handler-alist nil))

  ;; 让窗口启动更平滑
  (setq frame-inhibit-implied-resize t)
  (setq-default inhibit-redisplay t
                inhibit-message t)
  (add-hook 'window-setup-hook
            (lambda ()
              (setq-default inhibit-redisplay nil
                            inhibit-message nil)
              (redisplay))))

(with-temp-message ""                   ;抹掉插件启动的输出
  ;; (require 'cd-exwm)
  (require 'init-fullscreen)

  (require 'init-generic)
  (require 'zen-theme)
  (load-theme 'zen t)
  ;; (require 'eclipse-theme)
  ;; (load-theme 'eclipse t)
  ;; (require 'lazy-load)

  (require 'cd-awesome-tray)
  (require 'cd-lsp-bridge)
  (require 'cd-auto-save)
  (require 'cd-pyim)
  ;;(require 'init-mode)

  ;; 可以延后加载的
  (run-with-idle-timer
   1 nil
   #'(lambda ()
       (require 'cd-eaf))))
