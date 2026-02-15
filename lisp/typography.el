;;; typography.el --- Fonts configuration -*- lexical-binding: t; -*-

;;; Commentary:
;; Configure fonts and characters appearance.

;;; Code:

(require 'user-settings)

(defun my/set-font (font-family font-height)
  "Set provide FONT-FAMILY as main font and set it's FONT-HEIGHT.
Settings should be provided in format of X Logical Font Description Conventions,
XLFD: https://www.x.org/releases/X11R7.7/doc/xorg-docs/xlfd/xlfd.html"
  (set-frame-font (format "-*-%s-normal-normal-normal-*-%d-*-*-*-m-0-iso10646-1"
                          font-family
                          font-height)
                  nil ;; don't save previously set height
                  t   ;; apply to all frames
                  t)  ;; ignore settings from `customize'
  (set-face-attribute
   'default ;; default Font Face
   nil      ;; apply to all frames
   :height (* font-height 10)
   :family font-family)

  ;; Set up font height.
  ;; The font size is set in typographic points, which means it must
  ;; be 10 times larger than specified in the `my/font-height'."
  (set-face-attribute 'default nil :height (* font-height 10)))

(defun my/setup-fonts (&optional frame-name)
  "Setup fonts in FRAME-NAME."
  (when (display-graphic-p frame-name)
    (my/set-font my/font-family my/font-height)

    ;; Set scale increase step to 10%.
    (setopt text-scale-mode-step 1.1)

    ;; Put additional space between lines.
    (setopt line-spacing my/line-spacing)))


;; 📦 LIGATURE
;; Enables font ligatures.
(use-package ligature
  :straight t
  :when (display-graphic-p)

  :config
  (ligature-set-ligatures 't my/font-ligatures)

  (global-ligature-mode))

;; 📦 EMOJIFY
;; Display emojis in Emacs.
(use-package emojify
  :straight t

  :bind
  ("C-x e" . emojify-insert-emoji))


(add-hook 'after-init-hook #'my/setup-fonts)
(add-to-list 'after-make-frame-functions 'my/setup-fonts)

;; Show fonts using Font Face's.
(global-font-lock-mode t)

;; Don't compress fonts in RAM.
(setopt inhibit-compacting-font-caches t)

(provide 'typography)
;;; typography.el ends here
