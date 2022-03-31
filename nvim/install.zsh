echo "$PC[$SC*$PC] Creating nvim ~/.config/nvim directory"
mkdir -p $HOME/.config/nvim

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

echo "$PC[$SC*$PC] Creating a Python virtual environment"
python3 -m venv $HOME/.config/nvim/env
source $HOME/.config/nvim/env/bin/activate

echo "$PC[$SC*$PC] Upgrading pip"
$HOME/.config/nvim/env/bin/python3 -m pip install --upgrade pip --quiet

echo "$PC[$SC*$PC] Installing Python dependencies"
pip install wheel yapf doq pynvim --quiet
deactivate
