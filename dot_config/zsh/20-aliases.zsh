# Managed by chezmoi
alias ll='ls -lah'
alias gs='git status'
alias gd='git diff'
alias v='nvim'
alias vi='nvim'
alias oc="opencode"
alias occ="opencode -c"

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

_persist__repo_dir() {
  if [[ "${1:-}" == "--work" ]]; then
    echo "$HOME/.local/share/chezmoi-work"
  else
    echo "$HOME/.local/share/chezmoi"
  fi
}

_persist__apply() {
  if [[ "${1:-}" == "--work" ]]; then
    chezmoi -S "$HOME/.local/share/chezmoi-work" apply
  else
    chezmoi apply
  fi
}

persist-alias() {
  local target="personal"
  if [[ "${1:-}" == "--work" ]]; then
    target="work"
    shift
  fi
  if [[ "$#" -lt 2 ]]; then
    echo "usage: persist-alias [--work] name value..."
    return 1
  fi

  local name="$1"
  shift
  local value="$*"
  local repo_dir="$(_persist__repo_dir "$([[ "$target" == "work" ]] && echo --work)")"
  local aliases_file="$repo_dir/dot_config/zsh/20-aliases.zsh"

  printf "alias %s='%s'\n" "$name" "$value" >> "$aliases_file"
  _persist__apply "$([[ "$target" == "work" ]] && echo --work)"
  _persist__commit_and_push "$repo_dir" "chore: add alias $name"
}

persist-env() {
  local target="personal"
  if [[ "${1:-}" == "--work" ]]; then
    target="work"
    shift
  fi
  if [[ "$#" -lt 1 ]]; then
    echo "usage: persist-env [--work] KEY=value..."
    return 1
  fi

  local kv="$*"
  local repo_dir="$(_persist__repo_dir "$([[ "$target" == "work" ]] && echo --work)")"
  local env_file="$repo_dir/dot_config/zsh/00-env.zsh"

  printf "export %s\n" "$kv" >> "$env_file"
  _persist__apply "$([[ "$target" == "work" ]] && echo --work)"
  _persist__commit_and_push "$repo_dir" "chore: add env ${kv%%=*}"
}

persist-path() {
  local target="personal"
  if [[ "${1:-}" == "--work" ]]; then
    target="work"
    shift
  fi
  if [[ "$#" -lt 1 ]]; then
    echo "usage: persist-path [--work] /path/to/bin"
    return 1
  fi

  local path_entry="$1"
  local repo_dir="$(_persist__repo_dir "$([[ "$target" == "work" ]] && echo --work)")"
  local env_file="$repo_dir/dot_config/zsh/00-env.zsh"

  printf 'export PATH="%s:$PATH"\n' "$path_entry" >> "$env_file"
  _persist__apply "$([[ "$target" == "work" ]] && echo --work)"
  _persist__commit_and_push "$repo_dir" "chore: add path $path_entry"
}
alias cb='clawdbot'
