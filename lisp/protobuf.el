;;; protobuf.el --- Protobuf format support -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

;; Add protobuf support, we use the same library as NeoVim does.
(add-to-list 'treesit-language-source-alist
             '(proto "https://github.com/treywood/tree-sitter-proto"))

(let ((compiled-grammar (expand-file-name "tree-sitter/libtree-sitter-proto.so" user-emacs-directory)))
  (unless (file-exists-p compiled-grammar)
    (treesit-install-language-grammar 'proto)))

;; 📦 PROTOBUF-TS-MODE
;; Tree-sitter integration for Protobuf.
(use-package protobuf-ts-mode
  :straight t)


(provide 'protobuf)
;;; protobuf.el ends here
