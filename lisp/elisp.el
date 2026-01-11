;;; elisp.el --- Emacs lisp programming environment -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

;; 📦 LISP
;; Emacs lisp support.
(use-package lisp
  :hook
  ((emacs-lisp-mode) . electric-indent-local-mode))


(provide 'elisp)
;;; elisp.el ends here
