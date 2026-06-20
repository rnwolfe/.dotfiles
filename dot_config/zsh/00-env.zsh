# Managed by chezmoi
HISTFILE="$HOME/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000
setopt HIST_IGNORE_ALL_DUPS
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY
bindkey -e
export EDITOR="${EDITOR:-nvim}"
export PAGER="${PAGER:-less}"
export PATH="$HOME/bin:$HOME/.local/bin:$HOME/.opencode/bin:$HOME/go/bin:$PATH"

# opencode
export OPENCODE_DISABLE_FILETIME_CHECK=true

# API keys loaded from ~/ key files
[[ -f "$HOME/.gemini_api_key" ]]     && export GEMINI_API_KEY="$(cat "$HOME/.gemini_api_key")"     GOOGLE_API_KEY="$GEMINI_API_KEY"
[[ -f "$HOME/.anthropic_api_key" ]]  && export ANTHROPIC_API_KEY="$(cat "$HOME/.anthropic_api_key")"
[[ -f "$HOME/.openai_api_key" ]]     && export OPENAI_API_KEY="$(cat "$HOME/.openai_api_key")"
[[ -f "$HOME/.openrouter_api_key" ]] && export OPENROUTER_API_KEY="$(cat "$HOME/.openrouter_api_key")"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
command -v pyenv >/dev/null && eval "$(pyenv init -)"

# zoxide (smart `z` command; `zi` interactive is shadowed by zinit's zi=zinit alias)
command -v zoxide >/dev/null && eval "$(zoxide init zsh)"

# Surface modern tools through infra you already use (no new muscle memory):
# fzf (incl. Ctrl-T) walks the tree with fd; man pages render through bat.
if command -v fd >/dev/null; then
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi
if command -v bat >/dev/null; then
  export MANPAGER="sh -c 'col -bx | bat --language man --plain'"
  export MANROFFOPT='-c'
fi

# iterm2
export ITERM_ENABLE_SHELL_INTEGRATION_WITH_TMUX=YES
## shell integration should come after any ITERM vars
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
