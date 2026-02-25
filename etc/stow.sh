#!/bin/bash

set -euxo pipefail

command -v stow >/dev/null || { echo "stow is not installed" >&2; exit 1; }

DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"

for dir in "$DIR/common" "$DIR/Darwin"; do
    [ -d "$dir" ] || { echo "$dir does not exist" >&2; exit 1; }

    for pkg in "$dir"/*/; do
        # e.g., stow -d ~/.files/common -t ~/. nvim
        [ -d "$pkg" ] && stow -d "$dir" -t "$HOME" "$(basename "$pkg")"
    done
done
