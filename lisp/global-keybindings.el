;;; global-keybindings.el --- Global keybindings -*- lexical-binding: t; -*-

;;; Commentary:
;; Global keyboard shortcuts.

;;; Code:

(require 'bind-key)
(require 'keymap)

;; Make C-g more helpful.
;; Taken from https://protesilaos.com/codelog/2024-11-28-basic-emacs-configuration/
(defun my/keyboard-quit-dwim ()
  "Do-What-I-Mean behavior for a general `keyboard-quit'.

The generic `keyboard-quit' does not do the expected thing when
the minibuffer is open.  Whereas we want it to close the
minibuffer, even without explicitly focusing it.

The DWIM behavior of this command is as follows:

- When the region is active, disable it.
- When a minibuffer is open, but not focused, close the minibuffer.
- When the Completions buffer is selected, close it.
- In every other case use the regular `keyboard-quit'."
  (interactive)
  (cond ((region-active-p) (keyboard-quit))
        ((derived-mode-p 'completion-list-mode) (delete-completion-window))
        ((> (minibuffer-depth) 0) (abort-recursive-edit))
        (t (keyboard-quit))))

(bind-key "C-g" #'my/keyboard-quit-dwim)

;; Disable some unused keys.
(keymap-global-unset "M-,")     ;; markers
(keymap-global-unset "C-x C-z") ;; `suspend-emacs'
(keymap-global-unset "C-x C-p") ;; `mark-page'

;; No buffers switching by Ctrl+PgUp and Ctrl+PgDn.
(keymap-global-unset "C-<next>")
(keymap-global-unset "C-<prior>")
(keymap-global-set "C-<next>" #'next-buffer)
(keymap-global-set "C-<prior>" #'previous-buffer)

;; Cmd-return to maximize/minimize frame.
(bind-key "<s-return>" #'toggle-frame-maximized)

;; Close the buffer by [C-x k].
(bind-key* "C-x k" #'kill-current-buffer)

;; Open URL in default browser.
;; (bind-key* "<C-return>" #'browse-url-at-point) ; works in UI mode only
(bind-key* "<C-return>" #'browse-url-at-point)

(provide 'global-keybindings)
;;; global-keybindings.el ends here
