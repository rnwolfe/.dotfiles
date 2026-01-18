# Managed by chezmoi
setopt HIST_IGNORE_ALL_DUPS
setopt SHARE_HISTORY
export EDITOR="${EDITOR:-nvim}"
export PAGER="${PAGER:-less}"
export PATH="$HOME/bin:$HOME/.local/bin:$HOME/go/bin:$PATH"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
command -v pyenv >/dev/null && eval "$(pyenv init -)"
