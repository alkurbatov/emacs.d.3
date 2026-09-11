# unit-testing

Conventions for writing and running unit tests for `lisp/*.el` modules.

## Framework

`ert`, built into Emacs. No external test dependency (e.g. `buttercup`).

## Layout

- One test file per module, colocated in `lisp/`:
  `lisp/module-name.el` → `lisp/module-name-test.el`. The same holds for
  a `site-lisp/` project: its tests live in the project's own directory,
  next to the project's own `Makefile`.
- Test files are not `require`d from `init.el` or any other module — they
  are only loaded when running tests.
- `(require 'module-name)` at the top of the test file.

## Writing tests

- Name tests `module-name-test/thing-being-tested`, so `M-x ert` regexps
  can filter by module.
- One behavior per `ert-deftest`; use `should`, `should-not`,
  `should-error`.
- For `my/`-prefixed interactive commands, prefer testing the underlying
  logic function rather than the command itself — extract a pure helper
  the command calls, and test that.
- Isolate side effects: use `with-temp-buffer`, and `cl-letf` to stub
  `read-string`, file I/O, network calls, `process-*` functions, etc., so
  tests don't touch real files, buffers, or external processes.
- Avoid depending on global state (`default-directory`, hooks,
  `emacs-version`) — bind it locally with `let`.

## Running tests

```bash
make test
```

The root target delegates to each `site-lisp/` project's own `test`
target, so a project's suite can also be run on its own:

```bash
make -C site-lisp/org-to-telegram test
```

Every target runs its test files in a single batch `emacs` invocation via
`ert-run-tests-batch-and-exit`. There are currently no `lisp/*-test.el`
files; adding one means giving the root `test` target its own `emacs`
invocation again.

The suite is not part of the pre-commit hooks — run it separately.
