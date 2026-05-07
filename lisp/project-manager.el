;;; project-manager.el --- Project manager settings -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(cl-defmethod project-root ((project (head local)))
  "Return root directory of current PROJECT."
  (cdr project))

(defun my/consult-project-ripgrep-at-point ()
  "Search text at point with consul in the current project."
  (interactive)
  (consult-ripgrep
   (project-root (project-current))
   (thing-at-point 'symbol)))

(defun my/vterm-project ()
  "Open vterm in the root of the current project."
  (interactive)
  (let ((default-directory (project-root (project-current t))))
    (vterm)))


;; 📦 PROJECT
;; Project manager.
(use-package project
  :config
  ;; Switch project in the same way as projectile does.
  (setopt project-switch-commands 'project-find-file)

  ;; Tell consul how to identify root of a project.
  (setopt consult-project-root-function #'project-root)

  ;; Additional markers of a project.
  (setopt project-vc-extra-root-markers '(".project" ".git"))

  :bind
  (:map project-prefix-map
        ("f" . consult-find)
        ("s" . consult-ripgrep)
        ("t" . my/vterm-project)
        ("." . my/consult-project-ripgrep-at-point)))


(provide 'project-manager)
;;; project-manager.el ends here
