export EDITOR="nvim"
export TZ="America/Los_Angeles"

eval "$(starship init zsh)"

source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"

# dotfiles
for file in $HOME/aliases/*; do
  source $file
done

for file in $HOME/funcs/*; do
  source $file
done

# PATH
export PATH="/opt/homebrew/bin:$PATH"
export PATH="$PATH:$(brew --prefix)/bin"
export PATH="$PATH:$(brew --prefix)/opt/llvm/bin"
export PATH="$PATH:/opt/node/bin"
export PATH="$PATH:$HOME/CEdev/bin"
export PATH="$PATH:~/tools/john/run"
export PATH="$PATH:/opt/homebrew/opt/john-jumbo/share/john"

export JAVA_HOME=$(/usr/libexec/java_home -v21)

export VIRTUAL_ENV_DISABLE_PROMPT=
export LC_CTYPE=en_US.UTF-8
export TERM="xterm-256color"
[[ ! -d $HOME/.tmux/ ]] && export TERM="screen-256color"
export ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor line)
export ZSH_TMUX_AUTOSTART=true

#export PATH="/opt/homebrew/bin:$PATH"
export PATH="$HOME/Desktop/Misc/Scripts:$PATH"
export PATH="$PATH:$HOME/go/bin"
export PATH="$HOME/scripts:$PATH"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# bun completions
[ -s "~/.bun/_bun" ] && source "~/.bun/_bun"

# fzf
source <(fzf --zsh)

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

_fzf_compgen_path() {
    fd --hidden --follow --exclude ".git" . "$1"
}

_fzf_compgen_dir() {
    fd --type=d --hidden --follow --exclude ".git" . "$1"
}

source ~/fzf-git.sh/fzf-git.sh

autoload -Uz compinit
compinit
_comp_options+=(globdots) # include hidden files

source <(fnm completions --shell zsh)
eval "$(fnm env --use-on-cd)"

function iplot {
    cat <<EOF | gnuplot
    set terminal pngcairo enhanced font 'Fira Sans,10'
    set autoscale
    set samples 1000
    set output '|kitten icat --stdin yes'
    set object 1 rectangle from screen 0,0 to screen 1,1 fillcolor rgb"#fdf6e3" behind
    plot $@
    set output '/dev/null'
EOF
}

function isplot {
    cat <<EOF | gnuplot
    set terminal pngcairo enhanced font 'Fira Sans,10'
    set autoscale
    set samples 1000
    set output '|kitten icat --stdin yes'
    set object 1 rectangle from screen 0,0 to screen 1,1 fillcolor rgb"#fdf6e3" behind
    splot $@
    set output '/dev/null'
EOF
}
