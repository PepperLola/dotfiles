if [ -f "$HOME/.zshrc" ]; then
  echo "[\033[1;97m*\033[1;93m] Found .zshrc, creating backup..."
  cp $HOME/.zshrc $HOME/.zshrc.bk
fi

echo "[\033[1;97m*\033[1;93m] Copying zsh config..."
cp -r ./* $HOME
