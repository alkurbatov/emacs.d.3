;;; compilation.el --- Compile mode settings -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

;; 📦 ANSI-COLOR
;; Colors of compile buffer.
(use-package ansi-color
  :config
  (setopt ansi-color-for-compilation-mode t)

  :hook
  (compilation-filter . ansi-color-compilation-filter))


;; 📦 COMPILE
;; Compilation.
(use-package compile
  :config
  ;; Always kill current compilation process when running new one.
  (setopt compilation-always-kill t)

  ;; Save all buffers before compilation.
  (setopt compilation-ask-about-save nil)

  ;; Don't hide long lines.
  (setopt compilation-max-output-line-length nil)

  ;; Don't ask for confirmation when run compilation.
  (setopt compilation-read-command nil)

  ;; Follow compilation command output.
  (setopt compilation-scroll-output t)

  :hook
  (compilation-mode . visual-line-mode))


(provide 'compilation)
;;; compilation.el ends here
