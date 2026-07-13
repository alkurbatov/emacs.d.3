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


(defun my/org-roam-rename-inserted-link (_id description)
  "Prompt to rename the link just inserted for node _ID.
DESCRIPTION is the default link text (usually the node's title).
Press RET to keep it, or edit it to rename the link."
  (let ((new-description (read-string "Description: " description)))
    (unless (string-equal new-description description)
      (let ((end (- (point) 2))
            (beg (- (point) 2 (length description))))
        (goto-char beg)
        (delete-region beg end)
        (insert new-description)))))


(defun my/org-roam-find-dangling-links ()
  "Find all dangling id: links in the org-roam database.
These are links whose destination ID does not exist as a node."
  (interactive)

  ;; Ensure org-roam is loaded before use, mimicking autoload behavior:
  ;; the function is available immediately after config load, but the
  ;; package itself is deferred until first call.
  (require 'org-roam)

  (let* (;; Query the SQLite database for id: links pointing to non-existent nodes
         (query "SELECT links.dest, nodes.file, nodes.title, links.pos
                 FROM links
                 JOIN nodes ON nodes.id = links.source
                 WHERE links.type = '\"id\"'
                 AND links.dest NOT IN (SELECT id FROM nodes)")
         (results (org-roam-db-query query)))

    (if (null results)
        (message "No dangling links found!")
      (let* (;; Format each result as a human-readable choice string
             (choices (mapcar (lambda (r)
                                (format "[%s] %s (pos: %s)"
                                        (nth 2 r)  ; source node title
                                        (nth 0 r)  ; destination ID (missing)
                                        (nth 3 r))) ; position in file
                              results))

             ;; Let the user pick one from the list
             (choice (completing-read "Dangling id: links: " choices nil t))

             ;; Find the index of the chosen entry to retrieve original row data
             (idx (cl-position choice choices :test #'equal))
             (row (nth idx results)))

        ;; Open the file containing the dangling link and jump to its position
        (find-file (nth 1 row))
        (goto-char (nth 3 row))
        (message "Dangling link destination ID: %s" (nth 0 row))))))


;; 📦 ORG-ROAM
;; Zettelkasten with org-mode.
(use-package org-roam
  :straight t

  :config
  ;; Org-roam now requires additional package to work with sqlite DB.
  (use-package sqlite3
    :straight t)

  (org-roam-db-autosync-mode)

  (add-hook 'org-roam-post-node-insert-hook #'my/org-roam-rename-inserted-link)

  (setopt org-roam-mode-sections
          (list #'org-roam-backlinks-section
                #'org-roam-reflinks-section
                #'org-roam-unlinked-references-section))

  ;; Path to diary entries.
  (setopt org-roam-dailies-directory "Календарные/Дневник/")

  (setopt org-roam-dailies-capture-templates
          '(("d" "daily" plain
             "* Вопросы для самопроверки\n- Что я сделал?\n- Где застревал и почему?\n- Что из этого можно системно устранить?\n- Что хочу улучшить в следующем подходе?\n\n- %?\n\n* С чем приходили коллеги\n- "
             :target (file+head "%<%Y%m%d%H%M%S>-дневник.org" "#+title: Дневник - %<%Y-%m-%d>")
             :unnarrowed t)))

  :bind (("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n j" . org-roam-dailies-capture-today)
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
