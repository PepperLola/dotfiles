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
    zip $HOME/.config/nvim.bk.zip $HOME/.config/nvim/* && \
        rm -rf $HOME/.config/nvim/after
fi

echo "$PC[$SC*$PC] Copying nvim config to ~/.config/nvim"
$CONF_PATH=./nvim/
if [[ "$(pwd)" == *nvim ]]; then
  CONF_PATH=./
fi

rsync -av --progress $CONF_PATH/* $HOME/.config/nvim --exclude after && \
    nvim --headless -c "so|autocmd User PackerComplete quitall" ~/.config/nvim/lua/pepperlola/packer.lua -c "PackerSync" && \
    rsync -av --progress $CONF_PATH/after $HOME/.config/nvim


if [[ -d ~/.local/share/nvim/site/pack/packer/start/packer.nvim ]]; then
  echo "$PC[$SC*$PC] Packer found!"
else
  echo "$PC[$SC*$PC] Packer not found. Installing..."
  git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim &> /dev/null
fi

echo "$PC[$SC*$PC] Creating a Python virtual environment"
python3 -m venv $HOME/.config/nvim/env
source $HOME/.config/nvim/env/bin/activate

echo "$PC[$SC*$PC] Upgrading pip"
$HOME/.config/nvim/env/bin/python3 -m pip install --upgrade pip --quiet

echo "$PC[$SC*$PC] Installing Python dependencies"
pip install wheel yapf doq pynvim --quiet
deactivate
