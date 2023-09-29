# Create a ~/bin folder if it doesn't exist yet
# -------------------------
if [ ! -d ~/bin ]; then
	mkdir ~/bin
fi


# GIT qTOKEN(S)
# Manage: https://github.com/settings/tokens
# -------------------------
if [ -f '/Users/leventebalogh/.github_token' ]; then . '/Users/leventebalogh/.github_token'; fi


# PATH
# -------------------------
export PATH="$HOME/bin:$HOME/scripts/bin:$HOME/dev/flutter/bin:/opt/homebrew/bin:/opt/homebrew/sbin:$HOME/go/bin:$PATH";


# Init Homebrew
# -------------------------
export HOMEBREW_CASK_OPTS="--appdir=/Applications"


# Init NVM
# -------------------------
export NVM_DIR="$HOME/.nvm"
[ -s $(brew --prefix nvm)/nvm.sh ] && source $(brew --prefix nvm)/nvm.sh


# Load the shell dotfiles, and then some:
# -------------------------
for file in ~/.bash_{path,prompt,exports,aliases,functions,extra,docs}.sh; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;


# Git Completion
# -------------------------
source ~/.git-completion.sh


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
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr 
' ' '\n')" scp sftp ssh;


# Z
# Init Z. (https://github.com/rupa/z)
# -------------------------
. ~/projects/z/z.sh


# FLUTTER
# Initialise Flutter
# -------------------------
[ -s "$HOME/development/flutter/bin" ] && export PATH="$PATH:$HOME/development/flutter/bin"


# Add tab-completion for hostnames
# -------------------------
compgen -A hostname;
complete -A hostname ping;
complete -A hostname ssh;


# File opening limit
# -------------------------
ulimit -S -n 4096


# Google Cloud SDK
# -------------------------
# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/leventebalogh/google-cloud-sdk/path.bash.inc' ]; then . '/Users/leventebalogh/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/leventebalogh/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/leventebalogh/google-cloud-sdk/completion.bash.inc'; fi

