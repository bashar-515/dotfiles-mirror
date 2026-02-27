BREW_BIN="/opt/homebrew/bin/brew"
if [ -x  "$BREW_BIN" ]; then
  eval "$("$BREW_BIN" shellenv)"
fi
