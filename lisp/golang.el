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

;; 📦 GO-TS
;; Tree-sitter integration for Golang.
(use-package go-ts
  :hook
  ((go-ts-mode . eglot-ensure)
   (go-ts-mode . subword-mode)))

;; 📦 GOTEST-TS
;; Run Golang unit-tests from Emacs.
(use-package gotest-ts
  :straight t

  :hook (go-ts-mode . gotest-ts-setup)

  :bind
  (("<f2>" . gotest-ts-run-dwim)))


(provide 'golang)
;;; golang.el ends here
