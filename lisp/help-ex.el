;;; help-ex.el --- Help and docs improvements -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

;; 📦 WHICH-KEY MODE
;; Shows hints for keyboard shortcuts.
(use-package which-key
  :config
  (which-key-mode t)

  :custom
  ;; Show actual keyboard shortcuts.
  (which-key-compute-remaps t)

  ;; Use Unicode.
  (which-key-dont-use-unicode nil)

  (which-key-idle-delay 1)
  (which-key-idle-secondary-delay 0.05)

  ;; Don't add hints to status bar.
  (which-key-lighter nil)

  (which-key-separator " → ")

  ;; Show top-level bindings of the current major mode.
  (which-key-show-major-mode t))


;; If we have sources at hand set path to them to use in the documentation.
(when (file-exists-p my/emacs-src)
  (setopt source-directory my/emacs-src))

(provide 'help-ex)
;;; help-ex.el ends here
