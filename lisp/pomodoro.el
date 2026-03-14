;;; pomodoro.el --- Pomodoro timer implementation -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

;; 📦 TMR
;; Emacs package to set timers using a convenient notation.
(use-package tmr
  :straight t

  :config
  (define-key global-map (kbd "C-c t") #'tmr-prefix-map)

  (setopt tmr-sound-file "/usr/share/sounds/freedesktop/stereo/alarm-clock-elapsed.oga"
          tmr-notification-urgency 'normal
          tmr-description-list 'tmr-description-history)

  (tmr-mode-line-mode))

(provide 'pomodoro)
;;; pomodoro.el ends here
