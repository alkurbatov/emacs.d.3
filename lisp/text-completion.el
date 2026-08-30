;;; text-completion.el --- Completion in text editor. -*- lexical-binding: t; -*-

;;; Commentary:

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

  (setopt completion-preview-minimum-symbol-length 2
          completion-preview-idle-delay 0.3
          completion-preview-ignore-case t
          read-file-name-completion-ignore-case t
          completion-preview-sort-function #'identity)

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
