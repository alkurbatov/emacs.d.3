;;; org-ex.el --- Org mode settings -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:
(require 'user-settings)

(defun my/org-time-stamp-inactive ()
  "Insert inactive timestamp with current date."
  (interactive)
  (org-insert-time-stamp (current-time) nil t))


(defvar-local my/project-root nil
  "Root of the project owning the current buffer, nil outside a project.")


(defun my/set-project-root-abbrev ()
  "Add special link type 'root' to use in links to files, e.g. root:/a/b/c.
Such links are always use project root as the base path.
If target environment is not a project, 'root' link type is not declared."
  (when-let* ((project (project-current))
              (root (project-root project)))
    (setq-local my/project-root root)
    (setq-local org-link-abbrev-alist
                `(("root" . ,(concat "file:" root))))))


(defun my/org-file-path-capf ()
  "Complete file paths typed after a `file:' or `root:' link prefix.
Paths after `root:' are completed relative to the project root declared
by `my/set-project-root-abbrev'."
  (when (looking-back "\\_<\\(file\\|root\\):\\([^][ \t\n]*\\)"
                      (line-beginning-position))
    (let ((type (match-string-no-properties 1))
          (beg (match-beginning 2))
          (end (point)))
      (when-let* ((dir (if (equal type "file")
                           default-directory
                         my/project-root)))
        (list beg end
              (lambda (string pred action)
                (let ((default-directory dir))
                  (completion-file-name-table string pred action)))
              :exclusive 'no)))))

(defun my/org-setup-completion ()
  "Setup completion at point functions."

  ;; Drop `ispell-completion-at-point', inherited from `text-mode'.  It
  ;; runs last, so it fires on every ordinary word no other capf claims,
  ;; filling `completion-preview' with dictionary noise.
  (remove-hook 'completion-at-point-functions #'ispell-completion-at-point t)

  ;; Enable file path completion in the current Org buffer.
  (add-hook 'completion-at-point-functions #'my/org-file-path-capf nil t))


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

  ;; Enable syntax highlighting in src blocks for certain languages.
  (add-to-list 'org-src-lang-modes '("proto" . protobuf-ts))

  ;; Keep src block contents as typed, otherwise Org re-indents the whole block.
  (setopt org-src-preserve-indentation t)

  ;; Path to task files.
  (setopt org-agenda-files
          (list my/second-brain-directory
                (concat my/second-brain-directory "Проекты")
                (concat my/second-brain-directory my/dailies-directory)))

  ;; Task flow.
  (setopt org-todo-keywords
          '((sequence "TODO" "|" "DONE" "CANCELED")))

  ;; Add current time when marking item as 'DONE'
  (setopt org-log-done 'time)

  :hook
  ((org-mode . visual-line-mode)
   (org-mode . emojify-mode)
   (org-mode . my/set-project-root-abbrev)
   (org-mode . my/org-setup-completion))

  :bind
  (("C-c a" . org-agenda)
   (:map org-mode-map
         ("C-c z" . org-toggle-link-display)
         ("C-c i" . nano-org-time-stamp-inactive))))


(provide 'org-ex)
;;; org-ex.el ends here
