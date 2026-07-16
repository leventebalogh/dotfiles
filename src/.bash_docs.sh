# Prints HELP for the available functions.
function docs () {
	printf "This is a quick help for the available custom functions and aliases.\n\n"

	printBold "Use '$> edit' to edit the bash configuration."

	printHeader "Github"

		# Show PR checks
		printBold "gh pr checks";
		printDescription "Shows Github checks for the current branch";
		printExample "$> gh pr checks "
		printBr

		# Create PR
		printBold "gh pr create";
		printDescription "Opens a new PR on Github from the current branch";
		printExample "$> gh pr create "
		printBr

        # View PR
		printBold "gh pr view";
		printDescription "Show a summary of a PR";
		printExample "$> gh pr view -w"
		printBr

        # List Releases
		printBold "gh release list";
		printDescription "Show the list of releases";
		printExample "$> gh release list"
		printBr


	printHeader "Go"

		# go-watch-tests ()
		printBold "go-watch-tests()"
		printDescription "Re-runs go tests on file changes."
		printExample "$> go-watch-tests ./pkg/server/api"
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