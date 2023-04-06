" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  "autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')

  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}
  Plug 'glepnir/galaxyline.nvim', {'branch': 'main'}
  Plug 'ryanoasis/vim-devicons'
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'airblade/vim-gitgutter'
  Plug 'junegunn/fzf' " fuzzy find files
  Plug 'tpope/vim-fugitive'
  Plug 'scrooloose/nerdcommenter'
  Plug 'wakatime/vim-wakatime'
  "Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

  Plug 'christoomey/vim-tmux-navigator'

  Plug 'morhetz/gruvbox'

  Plug 'HerringtonDarkholme/yats.vim' " TS Syntax

call plug#end()
