;;; py.el --- Python programming environment -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

;; 📦 Python-TS-MODE
;; Tree-sitter integration for Python.
(use-package python-ts-mode
  :hook
  ((python-ts-mode . eglot-ensure)))

(provide 'py)
;;; py.el ends here
