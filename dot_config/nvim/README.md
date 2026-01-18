# AstroNvim Configuration

This directory is managed by chezmoi but the actual AstroNvim setup
is handled by the `run_once_after_40_astronvim.sh.tmpl` script which
clones the official AstroNvim template on first run.

## Post-Installation

After `chezmoi apply`:
1. Run `nvim` - plugins will auto-install on first launch
2. Use `:LspInstall <language>` to add language servers
3. Use `:TSInstall <language>` for syntax highlighting
4. Run `:checkhealth` to verify setup

## Customization

Add custom plugins in `~/.config/nvim/lua/plugins/`
