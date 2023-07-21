#!/bin/zsh
if [ -f "$HOME/.zshrc" ]; then
  echo "${PC}[$SC*$PC] Found .zshrc, creating backup..."
  cp $HOME/.zshrc $HOME/.zshrc.bk
fi

if [[ -f $HOME/.zshrc && -d $HOME/aliases ]]; then
    rm -r $HOME/.zshrc $HOME/aliases
fi

echo "${PC}[$SC*$PC] Copying zsh config..."
if [[ "$(pwd)" == *zsh ]]; then
  cp ./.zshrc $HOME/.zshrc
  rsync -avq ./* $HOME --exclude .zshrc
else
  cp ./zsh/.zshrc $HOME/.zshrc
  rsync -avq ./zsh/* $HOME --exclude ./zsh/.zshrc
fi

echo "${PC}[$SC*$PC] Sourcing zsh config"
source ~/.zshrc
