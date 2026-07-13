;;; init.el --- Emacs configuration v3 -*- lexical-binding: t; -*-

;;; Commentary:
;;; Main entry point.

;;; Code:

;; Libraries load path.
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "snippets" user-emacs-directory))

(defun my/kill-scratch ()
  "Close the *scratch* buffer when Emacs starts."
  (when (get-buffer "*scratch*")
    (kill-buffer "*scratch*")))


;; 📦 EMACS
;; Fake package to wrap Emacs settings.
(use-package emacs
  :config
  ;; Keep custom settings in a separate file instead of appending to init.el.
  (setopt custom-file (expand-file-name "custom.el" user-emacs-directory))
  (when (file-exists-p custom-file)
    (load custom-file))

  ;; Use y and n keys to confirm commands.
  (setopt use-short-answers t
          read-answer-short t)

  ;; If .el file is newer than .elc, prefer the former.
  (setopt load-prefer-newer t)

  ;; Empty scratch buffer.
  (setopt initial-scratch-message nil)

  ;; Default mode.
  (setq initial-major-mode 'text-mode
        default-major-mode 'text-mode)

  ;; No bells and whistles.
  (setopt visible-bell nil
          ring-bell-function 'ignore)

  :custom
  ;; Don't show boring messages.
  (inhibit-startup-echo-area-message (user-login-name))

  :hook
  (after-init . my/kill-scratch))


(require 'package-manager)

(require 'user-settings)
(require 'custom)

(require 'appearance)
(require 'typography)
(require 'help-ex)
(require 'modeline)
(require 'user-session)
(require 'minibuffer-ex)

(require 'text-editing)
(require 'global-keybindings)
(require 'clipboard)
(require 'spellchecker)
(require 'file-manager)
(require 'terminal)

(require 'coding)
(require 'compilation)
(require 'make)
(require 'project-manager)
(require 'remote)
(require 'snippets)
(require 'version-control)

(require 'cpp)
(require 'elisp)
(require 'golang)
(require 'jinja2)
(require 'markdown)
(require 'protobuf)
(require 'py)
(require 'sh)

(require 'org-ex)
(require 'personal-calendar)
(require 'pomodoro)
(require 'rss-reader)
(require 'second-brain)

(provide 'init.el)
;;; init.el ends here
