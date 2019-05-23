# Prints HELP for the available functions.
function docs () {
	printf "This is a quick help for the available custom functions and aliases.\n\n"

	printBold "Use '$> edit' to edit the bash configuration."

	printHeader "Casumo"

		# c-search-issue ()
		printBold "c-search-issue()";
		printDescription "Search an issue in Casumo.";
		printExample "$> c-search-issue 'Tech help' "
		printBr

		# c-search-pr ()
		printBold "c-search-pr()"
		printDescription "Search a PR in Casumo."
		printExample "$> c-search-pr 'ESLint'"
		printBr

		# c-new-issue ()
		printBold "c-new-issue()"
		printDescription "Create a new issue."
		printExample "$> c-new-issue"
		printBr

		# c-open-issue ()
		printBold "c-open-issue()"
		printDescription "Opens an issue by issue-number."
		printExample "$> c-open-issue 1234"
		printBr


	printHeader "Web"

		# urlencode () - Alias
		printBold "urlencode()"
		printDescription "URL-encodes a string"
		printExample "$> urlencode foo=bar"
		printBr

		# server ()
		printBold "server()"
		printDescription "Starts a new HTTP server in a directory."
		printExample "$> server ./"
		printBr

		# chromekill ()
		printBold "chromekill()"
		printDescription "Kills all tabs in Chrome to free up memory."
		printExample "$> chromekill"
		printBr


	printHeader "Docker"

		# docker-clear-containers () - Alias
		printBold "docker-clear-containers()"
		printDescription "Cleans up unusued containers."
		printExample "$> docker-clear-containers"
		printBr

		# docker-clear-images () - Alias
		printBold "docker-clear-images()"
		printDescription "Cleans up unusued images."
		printExample "$> docker-clear-images"
		printBr

		# docker-exec () - Alias
		printBold "docker-exec()"
		printDescription "Logs in to the selected container running bash."
		printExample "$> docker-exec <container-name>"
		printBr

	printHeader "Network"

		# digga ()
		printBold "digga()"
		printDescription "Digs on a domain name."
		printExample "$> digga leventebalogh.com"
		printBr

		# portusage ()
		printBold "portusage()"
		printDescription "Shows which processes are using a certain port."
		printExample "$> portusage 8080"
		printBr

		# get-ssl-cert () - Alias
		printBold "get-ssl-cert()"
		printDescription "Gets and prints out the SSL cert for a domain."
		printExample "$> get-ssl-cert leventebalogh.com"
		printBr

		# netusage () - Alias
		printBold "netusage()"
		printDescription "Shows network usage statistics"
		printExample "$> netusage"
		printBr

		# flush () - Alias
		printBold "flush()"
		printDescription "Flushes DNS cache"
		printExample "$> flush"
		printBr

		# location-by-ip () - Alias
		printBold "location-by-ip()"
		printDescription "Returns with location data based on your public IP"
		printExample "$> location-by-ip"
		printBr

		# whois () - Alias
		printBold "whois()"
		printDescription "Returns register information about a domain"
		printExample "$> whois leventebalogh.com"
		printBr


	printHeader "Files"

		# mkd ()
		printBold "mkd()"
		printDescription "Create a new directory and enter it."
		printExample "$> mkd foo"
		printBr

		# targz ()
		printBold "targz()"
		printDescription "Creates a tar.gz in the same folder."
		printExample "$> targz ./foo"
		printBr

		# fs ()
		printBold "fs()"
		printDescription "Determines total size of a directory / file."
		printExample "$> fs ./foo/"
		printBr

		# dataurl ()
		printBold "dataurl()"
		printDescription "Creates a data url from a file."
		printExample "$> dataurl ./foo.jpg"
		printBr

		# gz ()
		printBold "gz()"
		printDescription "Shows gzipped size vs original size."
		printExample "$> gz ./foo.js"
		printBr

		# tre ()
		printBold "tre()"
		printDescription "Shorter version of tree"
		printExample "$> tre ."
		printBr

		# emptytrash () - Alias
		printBold "emptytrash()"
		printDescription "Empties the trash."
		printExample "$> emptytrash"
		printBr


	printHeader "General"

		# calc ()
		printBold "calc()"
		printDescription "Simple calculator. "
		printExample "$> calc 5*5 // 25"
		printBr

		# codepoint ()
		printBold "codepoint()"
		printDescription "Shows a characters unicode codepoint"
		printExample "$> codepoint A"
		printBr


}

function edit () {
	code ~/projects/dotfiles
}

function printBold () {
	bold=$(tput bold)
	normal=$(tput sgr0)
	printf "${bold}$1${normal}"
}

function printHeader () {
	printBr
	printBr
	printBold "--- $1 -------------------------"
	printBr
}

function printDim () {
	dim="\e[2m"
	normal=$(tput sgr0)
	printf "${dim}$1${normal}"
}

function printDescription () {
	printf " - $1"
}

function printExample () {
	printDim " Example: $1"
}

function printBr () {
	printf "\n";
}

function c-search-issue () {
    open "https://github.com/casumo/Home/issues?q=is:issue+\"$1\"+is:open";
}

function c-search-pr () {
    open "https://github.com/search?q=org%3ACasumo+$1&type=Issues";
}

# Simple calculator
function calc() {
	local result="";
	result="$(printf "scale=10;$*\n" | bc --mathlib | tr -d '\\\n')";
	#                       └─ default (when `--mathlib` is used) is 20
	#
	if [[ "$result" == *.* ]]; then
		# improve the output for decimal numbers
		printf "$result" |
		sed -e 's/^\./0./'        `# add "0" for cases like ".5"` \
		    -e 's/^-\./-0./'      `# add "0" for cases like "-.5"`\
		    -e 's/0*$//;s/\.$//';  # remove trailing zeros
	else
		printf "$result";
	fi;
	printBr
}

# Check which processes are attached to a given port
function portusage() {
	lsof -n -i:$1 | grep LISTEN
}

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

# Use Git’s colored diff when available
hash git &>/dev/null;
if [ $? -eq 0 ]; then
	function diff() {
		git diff --no-index --color-words "$@";
	}
fi;

# Create a data URL from a file
function dataurl() {
	local mimeType=$(file -b --mime-type "$1");
	if [[ $mimeType == text/* ]]; then
		mimeType="${mimeType};charset=utf-8";
	fi
	echo "data:${mimeType};base64,$(openssl base64 -in "$1" | tr -d '\n')";
}

# Start an HTTP server from a directory, optionally specifying the port
function server() {
	local port="${1:-8000}";
	sleep 1 && open "http://localhost:${port}/" &
	# Set the default Content-Type to `text/plain` instead of `application/octet-stream`
	# And serve everything as UTF-8 (although not technically correct, this doesn’t break anything for binary files)
	python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$port";
}

# Compare original and gzipped file size
function gz() {
	local origsize=$(wc -c < "$1");
	local gzipsize=$(gzip -c "$1" | wc -c);
	local ratio=$(echo "$gzipsize * 100 / $origsize" | bc -l);
	printf "orig: %d bytes\n" "$origsize";
	printf "gzip: %d bytes (%2.2f%%)\n" "$gzipsize" "$ratio";
}

# Syntax-highlight JSON strings or files
# Usage: `json '{"foo":42}'` or `echo '{"foo":42}' | json`
function json() {
	if [ -t 0 ]; then # argument
		python -mjson.tool <<< "$*" | pygmentize -l javascript;
	else # pipe
		python -mjson.tool | pygmentize -l javascript;
	fi;
}

# Run `dig` and display the most useful info
function digga() {
	dig +nocmd "$1" any +multiline +noall +answer;
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

# `tre` is a shorthand for `tree` with hidden files and color enabled, ignoring
# the `.git` directory, listing directories first. The output gets piped into
# `less` with options to preserve color and line numbers, unless the output is
# small enough for one screen.
function tre() {
	tree -aC -I '.git|node_modules|bower_components' --dirsfirst "$@" | less -FRNX;
}
