;;; clipboard.el --- Copy-paste support in terminal -*- lexical-binding: t; -*-

;;; Commentary:
;; Linux part taken from https://www.emacswiki.org/emacs/CopyAndPaste

;;; Code:
(require 'environment)

(defun copy-from-osx (text &optional _push)
  "Copy TEXT using macOS tools."
  (let ((process-connection-type nil))
    (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
      (process-send-string proc text)
      (process-send-eof proc))))

(defun paste-to-osx ()
  "Paste text using macOS tools."
  (shell-command-to-string "pbpaste"))

(defun copy-from-linux-wayland (text &optional _push)
  "Copy TEXT using wl-clipboard."
  (with-temp-buffer
    (insert text)
    (call-process-region (point-min) (point-max) "wl-copy" nil 0 nil "-f" "-n")))

(defun paste-to-linux-wayland ()
  "Paste text using wl-clipboard."
  (let ((tramp-mode nil)
        (default-directory "~"))
    (setq-local xsel-output (shell-command-to-string "wl-paste -n | tr -d \r"))
    (unless (string= (car kill-ring) xsel-output)
      xsel-output )))


(unless (display-graphic-p)
  (cond
   (os-macos
    (setopt interprogram-cut-function 'copy-from-osx)
    (setopt interprogram-paste-function 'paste-to-osx))
   ((and os-linux (getenv "WAYLAND_DISPLAY"))
    (setopt interprogram-cut-function 'copy-from-linux-wayland)
    (setopt interprogram-paste-function 'paste-to-linux-wayland))))

;; Save existing system clipboard text into the kill ring before replacing it.
;; See https://srijan.ch/notes/2024-09-24-001
(setopt save-interprogram-paste-before-kill t)

;; Don't put duplicates to kill-ring.
(setopt kill-do-not-save-duplicates t)

(setopt select-enable-clipboard t)

(provide 'clipboard)
;;; clipboard.el ends here
