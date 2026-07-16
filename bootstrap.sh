#!/usr/bin/env bash
#
# bootstrap.sh — set up a fresh macOS machine.
#
# Usage:
#   ./bootstrap.sh                  # everything except macOS defaults
#   ./bootstrap.sh --with-osx       # also apply setup-osx.sh (System Settings)
#
# Idempotent: safe to re-run, every step checks before acting.
# See README.md for the full migration guide (incl. the manual steps).

set -uo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WITH_OSX=false
[ "${1:-}" = "--with-osx" ] && WITH_OSX=true

step() { printf "\n\033[1;34m==> %s\033[0m\n" "$1"; }
ok()   { printf "\033[0;32m✔ %s\033[0m\n" "$1"; }
warn() { printf "\033[0;33m⚠ %s\033[0m\n" "$1"; }

# 1. Xcode Command Line Tools (provides git, clang, etc.)
# -----------------------------------------------------------------
step "Xcode Command Line Tools"
if xcode-select -p > /dev/null 2>&1; then
    ok "already installed"
else
    xcode-select --install
    echo "Complete the Command Line Tools installer, then re-run this script."
    exit 1
fi

# 2. Homebrew
# -----------------------------------------------------------------
step "Homebrew"
if command -v brew > /dev/null 2>&1; then
    ok "already installed"
else
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
# Make brew available in THIS shell (fresh installs are not on PATH yet)
if [ -x /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# 3. Install formulae + casks + VS Code extensions
# -----------------------------------------------------------------
step "brew bundle (this takes a while on a fresh machine)"
brew bundle --file="$DOTFILES_DIR/Brewfile" || warn "some brew packages failed — re-run 'brew bundle' later"

# 4. Dotfiles
# -----------------------------------------------------------------
step "Dotfiles"
"$DOTFILES_DIR/dotfiles-install.sh"

# 5. Node via fnm + global npm packages
# -----------------------------------------------------------------
step "Node (fnm)"
if command -v fnm > /dev/null 2>&1; then
    eval "$(fnm env)"
    fnm install --lts
    fnm default lts-latest
    fnm use lts-latest
    step "Global npm packages"
    npm install -g @anthropic-ai/claude-code @playwright/cli @playwright/mcp concurrently corepack yarn typescript
else
    warn "fnm not found — did brew bundle succeed?"
fi

# 6. iTerm2 — load preferences from this repo
# -----------------------------------------------------------------
step "iTerm2 preferences"
defaults write com.googlecode.iterm2 PrefsCustomFolder -string "$DOTFILES_DIR/iterm"
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true
ok "iTerm2 will load prefs from $DOTFILES_DIR/iterm"

# 7. Zed — copy settings into ~/.config/zed
# -----------------------------------------------------------------
step "Zed settings"
if compgen -G "$DOTFILES_DIR/zed/*.json" > /dev/null; then
    mkdir -p "$HOME/.config/zed"
    cp -v "$DOTFILES_DIR/zed/"*.json "$HOME/.config/zed/"
else
    warn "no Zed settings in $DOTFILES_DIR/zed — skipping"
fi

# 8. z (directory jumper) — sourced by .bash_profile from ~/projects/z
# -----------------------------------------------------------------
step "z (rupa/z)"
if [ -f "$HOME/projects/z/z.sh" ]; then
    ok "already present"
else
    git clone https://github.com/rupa/z.git "$HOME/projects/z"
fi

# 9. ai-config — agent configs, ~/.local/bin commands
# -----------------------------------------------------------------
step "ai-config"
if [ -d "$HOME/projects/ai-config" ]; then
    ok "already cloned"
else
    git clone git@github.com:leventebalogh/ai-config.git "$HOME/projects/ai-config" \
        || warn "could not clone ai-config (SSH key set up yet?) — clone it manually later"
fi
if [ -f "$HOME/projects/ai-config/tooling/build/setup.sh" ]; then
    "$HOME/projects/ai-config/tooling/build/setup.sh"
fi

# 10. Login shell → bash
# -----------------------------------------------------------------
step "Login shell"
if [ "$(dscl . -read "/Users/$USER" UserShell | awk '{print $2}')" = "/bin/bash" ]; then
    ok "already /bin/bash"
else
    chsh -s /bin/bash
fi

# 11. Clone project repos (list produced by scripts/dump-repos.sh)
# -----------------------------------------------------------------
step "Project repos"
if [ -f "$DOTFILES_DIR/repos.txt" ]; then
    "$DOTFILES_DIR/scripts/clone-repos.sh" "$DOTFILES_DIR/repos.txt"
else
    warn "no repos.txt found — AirDrop it from the old machine and run scripts/clone-repos.sh"
fi

# 12. macOS defaults (optional)
# -----------------------------------------------------------------
if $WITH_OSX; then
    step "macOS defaults (setup-osx.sh)"
    bash "$DOTFILES_DIR/setup-osx.sh"
    ok "some settings need a logout/restart to apply"
fi

printf "\n\033[1;32mDone.\033[0m Now work through the manual checklist in README.md\n"
printf "(logins, SSH keys, Keychain tokens, Jamf, Chrome sync, …)\n"
