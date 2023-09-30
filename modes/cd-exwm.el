(require 'exwm)

(setq exwm-workspace-number 4)

;; Use class names for all windows except for java applications and GIMP.
;; (add-hook 'exwm-update-class-hook
;; 	  ((lambda ()
;; 	     (unless (or (string-prefix-p "sun-awt-X11-" exwm-instance-name)
;; 			 (string= "gimp" exwm-instance-name))
;; 	       (exwm-workspace-rename-buffer exwm-class-name)))))
(add-hook 'exwm-update-title-hook
	  (lambda ()
	    (when (or (not exwm-instance-name)
		      (string-prefix-p "sun-awt-X11-" exwm-instance-name)
		      (string= "gimp" exwm-instance-name))
	      (exwm-workspace-rename-buffer exwm-title))))

(setq exwm-input-global-keys
      `(
	;; Bind "s-r" to exit char-mode and fullscreen mode.
	([?\s-r] . exwm-reset)
	;; Bind "s-w" to switch workspace interactive.
	([?\s-w] . exwm-workspace-switch)
	;; Bind "s-0" to "s-9" to switch to a workspace by its index.
	,@(mapcar (lambda (i)
		    `(,(kbd (format "s-%d" i)) .
		      (lambda ()
			(interactive)
			(exwm-workspace-switch-create ,i))))
		  (number-sequence 0 9))
	;; Bind "s-&" to launch applications
	([?\s-&] . (lambda (command)
		     (interactive (list (read-shell-command "$ ")))
		     (start-process-shell-command command nil command)))
	;; Bind	"s-<f2>" to "slock", a simple X display locker.
	([s-f2] . (lambda ()
		    (interactive)
		    (start-process "" nil "/usr/bin/slock")))))

;;* Multi screen
(require 'exwm-randr)

;;** Auto only enable the connected external screen
(defun exwm-change-screen-hook ()
  (let ((xrandr-output-regexp "\n\\([^ ]+\\) connected ")
	default-output)
    (with-temp-buffer
      (call-process "xrandr" nil t nil)
      (goto-char (point-min))
      (re-search-forward xrandr-output-regexp nil 'noerror)
      (setq default-output (match-string 1))
      (forward-line)
      (if (not (re-search-forward xrandr-output-regexp nil 'noerror))
	  (call-process "xrandr" nil nil nil "--output" default-output "--auto")
	(call-process
	 "xrandr" nil nil nil
	 "--output" (match-string 1) "--primary" "--auto"
	 "--output" default-output "--off")
	(setq exwm-randr-workspace-output-plist (list 0 (match-string 1)))))))

;;** Enable external screen
;; (setq exwm-randr-worksapce-output-plist '(0 "eDP"))

;; (defun exwm-change-screen-hook ()
;;   (start-process-shell-command
;;    "xrandr" nil "xrandr --output eDP --left-of HDMI-A-0 --auto"))

;;**
(add-hook 'exwm-randr-screen-change-hook 'exwm-change-screen-hook)
;;**
(exwm-randr-enable)

;;* Using xim input
;; (setenv "GTK_IM_MODULE" "xim")
;; (setenv "QT_IM_MODULE" "xim")
;; (setenv "XMODIFIERS" "@im=exwm-xim")
;; (setenv "CLUTTER_IM_MODULE" "xim")
(require 'exwm-xim)
(exwm-xim-enable)
(push ?\C-\\ exwm-input-prefix-keys)

;;*

(exwm-enable)

(provide 'cd-exwm)
