;;; cpp.el --- C/C++ programming environment -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

;; 📦 C++-TS-MODE
;; Tree-sitter integration for C++.
(use-package c++-ts-mode
  :config
  ;; Style.
  (setopt c-ts-mode-indent-style 'k&r)
  (setopt c-ts-mode-indent-offset 4)

  (setopt c-ts-mode-enable-doxygen t)

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
                      "--header-insertion=iwyu"
                      "--header-insertion-decorators=0"))))

  :hook
  (c++-ts-mode . eglot-ensure))


(add-to-list 'auto-mode-alist '("/\\.clang-format\\'" . yaml-ts-mode))
(add-to-list 'auto-mode-alist '("/\\.clang-tidy\\'" . yaml-ts-mode))
(add-to-list 'auto-mode-alist '("/\\.clangd\\'" . yaml-ts-mode))

;; Force C++ mode for all headers.
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-ts-mode))

(provide 'cpp)
;;; cpp.el ends here
