;;; coding.el --- General settings for coding -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

;; 📦 FLYMAKE
;; Static analysis.
(use-package flymake
  :config
  ;; No need to show diagnostic in the fringe.
  (setopt flymake-fringe-indicator-position nil)

  ;; Focus on Flymake diagnostics buffer when activated.
  (add-to-list 'display-buffer-alist
               '("Flymake diagnostics" nil (post-command-select-window . t)))

  :bind
  (:map flymake-mode-map
        ("C-c ! P" . flymake-show-project-diagnostics)
        ("C-c ! l" . flymake-show-buffer-diagnostics)
        ("C-c ! n" . flymake-goto-next-error)
        ("C-c ! p" . flymake-goto-prev-error)
        ("C-c ! c" . flymake-start)
        ("C-c ! v" . flymake-running-backends))

  :hook
  (prog-mode . flymake-mode))

;; 📦 EVIL-NERD-COMMENTER
;; Convenient comment/uncomment action like in Vim.
(use-package evil-nerd-commenter
  :straight t

  :config
  (evilnc-default-hotkeys t))

;; Increase chunk size to make Eglot faster.
(setopt read-process-output-max (* 1024 1024))

;; Install extended language grammar without questions.
(setopt treesit-auto-install-grammar 'always)

(provide 'coding)
;;; coding.el ends here
