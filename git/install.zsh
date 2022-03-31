if ! command -v git &> /dev/null; then
  echo "$PC[$SC*$PC] Git not found, installing..."
  if [[ `uname` == "Darwin" ]]; then
    brew install git &> /dev/null
  elif [[ `uname` == "Linux" ]]; then
    sudo apt install git &> /dev/null
  fi
fi

if [ -f "$HOME/.gitconfig" ]; then
  echo "$PC[$SC*$PC] Found ~/.gitconfig, creating backup..."
  cp $HOME/.gitconfig $HOME/.gitconfig.bk
fi

if [ -f "$HOME/.gitignore_global" ]; then
  echo "$PC[$SC*$PC] Found ~/.gitignore_global, creating backup..."
  cp $HOME/.gitignore_global $HOME/.gitignore_global.bk
fi

echo "$PC[$SC*$PC] Copying .gitconfig and .gitignore_global"
if [[ "$(pwd)" == *git ]]; then
  cp ./.gitconfig $HOME
  cp ./.gitignore_global $HOME
  cp -r ./* $HOME
else
  cp ./git/.gitconfig $HOME
  cp ./git/.gitignore_global $HOME
  cp -r ./git/* $HOME
fi
