#!/usr/bin/env bash
#
# Run on the NEW machine: clones every repo listed in repos.txt into
# ~/projects. Skips repos whose target directory already exists.
#
# Usage: scripts/clone-repos.sh [path/to/repos.txt] [target-dir]

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
LIST="${1:-$DOTFILES_DIR/repos.txt}"
PROJECTS_DIR="${2:-$HOME/projects}"

[ -f "$LIST" ] || { echo "No repo list found at $LIST" >&2; exit 1; }
mkdir -p "$PROJECTS_DIR"

failed=()
while IFS= read -r url; do
    [ -n "$url" ] || continue
    name="$(basename "$url" .git)"
    if [ -d "$PROJECTS_DIR/$name" ]; then
        echo "✔ $name already exists — skipping"
        continue
    fi
    echo "==> Cloning $url"
    git clone "$url" "$PROJECTS_DIR/$name" || failed+=("$url")
done < "$LIST"

if [ "${#failed[@]}" -gt 0 ]; then
    echo ""
    echo "⚠ Failed to clone:" >&2
    printf '  %s\n' "${failed[@]}" >&2
    exit 1
fi
echo ""
echo "✔ All repos cloned into $PROJECTS_DIR"
