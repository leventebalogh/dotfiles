# Copying
echo "* Copying dotfiles to ${HOME}"
echo ""

# OSX
if [ "$(uname)" == "Darwin" ]; then
    cp -frv ./src/ ~/
# Linux
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    cp -frvT ./src/ ~/
fi

echo ""

# Reloading bash session
echo "* Reloding BASH session..."
echo ""
source ~/.bashrc

echo "✔ Successfully installed bash scripts."
