# TODO add colors
echo "\033[1;93m[\033[1;97m*\033[1;93m] Creating nvim ~/.config/nvim directory"
mkdir -p ~/.config/nvim

echo "[\033[1;97m*\033[1;93m] Copying nvim config to ~/.config/nvim"
sudo cp -r ./nvim ~/.config/nvim
echo "[\033[1;97m*\033[1;93m] Creating a Python virtual environment"
python3 -m venv ~/.config/nvim/env
source ~/.config/nvim/env/bin/activate
echo "[\033[1;97m*\033[1;93m] Upgrading pip"
~/.config/nvim/env/bin/python3 -m pip install --upgrade pip --quiet
echo "[\033[1;97m*\033[1;93m] Installing Python dependencies"
pip install wheel yapf doq pynvim --quiet
deactivate

if [ -f ~/.config/nvim/init.vim ]; then
    echo '[\033[1;97m*\033[1;93m] Backing up existing init.vim'
    cp ~/.config/nvim/init.vim ~/.config/nvim/init.vim.backup
fi

echo "[\033[1;97m*\033[1;93m] Copying tmux config"
cp ./tmux/.tmux.conf ~/

echo "Done!"
