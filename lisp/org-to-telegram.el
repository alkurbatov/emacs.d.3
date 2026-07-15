;;; org-to-telegram.el --- Convert org buffer to a Telegram post -*- lexical-binding: t; -*-

;;; Commentary:
;; Converts the current org buffer into a Telegram-ready post and shows the
;; result in a new buffer for manual copying.  See specs/org-to-telegram.md
;; for the conversion rules.

;;; Code:

(defun org-to-telegram--render-link (link)
  "Render LINK as [description](url), falling back to [url](url)."
  (let* ((url (org-element-property :raw-link link))
         (description (org-to-telegram--render (org-element-contents link))))
    (format "[%s](%s)" (if (string-empty-p description) url description) url)))

(defun org-to-telegram--render-node (node)
  "Render a single org NODE (string or element/object) as plain text.
For an object (e.g. a link, bold, verbatim), trailing whitespace up to
the next object is tracked in its `:post-blank' property rather than
appearing as literal text, so it is reproduced here."
  (if (stringp node)
      node
    (concat
     (if (eq (org-element-type node) 'link)
         (org-to-telegram--render-link node)
       (let ((contents (org-element-contents node)))
         (if contents
             (org-to-telegram--render contents)
           (or (org-element-property :value node) ""))))
     (make-string (or (org-element-property :post-blank node) 0) ?\s))))

(defun org-to-telegram--render (nodes)
  "Render a list of org NODES (strings and/or elements/objects) as plain text."
  (mapconcat #'org-to-telegram--render-node nodes ""))

(defun org-to-telegram--item-indentation (item)
  "Return the source column ITEM's bullet starts at."
  (let ((begin (org-element-property :begin item)))
    (- begin (save-excursion (goto-char begin) (line-beginning-position)))))

(defun org-to-telegram--render-item (item)
  "Render list ITEM as its source indentation, a bullet, and its own text."
  (format "%s• %s"
          (make-string (org-to-telegram--item-indentation item) ?\s)
          (string-trim-right (org-to-telegram--render (org-element-contents item)))))

(defun org-to-telegram--bold (text)
  "Wrap TEXT in Telegram bold markers."
  (format "*%s*" text))

(defun org-to-telegram--render-title (keyword)
  "Render the value of the TITLE KEYWORD node, or nil if it isn't TITLE."
  (when (string-equal-ignore-case (org-element-property :key keyword) "TITLE")
    (org-to-telegram--bold
     (org-to-telegram--render
      (org-element-parse-secondary-string
       (org-element-property :value keyword)
       (org-element-restriction 'keyword)
       keyword)))))

(defun org-to-telegram--render-headline (headline)
  "Render HEADLINE as a single bold line built from its title."
  (org-to-telegram--bold (org-to-telegram--render (org-element-property :title headline))))

(defun org-to-telegram--render-paragraph (paragraph)
  "Render PARAGRAPH as its own block.
Returns nil when PARAGRAPH belongs to a list item, since
`org-to-telegram--render-item' already renders it as part of that
item's line."
  (unless (eq (org-element-type (org-element-parent paragraph)) 'item)
    (string-trim-right (org-to-telegram--render (org-element-contents paragraph)))))

(defun org-to-telegram--render-block (node)
  "Render NODE (a keyword, headline, item, or paragraph) as one post line.
Returns nil to skip NODE."
  (pcase (org-element-type node)
    ('keyword (org-to-telegram--render-title node))
    ('headline (org-to-telegram--render-headline node))
    ('item (org-to-telegram--render-item node))
    ('paragraph (org-to-telegram--render-paragraph node))))

(defun org-to-telegram--join-blocks (nodes)
  "Concatenate the rendered blocks in NODES, keeping blank lines from the source.
NODES is a list of (TEXT . NODE) pairs in document order, one per node
matched while walking the buffer; TEXT is nil for nodes skipped by
`org-to-telegram--render-block' (e.g. a non-TITLE keyword) — such nodes
contribute no text but still count towards whether a blank line
separates the surrounding blocks.  A blank line is detected from any of:
a node's own `:post-blank'; a gap between its `:begin' and the previous
node's `:end' (catches blank lines org-element attributes to an
enclosing container instead of the node itself, e.g. the blank line
that ends a list is on the `plain-list', not its last item); or a
node's own `:pre-blank' (catches the blank line between a headline's
title and its first child, e.g. `* Headline\\n\\nBody text', which
org-element attributes to the headline rather than to what follows it —
the headline's `:end' spans its whole subtree, so the `:begin'/`:end'
gap check can't see it either)."
  (let (result pending-blank prev-end)
    (dolist (pair nodes)
      (let ((node (cdr pair)))
        (when (and prev-end (> (org-element-property :begin node) prev-end))
          (setq pending-blank t))
        (when (car pair)
          (when result
            (setq result (concat result (if pending-blank "\n\n" "\n"))))
          (setq result (concat (or result "") (car pair)))
          (setq pending-blank nil))
        (when (or (> (or (org-element-property :post-blank node) 0) 0)
                  (> (or (org-element-property :pre-blank node) 0) 0))
          (setq pending-blank t))
        (setq prev-end (org-element-property :end node))))
    (or result "")))

(defun org-to-telegram--convert-buffer ()
  "Convert the current org buffer into a Telegram-ready post string."
  (org-to-telegram--join-blocks
   (org-element-map (org-element-parse-buffer)
                    '(keyword headline item paragraph)
                    (lambda (node) (cons (org-to-telegram--render-block node) node))
                    nil nil '(property-drawer drawer))))

(defun my/org-to-telegram-buffer ()
  "Convert the current org buffer into a Telegram post.
Shows the result in a read-only `*Telegram Post*' buffer for manual copying."
  (interactive)

  ;; Ensure org is loaded before use, mimicking autoload behavior: the
  ;; function is available immediately after config load, but org itself
  ;; is deferred until first call.
  (require 'org-element)

  (let ((post (org-to-telegram--convert-buffer)))
    (with-current-buffer (get-buffer-create "*Telegram Post*")
      (let ((inhibit-read-only t))
        (erase-buffer)
        (insert post)
        (text-mode)
        (read-only-mode 1)
        (goto-char (point-min)))
      (display-buffer (current-buffer)))))

(provide 'org-to-telegram)
;;; org-to-telegram.el ends here
