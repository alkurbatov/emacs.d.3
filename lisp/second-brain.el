;;; second-brain.el --- Personal knowledge base -*- lexical-binding: t; -*-

;;; Commentary:
;; Configuration of personal knowledge base.

;;; Code:

(defun my/org-roam-find-by-tag ()
  "Select a tag from the list, then find a note."
  (interactive)

  ;; Ensure org-roam is loaded before use, mimicking autoload behavior:
  ;; the function is available immediately after config load, but the
  ;; package itself is deferred until first call.
  (require 'org-roam)

  (let* ((all-tags
          (seq-uniq
           (seq-mapcat #'org-roam-node-tags
                       (org-roam-node-list))))
         (tag (completing-read "Tag: " all-tags)))

    (org-roam-node-find nil nil
                        (lambda (node)
                          (member tag (org-roam-node-tags node))))))


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
         ("C-c n i" . org-roam-node-insert)
         ("C-c n t" . my/org-roam-find-by-tag)))

;; 📦 CONSULT-ORG-ROAM
;; Consult integration for org-roam: adds preview to node search.
(use-package consult-org-roam
  :straight t
  :after org-roam

  :config
  (consult-org-roam-mode 1))

;; 📦 ORG-ROAM-UI
;; Interactive graph visualization of the Zettelkasten (Obsidian-like).
(use-package org-roam-ui
  :straight (:host github :repo "org-roam/org-roam-ui" :branch "main" :files ("*.el" "out"))
  :after org-roam

  :custom
  (org-roam-ui-sync-theme t)
  (org-roam-ui-follow t)
  (org-roam-ui-update-on-save t)
  (org-roam-ui-open-on-start t)

  :bind
  ("C-c n g" . org-roam-ui-open))

(provide 'second-brain)
;;; second-brain.el ends here
