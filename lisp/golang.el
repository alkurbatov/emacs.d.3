;;; golang.el --- Go programming environment -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

;; 📦 GO-TS-MODE
;; Tree-sitter integration for Golang.
(use-package go-ts-mode
  :config
  ;; Regarding settings see:
  ;; Eglot: https://www.gnu.org/software/emacs/manual/html_node/eglot/User_002dspecific-configuration.html
  ;; Gopls: https://github.com/golang/tools/blob/master/gopls/doc/settings.md
  (with-eval-after-load 'eglot
    (add-to-list 'eglot-server-programs
                 `(go-ts-mode . ("gopls" :initializationOptions
                                 (:hints (:constantValues t :compositeLiteralFields t))))))

  :hook
  ((go-ts-mode . eglot-ensure)
   (go-ts-mode . subword-mode)))

;; 📦 GOTEST-TS
;; Run Golang unit-tests from Emacs.
(use-package gotest-ts
  :straight t

  :hook
  (go-ts-mode . gotest-ts-setup)

  :bind
  (("<f2>" . gotest-ts-run-dwim)))


(provide 'golang)
;;; golang.el ends here
