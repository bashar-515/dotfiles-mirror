maybe_eval() {
  local bin
  bin="$(command -v "$1")" || return 0
  shift
  eval "$("$bin" "$@")"
}

maybe_source() {
  [ -f "$1" ] && source "$1"
}

fpath=(/Users/beesho/.docker/completions $fpath)

autoload -Uz compinit && compinit

maybe_eval starship init zsh
maybe_eval direnv hook zsh
maybe_eval fnm env --use-on-cd --shell zsh

maybe_source "$HOME/.aliases"
maybe_source "$HOME/.aliases.local"
maybe_source "/opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
maybe_source "/opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

if command -v go >/dev/null 2>&1; then
  export PATH="$(go env GOPATH)/bin:$PATH"
fi

export EDITOR="hx"

export PATH="/opt/homebrew/opt/jpeg/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/jpeg/lib"
export CPPFLAGS="-I/opt/homebrew/opt/jpeg/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/jpeg/lib/pkgconfig"

# pnpm
export PNPM_HOME="/Users/bashareid/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
