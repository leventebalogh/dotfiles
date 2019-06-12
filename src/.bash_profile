# ~/bin
if [ ! -d ~/bin ]; then
	mkdir ~/bin
fi
export PATH="$HOME/bin:$HOME/scripts/bin:$HOME/dev/flutter/bin:$PATH";

# Init Homebrew
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# Init NVM
export NVM_DIR="$HOME/.nvm"
[ -s $(brew --prefix nvm)/nvm.sh ] && source $(brew --prefix nvm)/nvm.sh

# Load the shell dotfiles, and then some:
for file in ~/.bash_{path,prompt,exports,aliases,functions,extra}.sh; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Git Completion
source ~/.git-completion.sh

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
	shopt -s "$option" 2> /dev/null;
done;

# SSH
# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

# Z
# Init Z. (https://github.com/rupa/z)
. ~/projects/z/z.sh
