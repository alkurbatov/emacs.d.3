;;; remote.el --- Support of text editing over SSH -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; Regarding TRAMP optimizations see:
;; https://coredumped.dev/2025/06/18/making-tramp-go-brrrr./
;;
;; Hints
;;
;; To open file under root user on remote machine do:
;; /ssh:remote-host|sudo::/path/to-file

;;; Code:

;; 📦 TRAMP
;; Connect to remote host via SSH.
(use-package tramp
  :config
  ;; Print only warnings and errors.
  (setopt tramp-verbose 2)

  ;; Don't use locks on remote files.
  (setopt remote-file-name-inhibit-locks t)

  ;; Use faster method.
  (setopt tramp-use-scp-direct-remote-copying t)

  ;; Load .dir-locals.el of remote projects.
  (setopt enable-remote-dir-locals t))

(provide 'remote)
;;; remote.el ends here
