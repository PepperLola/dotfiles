if [ -f "$HOME/.zshrc" ]; then
  echo "$PC[$SC*$PC] Found .zshrc, creating backup..."
  cp $HOME/.zshrc $HOME/.zshrc.bk
fi

rm -r $HOME/.zshrc $HOME/aliases

echo "$PC[$SC*$PC] Copying zsh config..."
if [[ "$(pwd)" == *zsh ]]; then
  cp ./.zshrc $HOME/.zshrc
  cp -r ./* $HOME
else
  cp ./zsh/.zshrc $HOME/.zshrc
  cp -r ./zsh/* $HOME
fi
