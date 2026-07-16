# PATH
# -------------------------
export PATH="$HOME/bin:$HOME/.gobrew/current/bin:$HOME/.gobrew/bin:$HOME/scripts/bin:/opt/homebrew/bin:/opt/homebrew/sbin:$HOME/go/bin:/usr/local/go/bin:$HOME/google-cloud-sdk/bin:/Library/Frameworks/Python.framework/Versions/3.11/bin:$PATH";


# Create a ~/bin folder if it doesn't exist yet
# -------------------------
if [ ! -d ~/bin ]; then
    mkdir ~/bin
fi


# Init Brew
# -------------------------
export HOMEBREW_CASK_OPTS="--appdir=/Applications"


# Load the shell dotfiles, and then some:
# -------------------------
for file in ~/.bash_{prompt,path,exports,aliases,functions,extra,docs}.sh; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;


# Case-insensitive globbing (used in pathname expansion)
# -------------------------
shopt -s nocaseglob;


# Append to the Bash history file, rather than overwriting it
# -------------------------
shopt -s histappend;


# Autocorrect typos in path names when using `cd`
# -------------------------
shopt -s cdspell;


# Enable some Bash 4 features when possible:
# -------------------------
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
    shopt -s "$option" 2> /dev/null;
done;


# SSH
# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
# -------------------------
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep '^Host' ~/.ssh/config | grep -v '[?*]' | cut -d ' ' -f2-)" scp sftp ssh 2>/dev/null;

# Z
# Init Z. (https://github.com/rupa/z)
# -------------------------
[ -f ~/projects/z/z.sh ] && . ~/projects/z/z.sh


# Add tab-completion for hostnames
# -------------------------
compgen -A hostname;
complete -A hostname ping;
complete -A hostname ssh;


# File opening limit
# -------------------------
ulimit -S -n 4096


# Google Cloud SDK
# ------------------------
# Manual install (~/google-cloud-sdk):
if [ -f "$HOME/google-cloud-sdk/path.bash.inc" ]; then . "$HOME/google-cloud-sdk/path.bash.inc"; fi
if [ -f "$HOME/google-cloud-sdk/completion.bash.inc" ]; then . "$HOME/google-cloud-sdk/completion.bash.inc"; fi
# Brew install (cask "gcloud-cli"):
if [ -f "/opt/homebrew/share/google-cloud-sdk/path.bash.inc" ]; then . "/opt/homebrew/share/google-cloud-sdk/path.bash.inc"; fi
if [ -f "/opt/homebrew/share/google-cloud-sdk/completion.bash.inc" ]; then . "/opt/homebrew/share/google-cloud-sdk/completion.bash.inc"; fi

# ABEVJAVA
# ------------------------
[ -f "$HOME/.profabevjava" ] && . "$HOME/.profabevjava"

# FNM (node version manager — guarded so a fresh machine doesn't error)
# -------------------------
command -v fnm > /dev/null 2>&1 && eval "$(fnm env --use-on-cd)"

# TOKENS, CREDENTIALS
# -------------------------------------
if val="$(security find-internet-password -w -s "github.com" -a "GITHUB_PERSONAL_ACCESS_TOKEN" 2>/dev/null)"; then
  export GITHUB_PERSONAL_ACCESS_TOKEN="$val"
fi
if val="$(security find-internet-password -w -s "context7.com" -a "API_KEY" 2>/dev/null)"; then
  export CONTEXT7_API_KEY="$val"
fi
if val="$(security find-internet-password -w -s "grafana.com" -a "GRAFANA_METRICS_API_KEY" 2>/dev/null)"; then
  export GRAFANA_METRICS_API_KEY="$val"
fi
if val="$(security find-internet-password -w -s "brave.com" -a "BRAVE_SEARCH_MCP_CLAUDE" 2>/dev/null)"; then
  export BRAVE_SEARCH_MCP_CLAUDE="$val"
fi
# if val="$(security find-internet-password -w -s "grafana.1password.com" -a "PLUGIN_UPLOADER_WEBHOOK_URL" 2>/dev/null)"; then
#   export PLUGIN_UPLOADER_WEBHOOK_URL="$val"
# fi

# pnpm
# -------------------------
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# ai-agents sync
# -------------------------
if [ -n "$PS1" ]; then
   sync >/dev/null 2>&1
fi

# Making sure that `.local/bin` is at the beginning of the path.
export PATH="$HOME/.local/bin:$PATH";
