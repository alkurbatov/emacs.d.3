# org-to-telegram

Converts the current org buffer into a Telegram-ready post and shows the
result in a new buffer for manual copying. No sending, no clipboard
integration, no escaping in this version.

## Module

`lisp/org-to-telegram.el`

## Public API

Only one function, interactive, no separate reusable string-conversion API:

- `my/org-to-telegram-buffer` — operates on the whole current buffer (no
  region support). Shows the converted post in a new buffer
  (`*Telegram Post*`, `text-mode`, read-only) for the user to read/copy
  from manually.

## Approach

Parse the current buffer with `org-element-parse-buffer` into an AST and
walk it (`org-element-map`) to build the post, rather than processing the
buffer line by line. This makes the converter robust to formatting
variations (link/description edge cases, indentation, keyword order/casing)
and gives a natural extension point for future element types (e.g. src
blocks, quote blocks, emphasis) — later versions add a case, not a
rewrite.

## Conversion rules

1. **Title**: the `keyword` node whose `:key` is `"TITLE"` (case-insensitive
   per `org-element`). Its `:value` is rendered (inline elements per rule 5)
   and emitted as a `*bold*` first line of the post.
1. **Other keywords / drawers**: all other `keyword` nodes and any
   `property-drawer`/`node-property` nodes are skipped while walking —
   not rendered, not descended into.
1. **Headlines** (`headline` nodes, any `:level`): rendered as a single
   `*bold*` line built from the headline's title content (rule 5). Level,
   TODO keyword, priority cookie, and tags are not part of the rendered
   title, so they're dropped implicitly rather than by special-casing.
1. **Lists** (`item` nodes inside a `plain-list`): rendered as
   `<indentation>• <rendered contents>`, one line per item. Indentation
   comes from the item's source column (`:begin` minus line start);
   the marker — ordered or unordered, whatever the original — is always
   replaced by `•`. Wrapped continuation text belonging to the same item
   stays part of that item's rendered line. Only single-level (plain)
   lists are supported — see "Explicitly out of scope" below.
1. **Links** (`link` objects): rendered as `[description](url)` when the
   link has description content (arbitrary nested text, including literal
   brackets — the AST already isolates it, no bracket-matching needed),
   otherwise `[url](url)`.
1. **Plain text** (`plain-text` nodes): passed through unchanged, no
   escaping.
1. **Everything else** (`src-block`, `quote-block`, `bold`, `italic`,
   `underline`, `verbatim`, `strike-through`, etc.): not given special
   handling in this version — rendered via their contained text with no
   markup added or stripped beyond what the rules above already cover.
   This is what makes those cases "out of scope" rather than "broken":
   adding a rule for one later is a new `org-element-map` case, not a
   parser change.

## Explicitly out of scope (v1)

- Nested lists — a `plain-list` inside an `item`. Only flat, single-level
  lists are rendered correctly; a nested list's items are walked and
  rendered as their own lines rather than folded into their parent item.
- Region support (whole buffer only).
- Escaping of reserved MarkdownV2 characters.
- Emphasis conversion (bold/italic/underline/verbatim/strikethrough).
- `#+BEGIN_SRC` / `#+BEGIN_QUOTE` blocks.
- TODO keywords, priorities, tags on headlines.
- Sending the post anywhere (Bot API, clipboard, etc.) — output is a
  buffer only.
