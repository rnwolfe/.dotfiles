# Managed by chezmoi
# Modern tool replacements — guarded so a fresh machine (tools not yet
# installed by mise) still has working ls/cat.
if command -v eza >/dev/null; then
  alias ls='eza --group-directories-first'
  alias ll='eza -lah --git --group-directories-first'
  alias la='eza -a --group-directories-first'
  alias lt='eza --tree --level=2'
  alias tree='eza --tree'
else
  alias ll='ls -lah'
fi
command -v bat >/dev/null && alias cat='bat --paging=never'

# mytools — remind me which power tools are installed and what they replace.
mytools() {
  command cat <<'EOF'
power tools (→ what they replace):
  eza    → ls       aliased: ls, ll, la, lt, tree
  bat    → cat       aliased: cat (syntax highlight, no paging)
  fd     → find      use `fd PATTERN`; also powers fzf Ctrl-T
  rg     → grep      ripgrep
  fzf    →           Ctrl-T files · Ctrl-R history · <Tab> completion
  zoxide → cd        use `z DIR` to jump
  glow   →           render markdown in the terminal
  lazygit→           git TUI (`lazygit`)
EOF
}

alias gs='git status'
alias gd='git diff'
alias gl='git log --oneline --graph --decorate --all'
alias ga='git add'
alias gc='git commit'
alias gco='git checkout'
alias gp='git push'
alias tls='tmux ls'
alias ta='tmux attach -t'
alias tn='tmux new-session -s'
alias v='nvim'
alias vi='nvim'
alias oc="opencode"
alias occ="opencode -c"
alias ccskip="claude --dangerously-skip-permissions"
alias cccont="claude --dangerously-skip-permissions --continue"

_persist__commit_and_push() {
  local repo_dir="$1"
  local message="$2"

  git -C "$repo_dir" add -A
  if ! git -C "$repo_dir" diff --cached --quiet; then
    git -C "$repo_dir" commit -m "$message"
    read -r "reply?Push to origin/main? [y/N] "
    if [[ "$reply" == "y" || "$reply" == "Y" ]]; then
      git -C "$repo_dir" push origin main
    fi
  fi
}

persist-alias() {
  if [[ "$#" -lt 2 ]]; then
    echo "usage: persist-alias name value..."
    return 1
  fi

  local name="$1"
  shift
  local value="$*"
  local repo_dir="$HOME/.local/share/chezmoi"
  local aliases_file="$repo_dir/dot_config/zsh/20-aliases.zsh"

  printf "alias %s='%s'\n" "$name" "$value" >> "$aliases_file"
  chezmoi apply
  _persist__commit_and_push "$repo_dir" "chore: add alias $name"
}

persist-env() {
  if [[ "$#" -lt 1 ]]; then
    echo "usage: persist-env KEY=value..."
    return 1
  fi

  local kv="$*"
  local repo_dir="$HOME/.local/share/chezmoi"
  local env_file="$repo_dir/dot_config/zsh/00-env.zsh"

  printf "export %s\n" "$kv" >> "$env_file"
  chezmoi apply
  _persist__commit_and_push "$repo_dir" "chore: add env ${kv%%=*}"
}

persist-path() {
  if [[ "$#" -lt 1 ]]; then
    echo "usage: persist-path /path/to/bin"
    return 1
  fi

  local path_entry="$1"
  local repo_dir="$HOME/.local/share/chezmoi"
  local env_file="$repo_dir/dot_config/zsh/00-env.zsh"

  printf 'export PATH="%s:$PATH"\n' "$path_entry" >> "$env_file"
  chezmoi apply
  _persist__commit_and_push "$repo_dir" "chore: add path $path_entry"
}
alias cb='clawdbot'
alias s='source ~/.zshrc'
