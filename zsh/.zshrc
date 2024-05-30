export EDITOR="nvim"
export TZ="America/Los_Angeles"

eval "$(starship init zsh)"

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Define custom text when waiting for completion
COMPLETION_WAITING_DOTS="%F{yellow}Waiting...%f"

# Define timestamp format
HIST_STAMPS="mm/dd/yyyy"

source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

for file in $HOME/aliases/*; do
  source $file
done

for file in $HOME/funcs/*; do
  source $file
done

export PATH="/opt/homebrew/bin:$PATH"
export PATH="$PATH:$(brew --prefix)/bin"
export PATH="$PATH:$(brew --prefix)/opt/llvm/bin"
export PATH="$PATH:/opt/node/bin"
export PATH="$PATH:$HOME/CEdev/bin"
export PATH="$PATH:~/tools/john/run"
export PATH="$PATH:/opt/homebrew/opt/john-jumbo/share/john"

export JAVA_HOME=$(/usr/libexec/java_home -v17)

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

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

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# bun completions
[ -s "~/.bun/_bun" ] && source "~/.bun/_bun"

# fzf
eval "$(fzf --zsh)"

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

_fzf_compgen_path() {
    fd --hidden --exclude .git . "$1"
}

_fzf_compgen_dir() {
    fd --type=d --hidden --exclude .git . "$1"
}

source ~/fzf-git.sh/fzf-git.sh

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
