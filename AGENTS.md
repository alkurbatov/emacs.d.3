# AGENTS.md

## Rules

- Before any code change, explain what is wrong and why the proposed fix
  is right, then wait for explicit approval. A request to review,
  investigate or explain is never approval. Never edit silently, even for
  trivial changes.
- Ask instead of guessing whenever a task, a requirement or the intent
  behind an existing decision can be read in more than one way.
- Criticize freely: say plainly when a design or request looks wrong,
  name the concrete problem, propose the alternative. Do not soften a
  finding, do not invent objections.
- Minimal diff: do not refactor unrelated code.
- Numbers, paths, versions, env variable names, commands, dependencies
  and routes come from the repository, never invented.
- Do not read or commit `.env`, tokens or secrets.

## Requirements

- GNU Emacs 31.1 or newer.
- Linux (Debian, Fedora) or macOS — no other platform is supported.

## Project structure

- `lisp/` — one module per feature/tool, `use-package` conventions,
  required from `init.el` in load order.
- `snippets/` — yasnippet templates.
- `specs/` — design specs for non-trivial features.
- `tools/install` — installs this configuration into the current system.
- `tools/install-deps` — installs additional system dependencies.
- `early-init.el` — loaded before `init.el`, GUI/frame tweaks.
- `init.el` — entry point, requires `lisp/` modules in load order.
- `package-lock.el` — locked package versions, updated via
  `make copy-lock`.
- `.pre-commit-config.yaml` — lint hooks, see below.

Check `specs/` first when picking up or resuming a feature; add a spec
before implementing anything non-trivial.

## Style and testing

Conventions: [specs/style.md](specs/style.md) and
[specs/unit-testing.md](specs/unit-testing.md). Run the suite with
`make test`.

Every change must pass `pre-commit run --all-files`: markdownlint,
`elisp-indent`, `elisp-check-parens`, shellcheck, and the whitespace and
end-of-file fixers. The test suite is not one of the hooks — run it
separately.
