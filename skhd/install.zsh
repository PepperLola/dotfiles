echo "$PC[$SC*$PC] Copying skhd config"
mkdir -p $HOME/.config/skhd
if [[ "$(pwd)" == *skhd ]]; then
  cp ./skhdrc $HOME/.config/skhd
else
  cp ./skhd/skhdrc $HOME/.config/skhd
fi
