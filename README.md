# Dotfiles

## Installing dotfiles
To copy all the available dotfiles from under `./src` to your home directory just run the following commands:
```
$ git clone git@github.com:leventebalogh/.dotfiles.git && cd dotfiles
$ ./dotfiles-install.sh
```

## Installing binaries and applications
The following is installing the necessary binaries and applications I am using most frequently.
It is using Brew under the hood.
```
$ ./brew.sh
```

## Uninstall dotfiles
If you would like to remove the installed dotfiles run the following.
```
$ ./dotfiles-uninstall.sh
```

## Commandline Help
In order to print out a command-line help just use the following command:
```
$ docs
```
