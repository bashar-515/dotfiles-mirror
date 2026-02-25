maybe_eval() {
  local bin
  bin="$(command -v "$1")" || return 0
  shift
  eval "$("$bin" "$@")"
}

maybe_source() {
  [ -f "$1" ] && source "$1"
}

autoload -Uz compinit && compinit

maybe_eval starship init zsh
maybe_eval direnv hook zsh
maybe_eval fnm env --use-on-cd --shell zsh

maybe_source "$HOME/.aliases"
maybe_source "/opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
maybe_source "/opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
maybe_source "$HOME/.config/anthropic/env"

if command -v go >/dev/null 2>&1; then
  export PATH="$(go env GOPATH)/bin:$PATH"
fi

export PATH="$HOME/.local/bin:$PATH" # Claude Code
