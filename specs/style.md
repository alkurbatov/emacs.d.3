# style

Coding conventions for `lisp/*.el` modules.

- `lisp/*.el` modules follow `use-package` conventions and end with
  `(provide 'module-name)`.
- Use `my/`-prefix for custom commands.
- Docstrings: the first line must be a complete, self-contained sentence
  — some commands (e.g. `apropos`) display only the first line.

## Specs

- `specs/*.md` files must pass the `mdl` linter (run `mdl specs/`).
