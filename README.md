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

## Functions

- `calc 1+3 # => 4` **-** A simple calculator command
- `mkd foobar` **-** Creates and enters foobar directory
- `targz ./foobar` **-** Creates foobar.tar.gz
- `fs ~/Desktop` **-** Calculates the size of a directory or a folder
- `dataurl ./foobar.jpg` **-** Creates a dataurl from a file
- `tre` **-** Shorthand for tree with colors enabled, listing directories first
- `o ./foobar` **-** Opens a directory or the current location

**Docker**
- `drm foobar` **-** Stops and removes the *foobar* container
- `da foobar` **-** Starts bash in the *foobar* container
- `dip foobar` **-** Gets the IP address of the *foobar* container
- `drmc` **-** Removes all stopped containers
- `drmi` **-** Removes all stopped images

## Aliases

- `.. # => cd ..`
- `... # => cd ../../`
- `.... # => cd ../../../`
- `~ # => cd ~`
- `- # => cd -`
- `timer` **-** Starts a timer
- `ip` **-** Shows your IP visible from outside
- `localip` **-** Shows your local IP address
- `cleanup` **-** Recursively delete `.DS_Store` **-** files
- `emptytrash` **-** Empties the trash
- `urlencode "a=2&b=3"` **-** URL-encodes a string
- `chromekill` **-** Kills all tabs in Chrome
- `reload` **-** Reloads the shell

**OSX Specific**
- `lock` **-** Locks the screen
- `mute` **-** Mutes the speakers
- `unmute` **-** Unmutes the speakers
- `show` **-** Shows hidden files in Finder
- `hide` **-** Hides hidden files in Finder
- `show-desktop` **-** Shows all files on Desktop
- `hide-desktop` **-** Hides all files on Desktop
