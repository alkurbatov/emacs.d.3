;;; personal-calendar.el --- Calendar configuration -*- lexical-binding: t; -*-

;;; Commentary:
;; Personal calendar configuration.

;;; Code:

;; 📦 CALENDAR
(use-package calendar
  :custom
  ;; Start week from Monday.
  (calendar-week-start-day 1))

(provide 'personal-calendar)
;;; personal-calendar.el ends here
