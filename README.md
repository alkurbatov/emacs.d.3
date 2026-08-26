# emacs.d.3

The third incarnation of my Emacs configuration.

## Requirements

- Linux (Debian, Fedora) or macOS.
- Emacs >= 31.1.

## Installation

1. Install additional dependencies:

   ```bash
   make deps
   ```

1. Install the project:

   ```bash
   make install
   ```

## Project structure

```text
├── lisp                # one module per feature/tool, use-package conventions,
│                       # required from init.el in load order
│
├── snippets            # yasnippet templates
│
├── specs               # design specs for non-trivial features
│
├── tools
│   ├── install         # installs this configuration into the current system
│   └── install-deps    # installs additional system dependencies
│
├── early-init.el       # loaded before init.el, GUI/frame tweaks
├── init.el             # entry point, requires modules in lisp/ in load order
│
├── CLAUDE.md
├── LICENSE
├── Makefile
├── package-lock.el     # locked package versions, updated via 'make copy-lock'
└── README.md
```

## Additional tweaks

### Recommended `Pyright` setup

To provide automatic activation of virtual environments create
`pyrightconfig.json` file in the root of your project with the following
content:

``` json
{
  "venvPath": "absolute-path-to-the-folder-containing-venv",
  "venv": "name of the venv folder, e.g. .venv"
}
```
