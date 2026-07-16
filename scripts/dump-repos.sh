#!/usr/bin/env bash
#
# Run on the OLD machine: writes the origin URL of every git repo under
# ~/projects to repos.txt (next to this repo's root).
#
# repos.txt is gitignored — transfer it via AirDrop, then run
# scripts/clone-repos.sh on the new machine.

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OUT="$DOTFILES_DIR/repos.txt"
PROJECTS_DIR="${1:-$HOME/projects}"

: > "$OUT"

for gitdir in "$PROJECTS_DIR"/*/.git; do
    [ -e "$gitdir" ] || continue
    repo_dir="$(dirname "$gitdir")"
    url="$(git -C "$repo_dir" remote get-url origin 2>/dev/null)" || {
        echo "skipping $(basename "$repo_dir") — no 'origin' remote" >&2
        continue
    }
    echo "$url" >> "$OUT"
done

sort -u -o "$OUT" "$OUT"
echo "✔ Wrote $(wc -l < "$OUT" | tr -d ' ') repo URLs to $OUT"
