;;; sh.el --- Bash/sh programming environment -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

;; 📦 SH-SCRIPT
;; Shell scripts support.
(use-package sh-script
  :mode
  ("\\.bash_aliases\\'" . bash-ts-mode)
  ("\\.bashrc\\'" . bash-ts-mode)
  ("\\.env.example\\'" . bash-ts-mode)
  ("\\.env\\'" . bash-ts-mode)
  ("\\.envrc\\'" . bash-ts-mode)
  ("\\.profile\\'" . bash-ts-mode)
  ("\\.sh\\'" . bash-ts-mode)

  :config
  ;; Force tree-sitter mode.
  (add-to-list 'major-mode-remap-alist '(sh-mode . bash-ts-mode)))


(provide 'sh)
;;; sh.el ends here
