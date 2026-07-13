;;; user-session.el --- User session configuration -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:
(require 'user-settings)

;; 📦 SAVEPLACE
;; Remember cursor position in visited files.
(use-package saveplace
  :custom
  ;; Ignore unreadable files.
  (save-place-forget-unreadable-files t)

  :config
  (save-place-mode 1))

;; 📦 AUTOREVERT
;; Automatically refresh buffers.
(use-package autorevert
  :config
  ;; Update version control info too.
  (setopt auto-revert-check-vc-info t)

  ;; Auto refresh Dired, but be quiet about it.
  (setopt global-auto-revert-non-file-buffers t
          dired-auto-revert-buffer t
          auto-revert-verbose nil)

  (add-to-list 'mode-line-collapse-minor-modes 'auto-revert-mode)

  (global-auto-revert-mode t))

;; 📦 RECENTF-MODE
;; Remember list of recently opened files.
(use-package recentf
  :config
  (setopt recentf-save-file my/recentf-directory)

  ;; Remember last n files.
  (setopt recentf-max-saved-items 40)

  (setopt recentf-exclude '(".git/COMMIT_EDITMSG$"))

  (recentf-mode t))

;; 📦 SAVEHIST
;; Remember commands history.
(use-package savehist
  :init
  (savehist-mode t)

  :config
  (setopt savehist-additional-variables
          '(bookmark-history
            command-history
            compile-history
            custom-variable-history
            extended-command-history
            face-name-history
            file-name-history
            kill-ring
            minibuffer-history
            query-replace-history
            read-char-history
            read-expression-history
            regexp-search-ring
            search-ring
            set-variable-value-history
            shell-command-history))

  (add-to-list 'delete-frame-functions 'savehist-save)

  ;; No duplicates in history.
  (setopt history-delete-duplicates t)

  ;; Save more data.
  (setopt history-length 1000
          kill-ring-max 50)
  (put 'bookmark-history           'history-length 25)
  (put 'custom-variable-history    'history-length 25)
  (put 'face-name-history          'history-length 25)
  (put 'file-name-history          'history-length 50)
  (put 'minibuffer-history         'history-length 50)
  (put 'query-replace-history      'history-length 25)
  (put 'read-char-history          'history-length 25)
  (put 'read-expression-history    'history-length 25)
  (put 'set-variable-value-history 'history-length 25)

  :hook
  (kill-emacs . savehist-save))


;; Automatically safe file to prevent accidental data loss.
(setopt auto-save-file-name-transforms `((".*" ,my/auto-save-directory t))
        auto-save-default t     ; auto-save every buffer that visits a file
        auto-save-timeout 20    ; number of seconds idle time before auto-save
        auto-save-interval 200) ; number of keystrokes between auto-saves

;; Backups.
(setopt backup-directory-alist  `(("." . ,my/backups-directory))
        make-backup-files t     ; backup of a file the first time it is saved
        backup-by-copying t     ; don't clobber symbolic links
        vc-make-backup-files t  ; backup version controlled files too
        version-control t       ; version numbers for backup files
        delete-old-versions t   ; delete excess backup files silently
        kept-old-versions 6     ; oldest versions to keep when new backup made
        kept-new-versions 9)    ; newest versions to keep when new backup made

;; No need in lock files as I am the only Emacs user around :)
(setopt create-lockfiles nil)

(provide 'user-session)
;;; user-session.el ends here
