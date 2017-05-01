# ~/bin
    if [ ! -d ~/bin ]; then
        mkdir ~/bin
    fi
    export PATH="$HOME/bin:$PATH";

# ~/scripts/bin
    if [ ! -d ~/scripts/bin ]; then
        mkdir -p ~/scripts/bin
    fi
    export PATH="$HOME/scripts/bin:$PATH";