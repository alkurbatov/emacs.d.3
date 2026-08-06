;;; spellchecker.el --- Spellchecker configuration -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:
;; Enable spellchecking with jinx.

(use-package jinx
  :straight t

  :config
  (setopt jinx-languages "en_US ru_RU")

  (add-to-list 'mode-line-collapse-minor-modes 'jinx-mode)

  :hook
  (after-init . global-jinx-mode)

  :bind
  (("M-4" . jinx-correct)))

(provide 'spellchecker)
;;; spellchecker.el ends here
