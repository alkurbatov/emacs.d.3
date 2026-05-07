;;; terminal.el --- Terminal configuration. -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

;; 📦 VTERM
;; Emacs libvterm integration.
(use-package vterm
  :straight t

  :config
  (setopt vterm-kill-buffer-on-exit t))

(provide 'terminal)
;;; terminal.el ends here
