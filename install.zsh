# Ask for sudo password upfront
sudo -v

# Run the install script for each directory
for file in ./**; do
  if [ -d "$file" ]; then
    if [ -f "$file/install.zsh" ]; then
      source "$file/install.zsh"
    fi
  fi
done

echo "Done!"
