;;; version-control.el --- VC configuration -*- lexical-binding: t; -*-

;;; Commentary:
;; Version control (mostly Git) configuration.

;;; Code:

(require 'log-edit)

;; 📦 VC
;; Embedded version control integration.
(use-package vc
  :config
  ;; We use only Git.
  ;; This may have an effect on performance, as Emacs will not try to check for
  ;; a bunch of backends.
  (setopt vc-handled-backends '(Git)))

;; 📦 VC-GIT
;; Embedded git integration.
(use-package vc-git
  :mode
  ("COMMIT_EDITMSG\\'" . vc-git-log-edit-mode)

  :config
  ;; Visit symbolic links, too.
  (setopt vc-follow-symlinks t))

;; 📦 DIFF-HL
;; Show git diff indicators.
(use-package diff-hl
  :straight t

  :config
  ;; Show changes in unsaved buffers.
  (diff-hl-flydiff-mode)

  ;; Use margin instead of fringe for consistent look and fill in GUI and TUI.
  (diff-hl-margin-mode)

  (modus-themes-with-colors
   (set-face-attribute 'diff-hl-margin-insert nil
                       :foreground green-cooler
                       :background bg-main)
   (set-face-attribute 'diff-hl-margin-change nil
                       :foreground yellow-cooler
                       :background bg-main)
   (set-face-attribute 'diff-hl-margin-delete nil
                       :foreground red-cooler
                       :background bg-main))

  :hook
  (after-init . global-diff-hl-mode))

;; 📦 GIT-MODES
;; Emacs major modes for Git configuration files.
(use-package git-modes
  :straight t)

;; 📦 GIT-LINK
;; Get full web link to the current line in repository.
(use-package git-link
  :straight t
  :bind
  (("C-c g l" . git-link)))

(provide 'version-control)
;;; version-control.el ends here
