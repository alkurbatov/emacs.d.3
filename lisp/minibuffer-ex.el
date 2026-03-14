;;; minibuffer-ex.el --- Extended minibuffer settings -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(defun my/vertico-file-sort-key (f)
  "Return a string sort key for file candidate F.
Encodes group (.dir/dir/.file/file), case (upper/lower), then name."
  (let ((group (cond ((and (string-prefix-p "." f) (string-suffix-p "/" f)) 0)
                     ((string-suffix-p "/" f) 1)
                     ((string-prefix-p "." f) 2)
                     (t 3)))
        (upper (if (string-match-p "\\`[[:upper:]]" f) 0 1)))
    (format "%d%d%s" group upper f)))

(defun my/vertico-sort-directories-first (candidates)
  "Sort CANDIDATES like Midnight Commander does: .dirs, dirs, .files, files."
  (seq-sort-by #'my/vertico-file-sort-key #'string< candidates))


;; 📦 UNIQUIFY
;; Make unique buffer names.
(use-package uniquify
  :custom
  ;; Show parent folder before buffer name (default is name<parent>).
  (uniquify-buffer-name-style 'forward)

  ;; Buffer name divider for similarly looking names.
  (uniquify-separator "/")

  (uniquify-ignore-buffers-re "^\\*")

  (uniquify-after-kill-buffer-p t))

;; 📦 VERTICO
;; Minimalistic vertical completion UI.
(use-package vertico
  :straight t

  :init
  (vertico-mode)
  (vertico-multiform-mode)

  :config
  ;; Grow and shrink the Vertico minibuffer.
  (setopt vertico-resize nil)

  ;; Show more candidates
  (setopt vertico-count 20)

  ;; No prefix with number of entries.
  (setopt vertico-count-format nil)

  ;; Enable commands execution in the minibuffers to support vertico-suspend.
  (setopt enable-recursive-minibuffers t)

  ;; Cycle through items. Convenient when working with history.
  (setopt vertico-cycle t)

  ;; Show directories before files in find-file (like Midnight Commander).
  (setopt vertico-multiform-categories
          '((file (vertico-sort-function . my/vertico-sort-directories-first))))

  :bind
  (("M-s" . vertico-suspend)
   (:map minibuffer-local-map
         ("M-s" . vertico-suspend))))

;; 📦 MARGINALIA
;; Enable rich annotations using the Marginalia package
(use-package marginalia
  :straight t

  :init
  (marginalia-mode))

;; 📦 ORDERLESS
;; `orderless' completion style.
(use-package orderless
  :straight t

  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles partial-completion))))

  ;; Disable defaults, use our settings.
  (completion-category-defaults nil)

  ;; Emacs 31: partial-completion behaves like substring.
  (completion-pcm-leading-wildcard t))

;; 📦 CONSULT
;; Search and navigation commands.
(use-package consult
  :straight t

  :bind
  (("C-s" . consult-line)
   ("C-x b" . consult-buffer)
   ("M-g g" . consult-goto-line)))


(provide 'minibuffer-ex)
;;; minibuffer-ex.el ends here
