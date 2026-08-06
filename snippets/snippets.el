;;; snippets.el --- Snippets configuration -*- lexical-binding: t; -*-

;;; Commentary:
;; Setup snippets integration.

;;; Code:

(use-package yasnippet
  :straight t

  :config
  (add-to-list 'mode-line-collapse-minor-modes 'yas-minor-mode)

  :hook
  (after-init . yas-global-mode))

(provide 'snippets)
;;; snippets.el ends here
