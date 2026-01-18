;;; project-manager.el --- Project manager settings -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(defun my/project-try-local (dir)
  "Determine if DIR is a non-VC project.
DIR must include a file .project.
Inspired by: https://christiantietze.de/posts/2022/03/mark-local-project.el-directories/"
  (if-let* ((root (locate-dominating-file dir ".project")))
      (cons 'local root)))

(cl-defmethod project-root ((project (head local)))
  "Return root directory of current PROJECT."
  (cdr project))

(defun my/consult-project-ripgrep-at-point ()
  "Search text at point with consul in the current project."
  (interactive)
  (consult-ripgrep
   (project-root (project-current))
   (thing-at-point 'symbol)))


;; 📦 PROJECT
;; Project manager.
(use-package project
  :config
  ;; Switch project in the same way as projectile does.
  (setopt project-switch-commands 'project-find-file)

  ;; Tell consul how to identify root of a project.
  (setopt consult-project-root-function #'project-root)

  (add-to-list 'project-find-functions #'my/project-try-local)

  :bind
  (:map project-prefix-map
        ("f" . consult-find)
        ("s" . consult-ripgrep)
        ("." . my/consult-project-ripgrep-at-point)))


(provide 'project-manager)
;;; project-manager.el ends here
