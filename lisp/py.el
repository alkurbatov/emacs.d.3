;;; py.el --- Python programming environment -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

;; 📦 Python-TS-MODE
;; Tree-sitter integration for Python.
(use-package python-ts-mode
  :hook
  ((python-ts-mode . eglot-ensure)))

;; 📦 UV-MODE
;; Emacs integration for uv virtual environments.
(use-package uv-mode
  :straight t

  :hook
  (python-ts-mode . uv-mode-auto-activate-hook))


(provide 'py)
;;; py.el ends here
