;;; project-manager.el --- Project manager settings -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(cl-defmethod project-root ((project (head local)))
  "Return root directory of current PROJECT."
  (cdr project))

(defun my/project-try-local (dir)
  "Determine if DIR is a non-VC project.
DIR must include a file .project.
Inspired by: https://christiantietze.de/posts/2022/03/mark-local-project.el-directories/"
  (if-let* ((root (locate-dominating-file dir ".project")))
      (cons 'local root)))


;; 📦 PROJECT
;; Project manager.
(use-package project
  :config
  ;; Switch project in the same way as projectile does.
  (setopt project-switch-commands 'project-find-file)

  (add-to-list 'project-find-functions #'my/project-try-local))


(provide 'project-manager)
;;; project-manager.el ends here
