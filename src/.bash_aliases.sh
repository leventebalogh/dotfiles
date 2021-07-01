# Detect which `ls` flavor is in use
if ls --color > /dev/null 2>&1; then # GNU `ls`
    colorflag="--color"
else # OS X `ls`
    colorflag="-G"
fi

# List all files colorized in long format
alias l="ls -lhaF ${colorflag}"

# List only directories
alias ld="ls -lhF ${colorflag} | grep --color=never '^d'"

# Always use color output for `ls`
alias ls="command ls ${colorflag}"
export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'

# Always enable colored `grep` output
# Note: `GREP_OPTIONS="--color=auto"` is deprecated, hence the alias usage.
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Enable aliases to be sudo’ed
alias sudo='sudo '

# Reload the shell (i.e. invoke as a login shell)
alias reload="exec $SHELL -l"


# --- MAC ----------------------------------
if [[ "$OSTYPE" == "darwin"* ]]; then
    alias simulator="open -a Simulator"

    # Lock the screen (when going AFK)
    alias lock="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"

    # Unmount drives
    alias unmount-all="find /dev -name \"disk[1-9]\" -exec diskutil eject {} \;"

    # Volume
    alias mute="osascript -e 'set volume output muted true'"
    alias volume-up="osascript -e 'set volume 7'"

    # Merge PDF files
    # Usage: `mergepdf -o output.pdf input{1,2,3}.pdf`
    alias mergepdf='/System/Library/Automator/Combine\ PDF\ Pages.action/Contents/Resources/join.py'

    # Trim new lines and copy to clipboard
    alias c="tr -d '\n' | pbcopy"

    # Get OS X Software Updates, and update installed Ruby gems, Homebrew, npm, and their installed packages
    alias update='sudo softwareupdate -i -a; brew update; brew upgrade --all; brew cleanup; npm install npm -g; npm update -g; sudo gem update --system; sudo gem update'

    # Flush Directory Service cache
    alias flush="dscacheutil -flushcache && killall -HUP mDNSResponder"

    # Empty the Trash on all mounted volumes and the main HDD.
    # Also, clear Apple’s System Logs to improve shell startup speed.
    # Finally, clear download history from quarantine. https://mths.be/bum
    alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl; sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'"

    # Start new Chrome sessions
    alias new-chrome="rm -rf $HOME/tmp/chrome && mkdir -p $HOME/tmp/chrome && /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --incognito --start-maximized --user-data-dir=$HOME/tmp/chrome > /dev/null 2>&1 &"
    alias work-chrome="mkdir -p $HOME/tmp/chrome-work && /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --start-maximized --user-data-dir=$HOME/tmp/chrome-work > /dev/null 2>&1 &"
fi
