;;; snippets.el --- Snippets configuration -*- lexical-binding: t; -*-

;;; Commentary:
;; Setup snippets integration.

;;; Code:

(use-package yasnippet
  :straight t
  :config
  (yas-global-mode)
  (add-to-list 'mode-line-collapse-minor-modes 'yas-minor-mode))

(provide 'snippets)
;;; snippets.el ends here
