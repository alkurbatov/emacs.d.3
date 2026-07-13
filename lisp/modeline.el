;;; modeline.el --- Emacs modeline tweaks -*- lexical-binding: t; -*-

;;; Commentary:
;; Kudos to
;; https://github.com/LionyxML/emacs-solo/blob/main/lisp/emacs-solo-mode-line.el

;;; Code:

(defun my/buffer-identification ()
  "Return buffer name prefixed with its parent directory, e.g. `lisp/foo.el'."
  (if-let* ((file (buffer-file-name))
            (parent (file-name-nondirectory
                     (directory-file-name (file-name-directory file)))))
      (format " %s/%s" parent (file-name-nondirectory file))
    (format " %s" (buffer-name))))

(defun my/shorten-vc-mode (vc)
  "Shorten VC string to at most 20 characters.
Replacing `Git-' with a branch symbol."
  (let* ((vc (replace-regexp-in-string "^ Git[:-]"
                                       (if (char-displayable-p ?) "  " "Git: ")
                                       vc))) ;; Options:   ᚠ ⎇
    (if (> (length vc) 20)
        (concat (substring vc 0 20)
                (if (char-displayable-p ?…) "…" "..."))
      vc)))


(setopt mode-line-format
        '("%e" "  "
          (:propertize
           ("" mode-line-mule-info mode-line-client mode-line-modified mode-line-remote))

          mode-line-buffer-identification
          "   "
          mode-line-position
          mode-line-format-right-align
          "  "
          (project-mode-line project-mode-line-format)
          "  "
          (vc-mode (:eval (my/shorten-vc-mode vc-mode)))
          "  "
          mode-line-modes
          mode-line-misc-info
          "  ")
        project-mode-line t
        mode-line-buffer-identification '(:eval (my/buffer-identification))
        mode-line-position-column-line-format '(" %l:%c")
        mode-line-percent-position nil)

(setopt mode-line-modes-delimiters '("" . ""))


(provide 'modeline)
;;; modeline.el ends here
