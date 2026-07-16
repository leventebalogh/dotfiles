#!/usr/bin/env bash
#
# Copies every dotfile from ./src into $HOME (overwrites existing files).

set -euo pipefail

SRC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/src" && pwd)"

echo "* Copying dotfiles from $SRC_DIR to $HOME"
echo ""

for f in "$SRC_DIR"/.*; do
    name="$(basename "$f")"
    { [ "$name" = "." ] || [ "$name" = ".." ]; } && continue
    [ -f "$f" ] || continue
    cp -v "$f" "$HOME/$name"
done

echo ""
echo "✔ Dotfiles installed. Open a new shell (or 'source ~/.bash_profile') to apply."
