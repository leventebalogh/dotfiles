#!/usr/bin/env bash

# Install Command-line tools and useful Applications

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Install brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade --all

# Install GNU core utilities (those that come with OS X are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
sudo ln -s /usr/local/bin/gsha256sum /usr/local/bin/sha256sum

# Install some other useful utilities like `sponge`.
brew install moreutils
brew install findutils
brew install gnu-sed --with-default-names
brew install bash
brew tap homebrew/versions
brew install bash-completion2

# Install more recent versions of some OS X tools.
brew install vim --override-system-vi
brew install homebrew/dupes/grep
brew install homebrew/dupes/openssh
brew install homebrew/dupes/screen
brew install homebrew/php/php56 --with-gmp

# Install font tools.
brew tap bramstein/webfonttools
brew install sfnt2woff
brew install sfnt2woff-zopfli
brew install woff2

# Install some CTF tools; see https://github.com/ctfs/write-ups.
brew install aircrack-ng
brew install nmap
brew install pngcheck
brew install sqlmap
brew install tcpflow
brew install tcpreplay
brew install tcptrace

# Install other useful binaries.
brew install ack
brew install dark-mode
brew install git
brew install imagemagick --with-webp
brew install lua
brew install lynx
brew install p7zip
brew install pigz
brew install pv
brew install rename
brew install speedtest_cli
brew install ssh-copy-id
brew install testssl
brew install tree
brew install webkit2png
brew install wget
brew install htop
brew install tig
brew install tmux
brew install reattach-to-user-namespace
brew install python3

# Install useful Applications
brew cask install google-chrome
brew cask install sublime-text3
brew cask install dockertoolbox
brew cask install tunnelblick
brew cask install firefox
brew cask install android-file-transfer
brew cask install torbrowser
brew cask install vlc
brew cask install cheatsheet
brew cask install transmission
brew cask install skype
brew cask install steam
brew cask install spotify
brew cask install osxfuse
brew cask install encfs
brew cask install gitx

# Install Node JS
wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.25.4/install.sh | bash
nvm install stable
nvm use stable
nvm alias default stable

# Install NPM Packages
npm install -g eslint
npm install -g babel-eslint
npm install -g eslint-plugin-react
npm install -g gulp gulp-cli
npm install -g browserify
npm install -g typescript

# Setup Sublime Text
cp "~/sublime/Package Control.sublime-package" "~/Library/Application Support/Sublime Text 3/Installed Packages/"
cp "~/sublime/Package Control.sublime-settings" "~/Library/Application Support/Sublime Text 3/Packages/User/"
cp "~/sublime/Preferences.sublime-settings" "~/Library/Application Support/Sublime Text 3/Packages/User/"

# Remove outdated versions from the cellar.
brew cleanup
