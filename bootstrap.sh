#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

git pull origin master;

function overwrite() {
	rsync --exclude ".git/" \
        --exclude "vscode/" \
        --exclude "scripts/" \
        --exclude "osx/" \
        --exclude "bootstrap.sh" \
        --exclude ".DS_Store" \
        --exclude ".gitignore" \
        --exclude "README.md" \
        -avh \
        --no-perms \
        . \
        ~;

	source ~/.bash_profile;
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	overwrite;
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		overwrite;
	fi;
fi;
unset overwrite;
