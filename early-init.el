;;; early-init.el --- Early initialization routine -*- lexical-binding: t; -*-

;;; Commentary:
;; The very first initialization code Emacs runs. Used for lowlevel
;; optimizations and special settings.

;;; Code:

(when (< emacs-major-version 31)
  (error (format "Emacs >= 31.0.50 required")))

;; Disable weird overwrite-mode.
(put 'overwrite-mode 'disabled t)

;; Tweak garbage collector to make startup faster.
;; See https://emacsconf.org/2023/talks/gc/
(setopt gc-cons-threshold (* 80 1024 1024))

;; Reset garbage collector limit after the init process has ended.
(add-hook 'after-init-hook
          #'(lambda () (setopt gc-cons-threshold (* 800 1024))))

(setopt inhibit-startup-screen t) ; don't show startup screen

;; We use straight.el so no need to preload the package module.
(setopt package-enable-at-startup nil)

;; No menu bar.
(when (fboundp 'menu-bar-mode)
  (setopt menu-bar-mode nil))

;; No scrolls.
(when (fboundp 'scroll-bar-mode)
  (setopt scroll-bar-mode nil
          horizontal-scroll-bar-mode nil))

;; No toolbar.
(when (fboundp 'tool-bar-mode)
  (setopt tool-bar-mode nil))

;; Don't show tooltips in GUI.
(when (fboundp 'tooltip-mode)
  (tooltip-mode nil))

(defun my/display-starttup-stats ()
  "Show some startup statistics in the *Messages* buffer."
  (message "Emacs ready in %s with %d garbage collections."
           (format "%.2f seconds"
                   (float-time (time-subtract after-init-time before-init-time)))
           gcs-done))

(add-hook 'emacs-startup-hook #'my/display-starttup-stats)

;;; early-init.el ends here
