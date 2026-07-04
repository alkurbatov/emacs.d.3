;;; protobuf.el --- Protobuf format support -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

;; Add protobuf support, we use the same library as NeoVim does.
(add-to-list 'treesit-language-source-alist
             '(proto "https://github.com/treywood/tree-sitter-proto"))

(unless (file-expand-wildcards
         (expand-file-name
          "tree-sitter/libtree-sitter-proto.*"
          user-emacs-directory))
  (treesit-install-language-grammar 'proto))


;; 📦 PROTOBUF-TS-MODE
;; Tree-sitter integration for Protobuf.
(use-package protobuf-ts-mode
  :straight t

  :mode
  ("\\.proto\\'" . protobuf-ts-mode)

  :hook
  (protobuf-ts-mode . subword-mode))


(provide 'protobuf)
;;; protobuf.el ends here
