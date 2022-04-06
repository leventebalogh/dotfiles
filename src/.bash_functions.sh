function edit () {
	code ~/projects/dotfiles
}


# Use Git’s colored diff when available
hash git &>/dev/null;
if [ $? -eq 0 ]; then
	function diff() {
		git diff --no-index --color-words "$@";
	}
fi;



# --- STRINGS --------------------------

	# Syntax-highlight JSON strings or files
	# Usage: `json '{"foo":42}'` or `echo '{"foo":42}' | json`
	function json() {
		if [ -t 0 ]; then # argument
			python -mjson.tool <<< "$*" | pygmentize -l javascript;
		else # pipe
			python -mjson.tool | pygmentize -l javascript;
		fi;
	}

	# UTF-8-encode a string of Unicode symbols
	function escape() {
		printf "\\\x%s" $(printf "$@" | xxd -p -c1 -u);
		# print a newline unless we’re piping the output to another program
		if [ -t 1 ]; then
			echo ""; # newline
		fi;
	}

	# Decode \x{ABCD}-style Unicode escape sequences
	function unidecode() {
		perl -e "binmode(STDOUT, ':utf8'); print \"$@\"";
		# print a newline unless we’re piping the output to another program
		if [ -t 1 ]; then
			echo ""; # newline
		fi;
	}

	# Get a character’s Unicode code point
	function codepoint() {
		perl -e "use utf8; print sprintf('U+%04X', ord(\"$@\"))";
		# print a newline unless we’re piping the output to another program
		if [ -t 1 ]; then
			echo ""; # newline
		fi;
	}



# --- NETWORK ----------------------------

	alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
	alias localip="ipconfig getifaddr en0"
	alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"
	alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"'
	alias netusage="nettop -d -J "bytes_in,bytes_out""
	alias location-by-ip="curl -s https://ipvigilante.com/$(curl -s https://ipinfo.io/ip) | jq '.data.latitude, .data.longitude, .data.city_name, .data.country_name'"

	function get-ssl-cert () {
		echo | openssl s_client -showcerts -servername "$1" -connect "$1:443" 2>/dev/null | openssl x509 -inform pem -noout -text
	}

	# Run `dig` and display the most useful info
	function digga() {
		dig +nocmd "$1" any +multiline +noall +answer;
	}

	# Start an HTTP server from a directory, optionally specifying the port
	function server() {
		local port="${1:-8000}";
		sleep 1 && open "http://localhost:${port}/" &
		# Set the default Content-Type to `text/plain` instead of `application/octet-stream`
		# And serve everything as UTF-8 (although not technically correct, this doesn’t break anything for binary files)
		python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$port";
	}

	# Check which processes are attached to a given port
	function portusage() {
		lsof -n -i:$1 | grep LISTEN
	}

	# Create a data URL from a file
	function dataurl() {
		local mimeType=$(file -b --mime-type "$1");
		if [[ $mimeType == text/* ]]; then
			mimeType="${mimeType};charset=utf-8";
		fi
		echo "data:${mimeType};base64,$(openssl base64 -in "$1" | tr -d '\n')";
	}

	function whois() {
		whois $1 | grep -E '^\s{3}'}
	}



# --- GO LANG ------------------------

	alias go=richgo

	function go-watch-tests() {
		if ! command -v nodemon &> /dev/null
		then
			echo "nodemon is required to run this command.\n"
			echo "Install by running \"npm install -g nodemon\""
			exit
		fi

		nodemon -w "$1" -x "clear && echo \"Running tests... \n\n\" && go test \"$1\"" -e "go"
	}



# --- FILES ---------------------------

	alias ..="cd .."
	alias ...="cd ../.."
	alias ....="cd ../../.."
	alias .....="cd ../../../.."
	alias ~="cd ~" # `cd` is probably faster to type though
	alias -- -="cd -"

	# Create a new directory and enter it
	function mkd() {
		mkdir -p "$@" && cd "$_";
	}

	# Create a .tar.gz archive, using `zopfli`, `pigz` or `gzip` for compression
	function targz() {
		local tmpFile="${@%/}.tar";
		tar -cvf "${tmpFile}" --exclude=".DS_Store" "${@}" || return 1;

		size=$(
			stat -f"%z" "${tmpFile}" 2> /dev/null; # OS X `stat`
			stat -c"%s" "${tmpFile}" 2> /dev/null # GNU `stat`
		);

		local cmd="";
		if (( size < 52428800 )) && hash zopfli 2> /dev/null; then
			# the .tar file is smaller than 50 MB and Zopfli is available; use it
			cmd="zopfli";
		else
			if hash pigz 2> /dev/null; then
				cmd="pigz";
			else
				cmd="gzip";
			fi;
		fi;

		echo "Compressing .tar using \`${cmd}\`…";
		"${cmd}" -v "${tmpFile}" || return 1;
		[ -f "${tmpFile}" ] && rm "${tmpFile}";
		echo "${tmpFile}.gz created successfully.";
	}

	# Determine size of a file or total size of a directory
	function fs() {
		if du -b /dev/null > /dev/null 2>&1; then
			local arg=-sbh;
		else
			local arg=-sh;
		fi
		if [[ -n "$@" ]]; then
			du $arg -- "$@";
		else
			du $arg .[^.]* ./*;
		fi;
	}

	# `tre` is a shorthand for `tree` with hidden files and color enabled, ignoring
	# the `.git` directory, listing directories first. The output gets piped into
	# `less` with options to preserve color and line numbers, unless the output is
	# small enough for one screen.
	function tre() {
		tree -aC -I '.git|node_modules|bower_components' --dirsfirst "$@" | less -FRNX;
	}

	# Compare original and gzipped file size
	function gz() {
		local origsize=$(wc -c < "$1");
		local gzipsize=$(gzip -c "$1" | wc -c);
		local ratio=$(echo "$gzipsize * 100 / $origsize" | bc -l);
		printf "orig: %d bytes\n" "$origsize";
		printf "gzip: %d bytes (%2.2f%%)\n" "$gzipsize" "$ratio";
	}



### --- DOCKER ------------------------

	alias docker-stop-all="docker kill $(docker ps -q)"
	alias docker-rm-all="docker rm $(docker ps -a -q)"
	alias docker-clear='docker rmi $(docker images | grep "^<none>" | awk "{print $3}")'

	function docker-exec {
		docker exec -e COLUMNS="`tput cols`" -e LINES="`tput lines`" -ti "$1" bash
	}



### --- GIT / GITHUB ------------------------

	alias gs="git status"
	alias gc="git commit"
	alias gp="git push"
	alias gl="git l"
	alias gco="git checkout"
	alias ts="tig status"


### --- APPS --------------------

	# Kill all the tabs in Chrome to free up memory
	# [C] explained: http://www.commandlinefu.com/commands/view/402/exclude-grep-from-your-grepped-output-of-ps-alias-included-in-description
	alias chromekill="ps ux | grep '[C]hrome Helper --type=renderer' | grep -v extension-process | tr -s ' ' | cut -d ' ' -f2 | xargs kill"



