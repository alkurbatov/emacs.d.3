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

;; 📦 APHELEIA
;; Run code formatter on buffer contents without moving point, using RCS patches
;; and dynamic programming.
(use-package apheleia
  :straight t

  :config
  ;; By default Apheleia refuses to touch buffers opened via TRAMP.
  (setopt apheleia-remote-algorithm 'remote)

  (add-to-list 'mode-line-collapse-minor-modes 'apheleia-mode)

  :hook
  (after-init . apheleia-global-mode))

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

  ;; Report system messages in English.
  ;; To avoid cases when Eglot hides real reason behind weird localized
  ;; messages, e.g. "Attempt to store non-ASCII char into multibyte string".
  (setopt system-messages-locale "C")

  :bind
  (:map eglot-mode-map
        ("M-," . xref-go-back)
        ("C-c a" . eglot-code-actions)))

;; 📦 ELDOC
;; Context documentation.
(use-package eldoc
  :config
  (add-to-list 'mode-line-collapse-minor-modes 'eldoc-mode))


;; Install extended language grammar without questions.
(setopt treesit-auto-install-grammar 'always)

;; For maximum syntax highlights. Especially helpful in C++.
(setopt treesit-font-lock-level 4)

;; Enable tree-sitter everywhere.
(setopt treesit-enabled-modes t)

(provide 'coding)
;;; coding.el ends here
