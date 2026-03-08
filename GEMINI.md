# Workspace Context: Personal Configuration (.config)

This directory contains configuration files for various CLI tools and development environments.

## Directory Overview

This is a personal configuration repository (part of a dotfiles setup) for:
- **Neovim (`nvim/`)**: Modular editor setup using `lazy.nvim`.
- **Ghostty (`ghostty/`)**: Terminal emulator configuration with custom keybindings and theme.
- **Yazi (`yazi/`)**: Terminal file manager configuration.

## Key Files & Tools

### Neovim Configuration (`nvim/`)
The Neovim configuration is modularized for better maintainability:
- **`init.lua`**: Entry point that bootstraps `lazy.nvim` and loads configuration modules.
- **`lua/config/options.lua`**: Standard Vim options (`vim.opt`) and global variables (`vim.g`).
- **`lua/config/keymaps.lua`**: General, non-plugin keybindings (navigation, viewport, Zen Mode).
- **`lua/plugins/`**: Individual plugin specifications. Each file returns a table for `lazy.nvim`, including plugin-specific keymaps using the `keys` property.
    - `lsp.lua`: LSP, Mason, CMP, and diagnostics.
    - `conform.lua`: Formatting via `stylua` and `taplo`.
    - `treesitter.lua`: Syntax highlighting.
    - `telescope.nvim`: Fuzzy finding and LSP navigation.
    - `test.lua`: Testing via `vim-test`.
    - `everforest.lua`: Theme configuration.

### Ghostty (`ghostty/config`)
- **Theme**: Matrix-inspired with a pure black background (`000`).
- **Font Size**: 16.
- **Keybinds**:
    - `cmd+ctrl+shift+h/j/k/l`: Resize splits (left, down, up, right) by 50 units.

### Yazi (`yazi/yazi.toml`)
- **Layout**: Custom ratio `[0, 2, 6]` for manager panels.

## Usage & Development Workflow

### Formatting & Linting
- In Neovim, formatting is triggered on save for Lua and TOML files via `conform.nvim`.
- Manual formatting can be triggered with `<leader>f`.

### Testing
- Tests are run within Neovim using `vim-test`. Use `<leader>tf` to test the entire file or `<leader>tn` for the test under the cursor.

### Configuration Management
- This directory is typically part of a larger dotfiles repository. Changes should be made surgically to individual config files. Plugin-specific changes (including keymaps) should be made in their respective files in `lua/plugins/`.
