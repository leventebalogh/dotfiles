# NVM
    if [ -d ~/.nvm ]; then
        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
    fi

# External files:
    # * ~/.path can be used to extend `$PATH`.
    # * ~/.extra can be used for other settings you don’t want to commit.
    for file in ~/.{path,bash_prompt,exports,aliases,functions,extra,git-completion,gulp-completion}.sh; do
        [ -r "$file" ] && [ -f "$file" ] && source "$file";
    done;
    unset file;