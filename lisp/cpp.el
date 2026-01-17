;;; cpp.el --- C/C++ programming environment -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

;; 📦 C++-TS-MODE
;; Tree-sitter integration for C++.
(use-package c++-ts-mode
  :hook
  ((c++-ts-mode . eglot-ensure)))


(provide 'cpp)
;;; cpp.el ends here
