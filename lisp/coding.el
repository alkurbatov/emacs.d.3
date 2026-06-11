;;; coding.el --- General settings for coding -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(defun my/insert-uuid ()
  "Insert a random UUID at point."
  (interactive)
  (let ((uuid (downcase (string-trim (shell-command-to-string "uuidgen")))))
    (insert "\"" uuid "\"")))


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

;; 📦 FORMAT-ALL
;; Set of utilities to format code on save.
(use-package format-all
  :straight t

  :commands format-all-mode

  :config
  ;; Be silent when we can't format buffer, it could be temporal error because
  ;; of syntax mistake.
  (setopt format-all-show-errors 'never)

  (add-to-list 'mode-line-collapse-minor-modes 'format-all-mode)

  :hook
  ((prog-mode . format-all-mode)
   (format-all-mode . format-all-ensure-formatter)))

;; 📦 EVIL-NERD-COMMENTER
;; Convenient comment/uncomment action like in Vim.
(use-package evil-nerd-commenter
  :straight t

  :config
  (evilnc-default-hotkeys t))

;; 📦 EGLOT
;; LSP integration.
(use-package eglot
  :config
  ;; Automatically shutdown backend if last buffer was killed.
  (setopt eglot-autoshutdown t)

  ;; Disable connection sync, otherwise, Elgot freezes the UI for ~3s when large
  ;; file is opened.
  (setopt eglot-sync-connect nil)

  ;; Never time out Eglot connection to make things faster.
  (setopt eglot-connect-timeout nil)

  ;; Specify explicitly to use Orderless for Eglot.
  (setopt completion-category-overrides '((eglot (styles orderless))
                                          (eglot-capf (styles orderless))))

  ;; Increase chunk size to make Eglot faster.
  (setopt read-process-output-max (* 4 1024 1024)) ; 4096kb

  ;; Enable LSP features in files opened via xref (e.g. stdlib or dependencies).
  (setopt eglot-extend-to-xref t)

  :bind
  ("M-," . xref-go-back))


;; Install extended language grammar without questions.
(setopt treesit-auto-install-grammar 'always)

;; Enable tree-sitter everywhere.
(setopt treesit-enabled-modes t)

(provide 'coding)
;;; coding.el ends here
