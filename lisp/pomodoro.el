;;; pomodoro.el --- Pomodoro timer implementation -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(require 'environment)

(defun my/macos-notify (timer)
  "Custom notifications for tmr TIMER expiration on macOS.
The latter doesn't provide DBUS support and builtin notifications don't work."
  (let* ((description (or (tmr--timer-description timer) ""))
         (sanitized-body (substring-no-properties description))
         (script (format "display notification %S with title %S sound name %S"
                         sanitized-body
                         (format-time-string "Emacs TMR: %R" (tmr--timer-end-date timer))
                         "Hero")))
    (call-process "osascript" nil 0 nil "-e" script)))


;; 📦 TMR
;; Emacs package to set timers using a convenient notation.
(use-package tmr
  :straight t

  :config
  (keymap-global-set "C-c t" #'tmr-prefix-map)

  (setopt tmr-sound-file "/usr/share/sounds/freedesktop/stereo/alarm-clock-elapsed.oga"
          tmr-notification-urgency 'normal
          tmr-description-list 'tmr-description-history)

  (when os-macos
    (remove-hook 'tmr-timer-finished-functions #'tmr-notification-notify)
    (add-hook 'tmr-timer-finished-functions #'my/macos-notify))

  (tmr-mode-line-mode))

(provide 'pomodoro)
;;; pomodoro.el ends here
