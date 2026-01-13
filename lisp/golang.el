;;; golang.el --- Go programming environment -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:
(require 'format-all)

;; Register golangci-lint formatter.
(define-format-all-formatter
 golangci-lint
 (:executable "golangci-lint")
 (:install "See https://golangci-lint.run/docs/welcome/install/")
 (:languages "Go")
 (:features)
 (:format (format-all--buffer-easy executable "fmt" "--stdin")))

(use-package go-ts
  :hook
  ((go-ts-mode . eglot-ensure)
   (go-ts-mode . subword-mode)))


(provide 'golang)
;;; golang.el ends here
