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
tmux:=${ROOT}.tmux.conf
tmux_post:=${ROOT}.tmux${SEP}postprocessing
kitty:=${CONFIG_PATH}kitty
zshrc:=${ROOT}.zshrc
starship:=${CONFIG_PATH}starship.toml
sketchybar:=${CONFIG_PATH}sketchybar
svim:=${CONFIG_PATH}svim
borders:=${CONFIG_PATH}borders
fzf_git:=${ROOT}fzf-git.sh
zsh_aliases:=${ROOT}aliases
zsh_funcs:=${ROOT}funcs
zsh_scripts:=${ROOT}scripts
vscode:=${ROOT}.vscode
vscode_styles:=${ROOT}.vscode${SEP}styles
skhd:=${CONFIG_PATH}skhd
yabai:=${CONFIG_PATH}yabai
yazi:=${CONFIG_PATH}yazi
nu:=${CONFIG_PATH}nushell
aerospace:=${CONFIG_PATH}aerospace

all: ${nvim} ${gitconfig} ${gitignore_global} ${raycast} ${raycast_scripts} ${kitty} ${zshrc} ${starship} ${fzf_git} ${zsh_aliases} ${zsh_funcs} ${zsh_scripts} ${vscode} ${vscode_styles} ${skhd} ${yabai} ${yazi} ${nu} ${aerospace}

${nvim}:
	ln -s ${WD}nvim ${nvim}

${gitconfig}:
	ln -s ${WD}git${SEP}.gitconfig ${gitconfig}

${gitignore_global}:
	ln -s ${WD}git${SEP}.gitignore_global ${gitignore_global}

${raycast}:
	mkdir -p ${raycast}

${raycast_scripts}:
	ln -s ${WD}raycast${SEP}scripts ${raycast}

${tmux}:
	ln -s ${WD}tmux${SEP}.tmux.conf ${tmux}

${tmux_post}:
	ln -s ${WD}tmux${SEP}postprocessing ${tmux_post}

${kitty}:
	ln -s ${WD}kitty ${kitty}

${zshrc}:
	ln -s ${WD}zsh${SEP}.zshrc ${zshrc}

${starship}:
	ln -s ${WD}zsh${SEP}starship.toml ${starship}

${sketchybar}:
	ln -s ${WD}sketchybar ${sketchybar}

${svim}:
	ln -s ${WD}svim ${svim}

${borders}:
	ln -s ${WD}borders ${borders}

${fzf_git}:
	ln -s ${WD}zsh${SEP}fzf-git.sh ${fzf_git}

${zsh_aliases}:
	ln -s ${WD}zsh${SEP}aliases ${zsh_aliases}

${zsh_funcs}:
	ln -s ${WD}zsh${SEP}funcs ${zsh_funcs}

${zsh_scripts}:
	ln -s ${WD}zsh${SEP}scripts ${zsh_scripts}

${vscode}:
	mkdir -p ${vscode}

${vscode_styles}:
	ln -s ${WD}vscode${SEP}styles ${vscode_styles}

${skhd}:
	ln -s ${WD}skhd ${skhd}

${yabai}:
	ln -s ${WD}yabai ${yabai}

${yazi}:
	ln -s ${WD}yazi ${yazi}

${nu}:
	ln -s ${WD}nushell ${nu}

${aerospace}:
	ln -s ${WD}aerospace ${aerospace}

clean:
	unlink ${nvim}
	unlink ${gitconfig}
	unlink ${gitignore_global}
	unlink ${raycast_scripts}
	unlink ${tmux}
	unlink ${tmux_post}
	unlink ${kitty}
	unlink ${zshrc}
	unlink ${starship}
	unlink ${sketchybar}
	unlink ${svim}
	unlink ${borders}
	unlink ${fzf_git}
	unlink ${zsh_aliases}
	unlink ${zsh_funcs}
	unlink ${zsh_scripts}
	unlink ${vscode_styles}
	unlink ${skhd}
	unlink ${yabai}
	unlink ${yazi}
	unlink ${nu}
	unlink ${aerospace}
