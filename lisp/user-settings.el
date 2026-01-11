;;; user-settings.el --- User-specific settings -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(defconst my/font-family "JetBrains Mono" "The default font family.")
(defconst my/font-height 13 "The default font height.")
(defconst my/font-ligatures
  '("-->" "//" "/**" "/*" "*/" "<!--" ":=" "->>" "<<-" "->" "<-"
    "<=>" "==" "!=" "<=" ">=" "=:=" "!==" "&&" "||" "..." ".."
    nil nil nil nil nil nil nil nil nil nil nil nil nil nil
    "|||" "///" "&&&" "===" "++" "--" "=>" "|>" "<|" "||>" "<||"
    "|||>" "<|||" ">>" "<<" nil nil "::=" "|]" "[|" "{|" "|}"
    "[<" ">]" ":?>" ":?" nil "/=" "[||]" "!!" "?:" "?." "::"
    "+++" "??" "###" "##" ":::" "####" ".?" "?=" "=!=" "<|>"
    "<:" ":<" ":>" ">:" "<>" nil ";;" "/==" ".=" ".-" "__"
    "=/=" "<-<" "<<<" ">>>" "<=<" "<<=" "<==" "<==>" "==>" "=>>"
    ">=>" ">>=" ">>-" ">-" "<~>" "-<" "-<<" "=<<" "---" "<-|"
    "<=|" "/\\" "\\/" "|=>" "|~>" "<~~" "<~" "~~" "~~>" "~>"
    "<$>" "<$" "$>" "<+>" "<+" "+>" "<*>" "<*" "*>" "</>" "</" "/>"
    "<->" "..<" "~=" "~-" "-~" "~@" "^=" "-|" "_|_" "|-" "||-"
    "|=" "||=" "#{" "#[" "]#" "#(" "#?" "#_" "#_(" "#:" "#!" "#="
    "&="))

;; Whoami.
(setopt user-full-name "Aleksandr Kurbatov"
        user-mail-address "sir.alkurbatov@yandex.ru")

;; Input method.
(setopt default-input-method "russian-computer"
        default-transient-input-method "russian-computer")

(defcustom my/emacs-src ""
  "Path to Emacs sources."
  :type 'string)

(defcustom my/backups-directory (concat user-emacs-directory "backups")
  "Where Emacs should store backups."
  :type 'string)

(defcustom my/auto-save-directory (concat user-emacs-directory "auto-save")
  "Where Emacs should store auto saved files."
  :type 'string)

(defcustom my/recentf-directory (concat user-emacs-directory "recentf")
  "Where Emacs should store list of recently opened files.
This is path to a file, not to a directory."
  :type 'string)

(defcustom my/elfeed-db-directory (concat user-emacs-directory "elfeed")
  "Path to the folder containing Elfeed RSS database."
  :type 'string)


;; Allow to cal `eval' in `.dir-locals.el'.
(setopt enable-local-eval t)

;; Assume that `.dir-locals.el' is safe.
(setopt enable-local-variables :all)

(provide 'user-settings)
;;; user-settings.el ends here
