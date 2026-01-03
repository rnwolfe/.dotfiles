# dotfiles-personal (chezmoi)

Base dotfiles + packages + mise toolchain. Applies everywhere.

## Apply on a new machine

**Install & apply in one shot (recommended first run):**

Use the official chezmoi installer and run init+apply:

### From scratch (fresh OS)

If `curl` is missing:

```sh
sudo apt update
sudo apt install -y curl git
```

Then run the installer:

```sh
sh -c "$(curl -fsLS https://get.chezmoi.io)" -- init --apply https://github.com/rnwolfe/.dotfiles.git
```

`chezmoi init` can generate your `~/.config/chezmoi/chezmoi.toml` from `.chezmoi.toml.tmpl`, and `--apply` runs `chezmoi apply`.

**Follow prompts (name/email + LastPass login email).***

## Apply work overlay (optional)

After personal is applied:

```sh
chezmoi -S ~/.local/share/chezmoi-work init --apply https://github.com/rnwolfe/.dotfiles.git
```

`-S` switches the source dir so you can keep personal and work as separate repos.

## Daily iteration loop

Edit source and apply immediately:

```sh
chezmoi edit --apply ~/.zshrc
```

Or open the whole source dir:

```sh
chezmoi cd
```

`chezmoi edit --apply` is the fast path for tight iteration.

## Extend and customize

Common places to add or change things:

- LastPass keys: update the `keys=(...)` list in `dot_config/zsh/private_90-secrets.zsh.tmpl`. Create matching LastPass items with the key name and store the secret in the note field.
- Packages (apt): edit `.chezmoiscripts/run_onchange_before_00_packages.sh.tmpl`.
- Mise toolchain: edit `dot_config/mise/config.toml`.
- Zsh plugins: edit `dot_config/zsh/30-plugins.zsh`.
- Aliases: edit `dot_config/zsh/20-aliases.zsh`.
- Custom scripts: add new scripts under `.chezmoiscripts/` (run_once/run_onchange/run_before/run_after prefixes).
- Manual installs (npm/go/curl): edit `.chezmoiscripts/run_onchange_after_30_manual.sh.tmpl` and add idempotent commands.

After changes:

```sh
chezmoi apply
```

## Reset loop (fast “clean slate” testing)

Remove chezmoi state/config/source (leaves target files in place):

```sh
chezmoi purge --force
```

Remove *managed* target files (interactive):

```sh
rm -i $(chezmoi managed)
```
