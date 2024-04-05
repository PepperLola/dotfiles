ifeq ($(OS),Windows_NT)
	ROOT:=C:\
	CONFIG_PATH:=%APPDATA%\\Local
	SEPARATOR:=\\
else
	UNAME_S := $(shell uname -s)
	ifeq ($(UNAME_S),Darwin)
		CONFIG_PATH:=~/.config
		SEPARATOR:=/
		ROOT:=~
	endif
endif

WD:=$(shell pwd)

nvim:=${CONFIG_PATH}${SEPARATOR}nvim
gitconfig:=${ROOT}${SEPARATOR}.gitconfig
gitignore_global:=${ROOT}${SEPARATOR}.gitignore_global
raycast:=${CONFIG_PATH}${SEPARATOR}raycast
raycast_scripts:=${raycast}${SEPARATOR}scripts
tmux:=${ROOT}${SEPARATOR}.tmux.conf
zshrc:=${ROOT}${SEPARATOR}.zshrc
zsh_aliases:=${ROOT}${SEPARATOR}aliases
zsh_funcs:=${ROOT}${SEPARATOR}funcs
zsh_scripts:=${ROOT}${SEPARATOR}scripts

all: ${nvim} ${gitconfig} ${gitignore_global} ${raycast} ${raycast_scripts} ${tmux} ${zshrc} ${zsh_aliases} ${zsh_funcs} ${zsh_scripts}

${nvim}:
	ln -s ${WD}${SEPARATOR}nvim ${nvim}

${gitconfig}:
	ln -s ${WD}${SEPARATOR}git${SEPARATOR}.gitconfig ${gitconfig}

${gitignore_global}:
	ln -s ${WD}${SEPARATOR}git${SEPARATOR}.gitignore_global ${gitignore_global}

${raycast}:
	mkdir -p ${raycast}

${raycast_scripts}:
	ln -s ${WD}${SEPARATOR}raycast${SEPARATOR}scripts ${raycast}

${tmux}:
	ln -s ${WD}${SEPARATOR}tmux${SEPARATOR}.tmux.conf ${tmux}

${zshrc}:
	ln -s ${WD}${SEPARATOR}zsh${SEPARATOR}.zshrc ${zshrc}

${zsh_aliases}:
	ln -s ${WD}${SEPARATOR}zsh${SEPARATOR}aliases ${zsh_aliases}

${zsh_funcs}:
	ln -s ${WD}${SEPARATOR}zsh${SEPARATOR}funcs ${zsh_funcs}

${zsh_scripts}:
	ln -s ${WD}${SEPARATOR}zsh${SEPARATOR}scripts ${zsh_scripts}

clean:
	unlink ${nvim}
	unlink ${gitconfig}
	unlink ${gitignore_global}
	unlink ${raycast}${SEPARATOR}scripts
	unlink ${tmux}
	unlink ${zshrc}
	unlink ${zsh_aliases}
	unlink ${zsh_funcs}
	unlink ${zsh_scripts}
