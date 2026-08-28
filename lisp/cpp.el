;;; cpp.el --- C/C++ programming environment -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(defun my/cpp-switch-source-header ()
  "Switch between a C++ source file and its header via clangd.

Relies on clangd's index (the \"textDocument/switchSourceHeader\"
LSP extension), so it finds the counterpart even when it lives in
a different directory, unlike `ff-find-other-file'."
  (interactive)

  (let ((server (eglot-current-server)))
    (unless server
      (user-error "No active eglot server"))

    (let ((uri (jsonrpc-request server :textDocument/switchSourceHeader
                                (eglot--TextDocumentIdentifier))))
      (if (not (seq-empty-p uri))
          (find-file (eglot-uri-to-path uri))
        (user-error "No matching source/header file found")))))


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
  (c++-ts-mode . eglot-ensure)

  :bind
  (:map c++-ts-mode-map
        ("C-c o" . my/cpp-switch-source-header)))

;; 📦 CMAKE-TS-MODE
;; Tree-sitter integration for CMake.
(use-package cmake-ts-mode
  :hook
  (cmake-ts-mode . eglot-ensure))


(add-to-list 'auto-mode-alist '("/\\.clang-format\\'" . yaml-ts-mode))
(add-to-list 'auto-mode-alist '("/\\.clang-tidy\\'" . yaml-ts-mode))
(add-to-list 'auto-mode-alist '("/\\.clangd\\'" . yaml-ts-mode))

;; Force C++ mode for all headers.
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-ts-mode))

(provide 'cpp)
;;; cpp.el ends here
