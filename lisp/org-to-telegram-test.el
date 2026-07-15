;;; org-to-telegram-test.el --- Tests for org-to-telegram -*- lexical-binding: t; -*-

;;; Commentary:
;; See specs/unit-testing.md for the conventions these tests follow.

;;; Code:

(require 'ert)
(require 'org)
(require 'org-to-telegram)

(defun org-to-telegram-test--convert (org-text)
  "Convert ORG-TEXT (a string of Org markup) into its Telegram-post text."
  (with-temp-buffer
    (org-mode)
    (insert org-text)
    (org-to-telegram--convert-buffer)))

(ert-deftest org-to-telegram-test/standalone-paragraph-is-not-dropped ()
  "A paragraph that isn't a list item or a title is still rendered."
  (should (string-equal
           (org-to-telegram-test--convert
            "Intro paragraph text.

- item one
")
           "Intro paragraph text.

• item one")))

(ert-deftest org-to-telegram-test/list-item-paragraph-is-not-duplicated ()
  "A list item's own paragraph is rendered once, as part of the item's line."
  (should (string-equal
           (org-to-telegram-test--convert
            "- item one
- item two
")
           "• item one
• item two")))

(ert-deftest org-to-telegram-test/space-after-link-is-preserved ()
  "Whitespace following a link (stored in its `:post-blank') is reproduced."
  (should (string-equal
           (org-to-telegram-test--convert
            "Text with [[https://example.com][a link]] and more text.
")
           "Text with [a link](https://example.com) and more text.")))

(ert-deftest org-to-telegram-test/blank-line-between-blocks-is-preserved ()
  "A blank line in the source becomes a blank line in the post.
Its absence keeps blocks on adjacent lines instead."
  (should (string-equal
           (org-to-telegram-test--convert
            "* Headline one
Some text right after headline.

* Headline two
")
           "*Headline one*
Some text right after headline.

*Headline two*")))

(ert-deftest org-to-telegram-test/skipped-keyword-blank-line-is-not-lost ()
  "A skipped non-TITLE keyword does not lose its trailing blank line.
That blank line still separates the surrounding blocks."
  (should (string-equal
           (org-to-telegram-test--convert
            "#+TITLE: My Title
#+DATE: 2024-01-01

Body paragraph.
")
           "*My Title*

Body paragraph.")))

(ert-deftest org-to-telegram-test/blank-line-before-headline-after-list-is-preserved ()
  "The blank line ending a list still separates it from what follows.
Org attributes that blank line to the `plain-list' container rather than
its last item, so this needs its own check."
  (should (string-equal
           (org-to-telegram-test--convert
            "- item one
- item two

* Next headline
")
           "• item one
• item two

*Next headline*")))

(ert-deftest org-to-telegram-test/headline-pre-blank-is-preserved ()
  "A blank line between a headline and its first child is preserved."
  (should (string-equal
           (org-to-telegram-test--convert
            "* Headline

Body text.
")
           "*Headline*

Body text.")))

(ert-deftest org-to-telegram-test/headline-no-pre-blank-is-not-introduced ()
  "No blank line is introduced when the source has none."
  (should (string-equal
           (org-to-telegram-test--convert
            "* Headline
Body text.
")
           "*Headline*
Body text.")))

(ert-deftest org-to-telegram-test/real-headline-renders-only-title ()
  "A property drawer and non-TITLE keywords are skipped, leaving only the title."
  (should (string-equal
           (org-to-telegram-test--convert
            ":PROPERTIES:
:ID:       1020DD61-83B5-4440-84BE-29813C35B753
:END:
#+title: Грустные ИИнсайты
#+filetags: :tgpost:
")
           "*Грустные ИИнсайты*")))

(provide 'org-to-telegram-test)
;;; org-to-telegram-test.el ends here
