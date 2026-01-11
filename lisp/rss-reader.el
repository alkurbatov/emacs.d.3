;;; rss-reader.el --- RSS reader integration -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:
(require 'user-settings)

;; 📦 ELFEED
;; Read RSS from Emacs.
(use-package elfeed
  :straight t

  :config
  (setopt elfeed-db-directory my/elfeed-db-directory))

;; 📦 ELFEED-ORG
;; Keep RSS subscriptions in .org file.
(use-package elfeed-org
  :straight t

  :init
  (elfeed-org))

(provide 'rss-reader)
;;; rss-reader.el ends here
