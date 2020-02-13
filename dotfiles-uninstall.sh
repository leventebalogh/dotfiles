# Copying
echo "* Removing dotfiles from ${HOME}"
echo ""

FILES=./src/.*
for f in $FILES
do
    # Exclude "." and ".."
    [[ $f =~ (/.|/..)$ ]] && continue

    filename=$(basename $f)
    filepath="${HOME}/${filename}"
    echo "Removing \"$filepath\""
    rm $filepath > /dev/null 2>&1
done
echo ""

echo "✔ Successfully uninstalled dotfiles."
