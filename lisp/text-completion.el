;;; text-completion.el --- Completion in text editor. -*- lexical-binding: t; -*-

;;; Commentary:
;; See
;; https://protesilaos.com/codelog/2026-07-29-emacs-default-minibuffer-completion-overview/

;;; Code:

;; 📦 COMPLETION-PREVIEW
;; Show in-buffer completion suggestion in a preview as you type.
(use-package completion-preview
  :ensure nil

  :config
  (setopt completion-preview-commands '(self-insert-command
                                        insert-char
                                        analyze-text-conversion
                                        completion-preview-insert-word))

  ;; Reduce visual noise by removing redundant help messages.
  (setopt completion-show-help nil
          completion-show-inline-help nil)

  (setopt completion-preview-minimum-symbol-length 2
          completion-preview-idle-delay 0.3
          completion-preview-ignore-case t
          read-file-name-completion-ignore-case t
          completion-preview-sort-function #'identity)

  ;; Do not use rows and columns for completions: a single vertical
  ;; list is easier to follow.
  (setopt completions-format 'one-column)

  ;; Put an upper limit to the Completions window, so that it does not
  ;; disorient me.
  (setopt completions-max-height 12)

  ;; Rely on previous inputs to surface candidates towards the top of the list.
  (setopt completions-sort 'historical)

  ;; Show the Completions buffer if I hit TAB but there is no unique match yet.
  (setopt completion-auto-help t)

  ;; Never switch to the Completions buffer when I type TAB, because I
  ;; want to select candidates while the minibuffer is still in focus,
  ;; per `minibuffer-visible-completions'.  This has the advantage of
  ;; auto-updating the completions as I type.
  (setq completion-auto-select nil
        minibuffer-visible-completions t)

  :hook
  (after-init . global-completion-preview-mode)

  :bind
  (:map completion-preview-active-mode-map
        ("M-n" . completion-preview-next-candidate)
        ("M-p" . completion-preview-prev-candidate)
        ("M-i" . completion-preview-insert-word)
        ("M-RET" . completion-preview-insert)
        ("TAB" . completion-preview-complete)))

(provide 'text-completion)
;;; text-completion.el ends here
