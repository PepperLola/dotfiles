echo "$PC[$SC*$PC] Copying tmux config"
if [[ "$(pwd)" == *tmux ]]; then
  cp ./.tmux.conf $HOME
else
  cp ./tmux/.tmux.conf $HOME
fi
