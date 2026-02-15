# emacs.d.3

The third incarnation of my Emacs configuration.

## Requirements

- Linux or macOS.
- Emacs >= 31.0.50

## Installation

1. Install additional dependencies:

   ```bash
   make deps
   ```

1. Install the project:

   ```bash
   make install
   ```

## Additional tweaks

### Recommended `Pyright` setup

To provide automatic activation of virtual environments create
`pyrightconfig.json` file in the root of your project with the following content:

``` json
{
  "venvPath": "absolute-path-to-the-folder-containing-venv",
  "venv": "name of the venv folder, e.g. .venv"
}
```
