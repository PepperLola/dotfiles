ifeq ($(OS),Windows_NT)
	ROOT:=C:\\
	CONFIG_PATH:=%APPDATA%\\Local\\
	SEP:=\\
else
	CONFIG_PATH:=~/.config/
	NU_PATH=~/Library/Application\ Support/nushell/
	SEP:=/
	ROOT:=~/
endif

WD:=$(shell pwd)/

nvim:=${CONFIG_PATH}nvim
gitconfig:=${ROOT}.gitconfig
gitignore_global:=${ROOT}.gitignore_global
raycast:=${CONFIG_PATH}raycast
raycast_scripts:=${raycast}${SEP}scripts
kitty:=${CONFIG_PATH}kitty
zshrc:=${ROOT}.zshrc
starship:=${CONFIG_PATH}starship.toml
sketchybar:=${CONFIG_PATH}sketchybar
fzf_git:=${ROOT}fzf-git.sh
zsh_aliases:=${ROOT}aliases
zsh_funcs:=${ROOT}funcs
zsh_scripts:=${ROOT}scripts
vscode:=${ROOT}.vscode
vscode_styles:=${ROOT}.vscode${SEP}styles
yazi:=${CONFIG_PATH}yazi
nu:=${CONFIG_PATH}nushell
aerospace:=${CONFIG_PATH}aerospace
zellij:=${CONFIG_PATH}zellij
lazygit:=${CONFIG_PATH}lazygit
wezterm:=${ROOT}.wezterm.lua

all: ${nvim} ${gitconfig} ${gitignore_global} ${raycast} ${raycast_scripts} ${zshrc} ${starship} ${sketchybar} ${fzf_git} ${zsh_aliases} ${zsh_funcs} ${zsh_scripts} ${vscode} ${vscode_styles} ${yazi} ${nu} ${aerospace} ${zellij} ${lazygit} ${wezterm}

${nvim}:
	ln -sfn ${WD}nvim ${nvim}

${gitconfig}:
	ln -sfn ${WD}git${SEP}.gitconfig ${gitconfig}

${gitignore_global}:
	ln -sfn ${WD}git${SEP}.gitignore_global ${gitignore_global}

${raycast}:
	mkdir -p ${raycast}

${raycast_scripts}:
	ln -sfn ${WD}raycast${SEP}scripts ${raycast}

${kitty}:
	ln -sfn ${WD}kitty ${kitty}

${zshrc}:
	ln -sfn ${WD}zsh${SEP}.zshrc ${zshrc}

${starship}:
	ln -sfn ${WD}starship${SEP}starship.toml ${starship}

${sketchybar}:
	ln -sfn ${WD}sketchybar ${sketchybar}

${fzf_git}:
	ln -sfn ${WD}zsh${SEP}fzf-git.sh ${fzf_git}

${zsh_aliases}:
	ln -sfn ${WD}zsh${SEP}aliases ${zsh_aliases}

${zsh_funcs}:
	ln -sfn ${WD}zsh${SEP}funcs ${zsh_funcs}

${zsh_scripts}:
	ln -sfn ${WD}zsh${SEP}scripts ${zsh_scripts}

${vscode}:
	mkdir -p ${vscode}

${vscode_styles}:
	ln -sfn ${WD}vscode${SEP}styles ${vscode_styles}

${yazi}:
	ln -sfn ${WD}yazi ${yazi}

${nu}:
	ln -sfn ${WD}nushell ${nu}

${aerospace}:
	ln -sfn ${WD}aerospace ${aerospace}

${zellij}:
	ln -sfn ${WD}zellij ${zellij}

${lazygit}:
	ln -sfn ${WD}lazygit ${lazygit}

${wezterm}:
	ln -sfn ${WD}wezterm${SEP}.wezterm.lua ${wezterm}

clean:
	unlink ${nvim}
	unlink ${gitconfig}
	unlink ${gitignore_global}
	unlink ${raycast_scripts}
	unlink ${zshrc}
	unlink ${starship}
	unlink ${sketchybar}
	unlink ${fzf_git}
	unlink ${zsh_aliases}
	unlink ${zsh_funcs}
	unlink ${zsh_scripts}
	unlink ${vscode_styles}
	unlink ${yazi}
	unlink ${nu}
	unlink ${aerospace}
	unlink ${zellij}
	unlink ${lazygit}
