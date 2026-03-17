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

export NVM_DIR="$HOME/.nvm"
maybe_source "/opt/homebrew/opt/nvm/nvm.sh" #This loads nvm
maybe_source "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion

maybe_source "$HOME/.aliases"
maybe_source "$HOME/.aliases.local"
maybe_source "/opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
maybe_source "/opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

export PATH="/opt/homebrew/opt/jpeg/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/jpeg/lib"
export CPPFLAGS="-I/opt/homebrew/opt/jpeg/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/jpeg/lib/pkgconfig"
