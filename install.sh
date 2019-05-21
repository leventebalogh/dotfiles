# Copying
echo "* Copying dotfiles to ${HOME}"
echo ""
cp -frvT ./src/ ~/
echo ""

# Reloading bash session
echo "* Reloding BASH session..."
echo ""
source ~/.bashrc

echo "✔ Successfully installed bash scripts."
