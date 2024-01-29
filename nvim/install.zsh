echo "$PC[$SC*$PC] Creating nvim ~/.config/nvim directory"
mkdir -p $HOME/.config/nvim

if ! command -v nvim &> /dev/null; then
  echo "$PC[$SC*$PC] Neovim not found, installing..."
  if [[ `uname` == "Darwin" ]]; then
    brew install nvim &> /dev/null
  elif [[ `uname` == "Linux" ]]; then
    sudo apt install neovim &> /dev/null
  fi
fi

if [ -d $HOME/.config/nvim ]; then
    echo "$PC[$SC*$PC] Backing up existing nvim config"
    if [ -f $HOME/.config/nvim.bk.zip ]; then
        rm $HOME/.config/nvim.bk.zip
    fi
    WD="$(pwd)"
    cd $HOME/.config
    zip -qr nvim.bk.zip ./nvim/* && \
        rm -rf ./nvim/after && \
        cd $WD
fi

echo "$PC[$SC*$PC] Copying nvim config to ~/.config/nvim"
CONF_PATH=./nvim/
if [[ "$(pwd)" == *nvim ]]; then
  CONF_PATH=./
fi

cp -r "$CONF_PATH" ~/.config/nvim

# echo "$PC[$SC*$PC] Installing nvim packages"
# rsync -avq $CONF_PATH/* $HOME/.config/nvim --exclude after && \
#     nvim --headless -c "so|autocmd User PackerComplete quitall" ~/.config/nvim/lua/pepperlola/packer.lua -c "PackerSync" && \
#     rsync -avq $CONF_PATH/after $HOME/.config/nvim


echo "$PC[$SC*$PC] Creating a Python virtual environment"
python3 -m venv $HOME/.config/nvim/env
source $HOME/.config/nvim/env/bin/activate

echo "$PC[$SC*$PC] Upgrading pip"
$HOME/.config/nvim/env/bin/python3 -m pip install --upgrade pip --quiet

echo "$PC[$SC*$PC] Installing Python dependencies"
pip install wheel yapf doq pynvim --quiet
deactivate
