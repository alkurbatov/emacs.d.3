;;; file-manager.el --- File manager settings -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

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
  ;; -a is required to get ".." from ls-lisp; "." is hidden via dired-omit below.
  (setopt dired-listing-switches "-lah")

  (modus-themes-with-colors
   (set-face-attribute 'dired-directory nil :weight 'bold))

  :bind
  (("C-x d" . dired-jump)))

;; 📦 DIRED-X
;; Dired extras.
(use-package dired-x
  :config
  ;; Match only the single dot (current dir); ".." and dotfiles are unaffected.
  (setopt dired-omit-files "^\\.$")

  :hook (dired-mode . dired-omit-mode))


(provide 'file-manager)
;;; file-manager.el ends here
