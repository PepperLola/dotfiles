echo "$PC[$SC*$PC] Copying yabai config"
mkdir -p $HOME/.config/yabai
if [[ "$(pwd)" == *yabai ]]; then
  cp ./yabairc $HOME/.config/yabai
else
  cp ./yabai/yabairc $HOME/.config/yabai
fi
