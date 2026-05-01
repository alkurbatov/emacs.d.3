;;; org-ex.el --- Org mode settings -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(defun my/org-time-stamp-inactive ()
  "Insert inactive timestamp with current date."
  (interactive)
  (org-insert-time-stamp (current-time) nil t))


(defun my/set-project-root-abbrev ()
  "Add special link type 'root' to use in links to files, e.g. root:/a/b/c.
Such links are always use project root as the base path.
If target environment is not a project, 'root' link type is not declared."
  (when-let* ((project (project-current))
              (root (project-root project)))
    (setq-local org-link-abbrev-alist
                `(("root" . ,(concat "file:" root))))))


;; 📦 ORG
;; Org text format.
(use-package org
  :config
  ;; Allow manual change of inline images size.
  (setopt org-image-actual-width nil)

  ;; Open link by pressing Enter.
  (setopt org-return-follows-link t)

  ;; Enable document parsing.
  (setopt TeX-auto-save t
          TeX-parse-self t)

  :hook
  ((org-mode . visual-line-mode)
   (org-mode . emojify-mode)
   (org-mode . my/set-project-root-abbrev))

  :bind
  (:map org-mode-map
        ("C-c z" . org-toggle-link-display)
        ("C-c i" . nano-org-time-stamp-inactive)))


(provide 'org-ex)
;;; org-ex.el ends here
