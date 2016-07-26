# Adds basic, but really fast autocompletion for gulp.
#
# NOTE!
# Only the tasknames will be autocompleted.
#
# Why?
# ----
# Default gulp completion is really-really slow, hard to work with.
#
#
# How to use?
# -----------
# This autocompletion will check if there is a gulpfile.js found up in the directory tree,
# and if it finds one, it will check for gulp tasks under that directory recursively.
#
# You can also extend the search paths for gulp tasks:
#
# 1. create a file called .gulp-completion in the same directory as gulpfile.js
# 2. put path patterns relative to that directory, where you would like to search for gulp tasks
#
#   Example content for .gulp-completion file:
#
#       ../common-gulp-tasks/*.js
#       ../foo-bar-gulp-tasks/**/*.js
#

# Finds a file by filename up in the directory tree
function find_file {
    file_name=$1
    file_path=""
    current_path=`pwd`;

    while [ "$current_path" != "/" ] ; do
        file_path=$(find "$current_path" -maxdepth 1 -name $file_name)

        # Found it
        if [ ! -z $file_path ]; then
            break
        fi

        current_path=`dirname "$current_path"`
    done

    echo $file_path
}

# Returns path patterns both from the base directory and from patterns found
# in the .gulp-completion file
function get_patterns {
    base_directory=$1
    config_file=$2

    patterns="$base_directory/**/*.js"

    # Get patterns from config file, if exists
    if [ ! -z "$config_file" ]; then
        while read p; do
            if [ -z "$p" ]; then
                continue
            fi

            p=$base_directory/$p
            patterns="$patterns $p"
        done <$config_file
    fi

    echo $patterns
}

function _gulp_completions() {
    local cur="${COMP_WORDS[COMP_CWORD]}"
    local config_file=`find_file .gulp-completion`
    local gulp_file=`find_file gulpfile.js`

    if [ -z "$gulp_file" ]; then
        exit
    fi

    base_directory=`dirname $gulp_file`
    patterns=`get_patterns $base_directory $config_file`

    # Get all gulp tasks in the files
    gulp_tasks=`grep -rhio  "gulp\.task('[^']*" $patterns | sed "s/gulp.task('//g"`

    # Without this autocompletion would not work for colons
    COMP_WORDBREAKS=${COMP_WORDBREAKS//:}

    # Tell complete what stuff to show.
    COMPREPLY=($(compgen -W "$gulp_tasks" -- "$cur"))
}

complete -o default -F _gulp_completions gulp
