if [ ! -d "$HOME/.vscode" ]; then
  echo "$PC[$SC*$PC] Creating VSCode ~/.vscode directory"
  mkdir "$HOME/.vscode"
fi
echo "$PC[$SC*$PC] Copying VSCode styles..."
if [[ "$(pwd)" == *vscode ]]; then
  cp -r ./styles "$HOME/.vscode"
else
  cp -r ./vscode/styles "$HOME/.vscode"
fi
