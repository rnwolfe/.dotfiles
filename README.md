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

## Reset loop (fast “clean slate” testing)

Remove chezmoi state/config/source (leaves target files in place):

```sh
chezmoi purge --force
```

Remove *managed* target files (interactive):

```sh
rm -i $(chezmoi managed)
```
