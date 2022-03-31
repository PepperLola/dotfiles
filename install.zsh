# Ask for sudo password upfront
sudo -v

# Primary Color
export PC="\033[1;93m"
# Secondary Color
export SC="\033[1;97m"

# Run the install script for each directory
for file in ./**; do
  if [ -d "$file" ]; then
    if [ -f "$file/install.zsh" ]; then
      source "$file/install.zsh"
    fi
  fi
done

echo "Done!"
