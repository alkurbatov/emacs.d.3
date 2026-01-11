;;; package-manager.el --- Package manager routine -*- lexical-binding: t; -*-

;;; Commentary:
;; Setup the straight.el package manager to manage all packages installation.

;;; Code:

;; Install straight.el.
;; See https://github.com/radian-software/straight.el?tab=readme-ov-file
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))


(setopt straight-vc-git-default-protocol 'ssh) ; use SSH to clone packages

(require 'use-package)

(provide 'package-manager)
;;; package-manager.el ends here
