#!/usr/bin/env bash

# Install Homebrew (if not installed)
if test ! $(which brew)
then
  echo "Installing Homebrew for you."

  # Install the correct homebrew for each OS type
  if test "$(uname)" = "Darwin"
  then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  elif test "$(expr substr $(uname -s) 1 5)" = "Linux"
  then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install)"
  fi
fi

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Save Homebrew’s installed location.
BREW_PREFIX=$(brew --prefix)

# Install GNU core utilities (those that come with macOS are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
ln -s "${BREW_PREFIX}/bin/gsha256sum" "${BREW_PREFIX}/bin/sha256sum"

# Install some other useful utilities like `sponge`.
brew install moreutils

# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install findutils
brew install gmp
brew install grep

# Install useful binaries.
brew install ack
brew install autojump
brew install ffmpeg
brew install git
brew install git-lfs
brew install hub
brew install imagemagick --with-webp
brew install p7zip
brew install pigz
brew install pv
brew install rclone
brew install rsync
brew install rename
brew install ssh-copy-id
brew install tree
brew install vbindiff
brew install nvm
brew install tig
brew install yarn
brew install ansible

# Installs Casks
# brew tap caskroom/cask
# brew tap homebrew/cask-fonts

## Apps I use
brew cask install vlc
brew cask install tresorit
brew cask install transmission
brew cask install teamspeak-client
brew cask install calibre
brew cask install numi
brew cask install plex
brew cask install brave-browser
brew cask install docker
brew cask install expressvpn
brew cask install figma
brew cask install firefox
brew cask install google-chrome
brew cask install homebrew/cask-versions/firefox-nightly
brew cask install homebrew/cask-versions/google-chrome-canary
brew cask install insomnia
brew cask install iterm2
brew cask install kap
brew cask install messenger
brew cask install mongodb-compass
brew cask install rectangle
brew cask install skype
brew cask install slack
brew cask install telegram
brew cask install textexpander
brew cask install visual-studio-code

# Remove outdated versions from the cellar.
brew cleanup