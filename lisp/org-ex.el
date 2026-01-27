;;; org-ex.el --- Org mode settings -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(defun my/org-time-stamp-inactive ()
  "Insert inactive timestamp with current date."
  (interactive)
  (org-insert-time-stamp (current-time) nil t))


;; 📦 ORG
;; Org text format.
(use-package org
  :config
  ;; Allow manual change of inline images size
  (setopt org-image-actual-width nil)

  ;; Enable document parsing
  (setopt TeX-auto-save t
          TeX-parse-self t)

  :hook
  ((org-mode . visual-line-mode)
   (org-mode . emojify-mode))

  :bind
  (:map org-mode-map
        ("C-c z" . org-toggle-link-display)
        ("C-c i" . nano-org-time-stamp-inactive)))


(provide 'org-ex)
;;; org-ex.el ends here
