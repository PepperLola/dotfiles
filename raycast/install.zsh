echo "$PC[$SC*$PC] Copying Raycast scripts"
mkdir -p $HOME/.config/raycast/scripts
if [[ "$(pwd)" == *raycast ]]; then
  cp -r ./scripts $HOME/.config/raycast
else
  cp -r ./raycast/scripts $HOME/.config/raycast
fi
