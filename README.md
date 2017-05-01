# Levente Balogh's dotfiles

These dotfiles are forked from the dotfiles of Mathias Bynens and are extended to my own flavour.

## Install locally
```
$ git clone git@github.com:leventebalogh/.dotfiles.git
$ cd dotfiles
$ ./bootstrap.sh
```

## Copy to server
This assumes that you already have the `dotfiles` repo cloned.

```
$ cd dotfiles
$ rsync --exclude ".git/" \
        --exclude "scripts/" \
        --exclude "osx/" \
        --exclude "bootstrap.sh" \
        --exclude ".DS_Store" \
        --exclude ".gitignore" \
        --exclude "README.md" \
        -avh \
        --no-perms \
        . \
        foo@bar:~;
```