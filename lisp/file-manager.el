;;; file-manager.el --- File manager settings -*- lexical-binding: t; -*-

;;; Commentary:
;; The sort functions are inspired by
;; https://emacs.dyerdwelling.family/emacs/20260721093224-emacs--borrowing-from-jasspa-microemacs-dired-sort-keybindings/

;;; Code:

(defun my/dired-sort-by-size ()
  "Sort Dired buffer by file size."
  (interactive)
  (setq-local ls-lisp-dirs-first nil)
  (dired-sort-other "-AlGghS")
  (message "Sorted by size"))

(defun my/dired-sort-by-date ()
  "Sort Dired buffer by last modification date."
  (interactive)
  (setq-local ls-lisp-dirs-first nil)
  (dired-sort-other "-AlGght")
  (message "Sorted by modification date"))

(defun my/dired-sort-by-name ()
  "Sort Dired buffer alphabetically by name."
  (interactive)
  (setq-local ls-lisp-dirs-first t)
  (dired-sort-other "-AlGgh")
  (message "Sorted by name"))

(defun my/dired-sort-by-extension ()
  "Sort Dired buffer by file extension."
  (interactive)
  (setq-local ls-lisp-dirs-first t)
  (dired-sort-other "-AlGghX")
  (message "Sorted by extension"))


;; 📦 LS-LISP
;; Built-in Emacs Lisp implementation of ls.
;; Avoids dependency on GNU coreutils and enables portable directory sorting.
(use-package ls-lisp
  :config
  ;; Use Emacs's own ls implementation instead of the system one.
  (setopt ls-lisp-use-insert-directory-program nil)

  ;; Show directories before files (like Midnight Commander).
  (setopt ls-lisp-dirs-first t))

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

  ;; Use short flags compatible with ls-lisp (no GNU-specific long options).
  (setopt dired-listing-switches "-AlGgh")

  ;; When doing search with C-s in Dired buffers, match only file/folder names.
  (setopt dired-isearch-filenames t)

  (modus-themes-with-colors
   (set-face-attribute 'dired-directory nil :weight 'bold))

  :bind
  (("C-x d" . dired-jump)
   (:map dired-mode-map
         ("3" . my/dired-sort-by-size)
         ("4" . my/dired-sort-by-date)
         ("5" . my/dired-sort-by-name)
         ("6" . my/dired-sort-by-extension))))


(provide 'file-manager)
;;; file-manager.el ends here
