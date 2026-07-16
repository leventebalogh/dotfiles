# Brewfile — install everything with: brew bundle --file=Brewfile
#
# Regenerate from the current machine with:
#   brew bundle dump --force --file=Brewfile
# (then re-apply the curation below — the dump includes transitive deps.)

# ---- Taps -------------------------------------------------------------
tap "derailed/k9s"
tap "eugene1g/safehouse"
tap "grafana/grafana"
tap "k1low/tap", "https://github.com/k1LoW/homebrew-tap"
tap "simion/termic"

# ---- Shell & core utilities -------------------------------------------
brew "bash"          # newer bash than the macOS built-in
brew "coreutils"
brew "wget"
brew "jq"
brew "htop"
brew "pv"
brew "fswatch"
brew "md5sha1sum", link: true
brew "shellcheck"
brew "starship"

# ---- Git & GitHub -----------------------------------------------------
brew "gh"
brew "git-lfs"
brew "github-mcp-server"
brew "tig"

# ---- Languages & version managers -------------------------------------
brew "fnm"           # node versions (see .bash_profile for init)
brew "go"
brew "rust"
brew "mise"
brew "pygments"

# ---- Go tooling --------------------------------------------------------
brew "golang-migrate"
brew "golangci-lint"
brew "mage"

# ---- Databases & infra -------------------------------------------------
brew "mysql"
brew "mosquitto"
brew "ansible"
brew "sshpass"
brew "jsonnet"
brew "unbound"

# ---- AI / sandboxing ---------------------------------------------------
brew "nono"          # nono.sh — sandbox shell for AI agents

# ---- Media & misc -------------------------------------------------------
brew "ffmpeg"
brew "exiftool"
brew "graphviz"
brew "libass"
brew "libmicrohttpd"
brew "tesseract"

# ---- Apps (casks) -------------------------------------------------------
cask "1password"
cask "1password-cli"
cask "claude-code"
cask "codex"
cask "cryptomator"
cask "gcloud-cli"    # Google Cloud SDK (gcloud) — see `brew info gcloud-cli` caveats
cask "google-chrome"
cask "iterm2"
cask "rectangle"
cask "slack"
cask "telegram"
cask "termic"
cask "transmission"
cask "visual-studio-code"
cask "vlc"
cask "zed"

# NOTE: Jamf / Jamf Protect are NOT installed via brew — they are deployed
# by Grafana IT when the machine enrolls during Setup Assistant.

# ---- VS Code extensions --------------------------------------------------
vscode "alexcvzz.vscode-sqlite"
vscode "andys8.jest-snippets"
vscode "anthropic.claude-code"
vscode "arcanis.vscode-zipfs"
vscode "bradlc.vscode-tailwindcss"
vscode "christian-kohler.path-intellisense"
vscode "dbaeumer.vscode-eslint"
vscode "dracula-theme.theme-dracula"
vscode "eamodio.gitlens"
vscode "esbenp.prettier-vscode"
vscode "fabianlauer.vs-code-xml-format"
vscode "genieai.chatgpt-vscode"
vscode "golang.go"
vscode "l13rary.l13-diff"
vscode "mechatroner.rainbow-csv"
vscode "mirone.milkdown"
vscode "mitchdenny.ecdc"
vscode "ms-playwright.playwright"
vscode "ms-python.debugpy"
vscode "ms-python.python"
vscode "ms-python.vscode-pylance"
vscode "ms-vscode-remote.remote-ssh"
vscode "ms-vscode-remote.remote-ssh-edit"
vscode "ms-vscode.remote-explorer"
vscode "ms-vsliveshare.vsliveshare"
vscode "pflannery.vscode-versionlens"
vscode "prisma.prisma"
vscode "robinbentley.sass-indented"
vscode "streetsidesoftware.code-spell-checker"
vscode "tamasfe.even-better-toml"
vscode "unifiedjs.vscode-mdx"
vscode "vscode-icons-team.vscode-icons"

# npm globals are installed by bootstrap.sh AFTER nvm has installed node
# (they can't go here — brew bundle would run npm before node exists).
