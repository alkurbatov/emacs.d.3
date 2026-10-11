;;; spellchecker.el --- Spellchecker configuration -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:
;; Enable spellchecking with jinx.

(use-package jinx
  :straight t

  :config
  ;; Homebrew's enchant has no hunspell provider, so on macOS request
  ;; aspell's "ru" instead of "ru_RU".  Put it first, as aspell's "en_US"
  ;; suggests single letters for Cyrillic words.
  (setopt jinx-languages (if (eq system-type 'darwin) "ru en_US" "en_US ru_RU"))

  (add-to-list 'mode-line-collapse-minor-modes 'jinx-mode)

  :hook
  (after-init . global-jinx-mode)

  :bind
  (("M-4" . jinx-correct)))

(provide 'spellchecker)
;;; spellchecker.el ends here
