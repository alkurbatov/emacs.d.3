;;; make.el --- Makefile and make utility support -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

;; 📦 MAKE-MODE
;; Makefile support.
(use-package make-mode
  :mode ("\\([Mm]akefile\\|.*\\.\\(mk\\|make\\)\\'\\)" . makefile-mode)

  :config
  (setq-local indent-tabs-mode t)

  :hook
  (makefile-mode . whitespace-mode))

(provide 'make)
;;; make.el ends here
