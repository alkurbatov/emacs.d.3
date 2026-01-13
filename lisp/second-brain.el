;;; second-brain.el --- Personal knowledge base -*- lexical-binding: t; -*-

;;; Commentary:
;; Configuration of personal knowledge base.

;;; Code:

;; 📦 ORG-ROAM
;; Zettelkasten with org-mode.
(use-package org-roam
  :straight t

  :config
  ;; Org-roam now requires additional package to work with sqlite DB.
  (use-package sqlite3
    :straight t)

  (org-roam-db-autosync-mode)

  (setopt org-roam-mode-sections
          (list #'org-roam-backlinks-section
                #'org-roam-reflinks-section
                #'org-roam-unlinked-references-section))

  :bind (("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert)))

(provide 'second-brain)
;;; second-brain.el ends here
