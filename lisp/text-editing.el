;;; text-editing.el --- Text editor settings -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(defun my/pulse-current-region (&rest _)
  "Pulse the current implicit or active region."
  (if mark-active
      (pulse-momentary-highlight-region (region-beginning) (region-end))
    (pulse-momentary-highlight-region (mark) (point))))

(advice-add #'kill-ring-save :before #'my/pulse-current-region)

;; 📦 DELSEL
;; Controls work with selected regions.
(use-package delsel
  :config
  ;; Delete whole selected region by Del or Backspace.
  (delete-selection-mode t))

;; 📦 ABBREV
;; Abbreviations support.
(use-package abbrev
  :config
  ;; Save abbrevs without questions.
  (setopt save-abbrevs 'silently)

  (setopt abbrev-mode t)
  (add-to-list 'mode-line-collapse-minor-modes 'abbrev-mode))

;; 📦 SIMPLE
;; Miscellaneous text editor settings.
(use-package simple
  :config
  ;; Delete all symbols by pressing Backspace.
  (setopt backward-delete-char-untabify-method 'hungry)

  ;; Don't indent with tabs.
  (indent-tabs-mode nil)

  :hook
  (messages-buffer-mode . visual-line-mode)
  (text-mode . visual-line-mode))


;; Auto completion.
(setopt completion-ignore-case t
        read-file-name-completion-ignore-case t)

;; Don't refresh buffer on text input.
(setopt redisplay-skip-fontification-on-input t)

;; TAB either indents or calls auto completion.
(setopt tab-always-indent 'complete)

;; Buffer encoding.
(prefer-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-language-environment 'utf-8)
(set-selection-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(setopt locale-coding-system 'utf-8
        buffer-file-coding-system 'utf-8-unix)

;; Don't require double spaces after dot.
(setopt sentence-end-double-space nil)

;; Always insert final newlone.
(setopt require-final-newline t)

(setopt standard-indent 2)

(provide 'text-editing)
;;; text-editing.el ends here
