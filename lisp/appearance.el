;;; appearance.el --- UI layout and settings -*- lexical-binding: t; -*-

;;; Commentary:
;; Setup UI layout and appearance.

;;; Code:

;; 📦 EF-THEMES
;; Nice-looking themes from Protesilaos Stavrou.
(use-package ef-themes
  :straight t

  :init
  (ef-themes-take-over-modus-themes-mode 1)

  :config
  ;; Assume that all themes are safe.
  (setopt custom-safe-themes t)

  ;; All customisations here.
  (setq modus-themes-mixed-fonts t)

  (modus-themes-load-theme 'ef-maris-dark))

;; 📦 DISPLAY-LINE-NUMBERS-MODE
;; Show line numbers.
(use-package display-line-numbers
  :hook
  ((prog-mode
    text-mode) . display-line-numbers-mode))

;; 📦 FILL-COLUMN
;; Show recommended line end border.
(use-package display-fill-column-indicator
  :config
  (setopt fill-column 80)

  :hook
  ((prog-mode
    text-mode) . display-fill-column-indicator-mode))

;; 📦 PAREN
;; Control paired brackets.
(use-package paren
  :config
  ;; Highlight paired brackets.
  (show-paren-mode t))

;; 📦 WINDOW
(use-package window
  :custom
  ;; Divide windows by pixels not by symbols.
  (window-resize-pixelwise t))

;; 📦 TRAILING-NEWLINE-INDICATOR
;; Show an indicator for the trailing newline in the end of the file.
(use-package trailing-newline-indicator
  :straight t

  :config
  (setopt trailing-newline-indicator-show-line-number nil)

  (add-to-list 'mode-line-collapse-minor-modes 'trailing-newline-indicator-mode)

  :hook
  (after-init . global-trailing-newline-indicator-mode))

;; 📦 PIXEL-SCROLL
;; Smooth scrolling.
(use-package pixel-scroll
  :config
  (pixel-scroll-mode t)
  (pixel-scroll-precision-mode)

  (setopt scroll-margin 0
          mouse-wheel-progressive-speed nil
          pixel-scroll-precision-interpolate-page t
          pixel-scroll-precision-large-scroll-height 1))

;; 📦 HL-LINE
;; Highlight line with cursor.
(use-package hl-line
  :hook
  (after-init . global-hl-line-mode))

;; 📦 WHITESPACE
;; Show spaces, tabs, line endings etc.
(use-package whitespace
  :custom
  (whitespace-style
   '(face spaces empty tabs newline trailing space-mark tab-mark newline-mark))

  (whitespace-display-mappings
   '(
     ;; space -> ·
     (space-mark ?\  [183])
     ;; new line -> $
     (newline-mark ?\n [36 ?\n])
     ;; carriage return (Windows) -> ¶
     (newline-mark ?\r [182])
     ;; tabs -> »
     (tab-mark ?\t [187 ?\t])))

  ;; Don't highlight long lines, there is not much we can do with them.
  (whitespace-line-column nil))

;; 📦 HL-TODO
;; Highlight keywords like TODO, FIXME, etc.
(use-package hl-todo
  :straight t

  :config
  (setopt hl-todo-highlight-punctuation ":")

  (modus-themes-with-colors
   (setopt hl-todo-keyword-faces
           `(("TODO"       . ,yellow-warmer)
             ("XXX"        . ,yellow-warmer)
             ("CRUTCH"     . ,yellow-warmer)
             ("FIXME"      . ,red-warmer)
             ("NB"         . ,cyan-warmer)
             ("NOTE"       . ,cyan-warmer))))

  :hook
  (after-init . global-hl-todo-mode))


(setopt cursor-in-non-selected-windows nil ; hide cursor in inactive windows
        cursor-type 'bar ; cursor as vertical line
        highlight-nonselected-windows nil ;; don't highlight inactive windows
        use-dialog-box nil) ; disable OS dialog boxes

(provide 'appearance)
;;; appearance.el ends here
