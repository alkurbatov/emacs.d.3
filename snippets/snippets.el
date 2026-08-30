;;; snippets.el --- Snippets configuration -*- lexical-binding: t; -*-

;;; Commentary:
;; Setup snippets integration.

;;; Code:

;; 📦 ABBREV
;; Abbreviations support.
(use-package abbrev
  :config
  ;; Save abbrevs without questions.
  (setopt save-abbrevs 'silently)

  (setopt abbrev-mode t)
  (add-to-list 'mode-line-collapse-minor-modes 'abbrev-mode))

;; 📦 YASNIPPET
;; A template system for Emacs.
(use-package yasnippet
  :straight t

  :config
  (add-to-list 'mode-line-collapse-minor-modes 'yas-minor-mode)

  :hook
  (after-init . yas-global-mode))


(provide 'snippets)
;;; snippets.el ends here
