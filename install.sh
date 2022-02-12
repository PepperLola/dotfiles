#!/bin/bash -e

# TODO add colors
echo "[*] Creating nvim ~/.config/nvim directory"
mkdir -p ~/.config/nvim

echo "[*] Copying nvim config to ~/.config/nvim"
sudo cp -r ./nvim ~/.config/nvim
echo "[*] Creating a Python virtual environment"
python3 -m venv ~/.config/nvim/env
source ~/.config/nvim/env/bin/activate
echo "[*] Upgrading pip"
~/.config/nvim/env/bin/python3 -m pip install --upgrade pip --quiet
echo "[*] Installing Python dependencies"
pip install wheel yapf doq pynvim --quiet
deactivate

if [ -f ~/.config/nvim/init.vim ]; then
    echo '[*] Backing up existing init.vim'
    cp ~/.config/nvim/init.vim ~/.config/nvim/init.vim.backup
fi

echo "Done!"
