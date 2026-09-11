# org-to-telegram

Converts the current org buffer into a Telegram-ready post and shows the
result in a new buffer for manual copying.

## Module

`site-lisp/org-to-telegram/org-to-telegram.el`

## Public API

Only one function, interactive, no separate reusable string-conversion API:

- `my/org-to-telegram-buffer` — operates on the whole current buffer.
  Shows the converted post in a new buffer
  (`*Telegram Post*`, `text-mode`, read-only) for the user to read/copy
  from manually.

## Target markup

The post is written in the markup the **Telegram client** itself parses
when text is typed or pasted into a message — not the Bot API's
`Markdown`/`MarkdownV2`, whose markers differ (`*bold*`, `~strike~`).
The output is meant to be copied by hand from the `*Telegram Post*`
buffer into a chat, so the client's flavour is the one that has to
match:

| Formatting    | Marker            |
|---------------|-------------------|
| bold          | `**text**`        |
| strikethrough | `~~text~~`        |
| link          | `[text](url)`     |

Link markup is understood by Telegram Desktop; mobile clients accept the
emphasis markers but not `[text](url)`, so a link pasted there stays
literal text. That is accepted: the post is composed on the desktop.

Any marker added later (italic, spoiler, code) must come from the same
client flavour.

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
   and emitted as a `**bold**` first line of the post.
1. **Other keywords / drawers**: all other `keyword` nodes and any
   `property-drawer`/`node-property` nodes are skipped while walking —
   not rendered, not descended into.
1. **Headlines** (`headline` nodes, any `:level`): rendered as a single
   `**bold**` line built from the headline's title content (rule 5). Level,
   TODO keyword, priority cookie, and tags are not part of the rendered
   title, so they're dropped implicitly rather than by special-casing.
1. **Paragraphs**: rendered as a single line. Org stores a
   fill-column-wrapped paragraph as one string with a literal newline at
   each wrap point; since Telegram does not fill text itself, those
   newlines (and any leading whitespace after them) are joined into a
   single space instead of being reproduced as short lines.
1. **Lists** (`item` nodes inside a `plain-list`): rendered as
   `<indentation>• <rendered contents>`, one line per item. Indentation
   comes from the item's source column (`:begin` minus line start);
   the marker — ordered or unordered, whatever the original — is always
   replaced by `•`. Wrapped continuation text belonging to the same item
   stays part of that item's rendered line, with the same line-joining
   as paragraphs (including stripping the continuation line's source
   indentation). Nested lists are out of scope — see below.
1. **Links** (`link` objects): rendered as `[description](url)` when the
   link has description content (arbitrary nested text, including literal
   brackets — the AST already isolates it, no bracket-matching needed),
   otherwise `[url](url)`.
1. **Plain text** (`plain-text` nodes): passed through unchanged, no
   escaping.
1. **Strikethrough** (`strike-through` objects): org's `+text+` is
   rendered as `~~text~~` per "Target markup" above. The contents are
   rendered by the same inline rules, so nested objects (e.g. a link)
   keep their own rendering.
1. **Everything else** (`src-block`, `quote-block`, `bold`, `italic`,
   `underline`, `verbatim`, etc.): not given special
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
- Escaping of characters the client would read as markup (a literal
  `**`, `~~`, `` ` `` or `[` in the source text is emitted as is).
- Bot API output — neither the `MarkdownV2` flavour nor its escaping
  rules; see "Target markup".
- Every element left to rule 9: emphasis other than strikethrough,
  `#+BEGIN_SRC` / `#+BEGIN_QUOTE` blocks.
- TODO keywords, priorities, tags on headlines.
- Sending the post anywhere (Bot API, clipboard, etc.) — output is a
  buffer only.
