;;; markdown.el --- Markdown language configuration -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

;; 📦 MARKDOWN-TS-MODE
;; Tree-sitter integration for Markdown.
(use-package markdown-ts-mode
  :hook
  ((markdown-ts-mode . visual-line-mode)))

;; 📦 MARKDOWN-MODE
;; Emacs Markdown Mode.
(use-package markdown-mode
  :straight t)

(provide 'markdown)
;;; markdown.el ends here
