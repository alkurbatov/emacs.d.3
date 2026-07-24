;;; cpp.el --- C/C++ programming environment -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

;; 📦 C++-TS-MODE
;; Tree-sitter integration for C++.
(use-package c++-ts-mode
  :config
  (with-eval-after-load 'eglot
    (add-to-list 'eglot-server-programs
                 '(c++-ts-mode
                   . ("clangd"
                      "-j=4"
                      "--log=error"
                      "--clang-tidy"
                      "--all-scopes-completion"
                      "--completion-style=detailed"
                      "--background-index"
                      "--pch-storage=memory"
                      "--header-insertion=never"
                      "--header-insertion-decorators=0"))))

  :hook
  ((c++-ts-mode . eglot-ensure)))


(provide 'cpp)
;;; cpp.el ends here
