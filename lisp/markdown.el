;;; markdown.el --- Markdown language configuration -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

;; 📦 MARKDOWN-TS-MODE
;; Tree-sitter integration for Markdown.
(use-package markdown-ts-mode
  :mode
  ("\\.markdown\\'" . markdown-ts-mode)
  ("\\.md\\'" . markdown-ts-mode)

  ;; Used by Eglot to render LSP documentation, see lisp/coding.el.
  :commands (markdown-ts-view-mode)

  :hook
  ((markdown-ts-mode . visual-line-mode)))

(provide 'markdown)
;;; markdown.el ends here
