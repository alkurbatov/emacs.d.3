# style

Coding conventions for `lisp/*.el` modules.

- `lisp/*.el` modules follow `use-package` conventions and end with
  `(provide 'module-name)`.
- Use `my/`-prefix for custom commands.
- Docstrings: the first line must be a complete, self-contained sentence
  — some commands (e.g. `apropos`) display only the first line.

## Markdown

- All Markdown in the repository, not just `specs/`, must pass the
  `markdownlint` pre-commit hook (run `mdl .` locally).
