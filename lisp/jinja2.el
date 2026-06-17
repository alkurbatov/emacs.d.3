;;; jinja2.el --- Jinja2 template support -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(add-to-list 'auto-mode-alist '("\\.ya?ml\\.j2\\'" . yaml-ts-mode))
(add-to-list 'auto-mode-alist '("\\.toml\\.j2\\'" . toml-ts-mode))
(add-to-list 'auto-mode-alist '("\\.conf\\.j2\\'" . conf-mode))


(provide 'jinja2)
;;; jinja2.el ends here
