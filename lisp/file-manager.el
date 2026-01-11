;;; file-manager.el --- File manager settings -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(defun my/open-dired ()
  "Open Dired in the current folder."
  (interactive)

  (dired "."))

;; 📦 DIRED
;; File manager.
(use-package dired
  :config
  ;; Kill buffer when changing folders.
  (setopt dired-kill-when-opening-new-dired-buffer t)

  ;; Always do recursive copies without questions.
  (setopt dired-recursive-copies 'always)

  ;; Remove folders recursively without questions.
  (setopt dired-recursive-deletes 'always)

  ;; Move files to trash instead of deletion.
  (setopt delete-by-moving-to-trash t)

  (setopt dired-listing-switches
          "-l --human-readable --all --group-directories-first --dired")

  :bind
  (("C-x d" . my/open-dired)))


(provide 'file-manager)
;;; file-manager.el ends here
