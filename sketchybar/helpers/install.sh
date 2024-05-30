brew install lua
brew install switchaudio-osx
# brew install nowplaying-cli

brew tap FelixKratz/formulae
brew install sketchybar

brew install --cask sf-symbols
brew install --cask homebrew/cask-fonts/font-sf-mono
brew install --cask homebrew/cask-fonts/font-sf-pro

curl -L "https://github.com/kvndrsslr/sketchybar-app-font/releases/download/v2.0.5/sketchybar-app-font.ttf" -o "$HOME/Library/Fonts/sketchybar-app-font.ttf"

(git clone https://github.com/FelixKratz/SbarLua.git /tmp/SbarLua && cd /tmp/SbarLua/ && make install && rm -rf /tmp/SbarLua/)
