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

if [ -f $HOME/.config/nvim/init.vim ]; then
    echo "$PC[$SC*$PC] Backing up existing init.vim"
    cp $HOME/.config/nvim/init.vim $HOME/.config/nvim/init.vim.backup
fi

echo "$PC[$SC*$PC] Copying nvim config to ~/.config/nvim"
if [[ "$(pwd)" == *nvim ]]; then
  cp -r ./* $HOME/.config/nvim
else
  cp -r ./nvim/* $HOME/.config/nvim
fi

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
