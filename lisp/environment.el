;;; environment.el --- Work environment info -*- lexical-binding: t; -*-

;;; Commentary:
;; Various information related to environment info.

;;; Code:

(defvar os-linux (string-equal system-type "gnu/linux")
  "Running on Linux.")

(defvar os-macos (string-equal system-type "darwin")
  "Running on macOS.")

(provide 'environment)
;;; environment.el ends here
