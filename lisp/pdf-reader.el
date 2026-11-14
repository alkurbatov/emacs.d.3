;;; pdf-reader.el --- PDF reading. -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(defun my/pdf-skip-large-file-warning (orig-fn size op-type filename &rest args)
  "Do not ask confirmation before opening large PDF files."
  (unless (string-suffix-p ".pdf" filename t)
    (apply orig-fn size op-type filename args)))

(advice-add 'abort-if-file-too-large :around #'my/pdf-skip-large-file-warning)

;; 📦 PDF-TOOLS
;; Emacs support library for PDF files.
(use-package pdf-tools
  :straight t

  :if (display-graphic-p)

  :config
  (pdf-tools-install))

(provide 'pdf-reader)
;;; pdf-reader.el ends here
