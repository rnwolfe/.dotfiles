# Managed by chezmoi
setopt HIST_IGNORE_ALL_DUPS
setopt SHARE_HISTORY
export EDITOR="${EDITOR:-nvim}"
export PAGER="${PAGER:-less}"
export PATH="$HOME/bin:$HOME/.local/bin:$HOME/.opencode/bin:$HOME/go/bin:$PATH"

# opencode
export OPENCODE_DISABLE_FILETIME_CHECK=true

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
command -v pyenv >/dev/null && eval "$(pyenv init -)"

# iterm2
export ITERM_ENABLE_SHELL_INTEGRATION_WITH_TMUX=YES
## shell integration should come after any ITERM vars
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
