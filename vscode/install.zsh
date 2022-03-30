echo "\033[1;93m[\033[1;97m*\033[1;93m] Creating VSCode ~/.vscode directory"
if [ ! -d "$HOME/.vscode" ]; then
  mkdir "$HOME/.vscode"
fi
echo "\033[1;93m[\033[1;97m*\033[1;93m] Copying VSCode styles..."
if [ "$(pwd)" == *vscode ]; then
  cp -r ./styles "$HOME/.vscode"
else
  cp -r ./vscode/styles "$HOME/.vscode"
fi
