zmodload zsh/zprof
export EDITOR='nvim'

export HOMEBREW_PREFIX=/opt/homebrew
path=($HOMEBREW_PREFIX/bin $HOMEBREW_PREFIX/sbin $path)
path+=(
    $HOMEBREW_PREFIX/opt/llvm/bin
    $HOMEBREW_PREFIX/opt/binutils/bin
    $HOME/Desktop/Misc/Scripts
    $HOME/.cargo/bin
    $HOME/.bun/bin
    /usr/local/texlive/2026/bin/universal-darwin
)
fpath=($HOMEBREW_PREFIX/share/zsh/site-functions $fpath)

ZINIT_HOME="/opt/homebrew/opt/zinit"
# TODO: automatic install?
source "$ZINIT_HOME/zinit.zsh"

ZVM_INIT_MODE=sourcing
zinit ice depth=1
zinit light jeffreytse/zsh-vi-mode

zinit ice id-as"starship" atclone"starship init zsh --print-full-init > init.zsh" \
    atpull"%atclone" run-atpull src"init.zsh"
zinit light zdharma-continuum/null

eval "$(fnm env --use-on-cd --shell zsh)"

ZSH_AUTOSUGGEST_STRATEGY=(history completion)

zinit wait lucid light-mode for \
    id-as"generated" \
    atclone'
        zoxide init zsh > zoxide.zsh
        fzf --zsh > fzf.zsh
        vivid generate tokyonight-storm > ls_colors
        glow completion zsh > _glow
        poetry completions zsh > _poetry
        rustup completions zsh > _rustup
        rustup completions zsh cargo > _cargo
        fnm completions --shell zsh > _fnm
    ' atpull'%atclone' run-atpull \
        atinit'fpath+=($PWD)' \
        multisrc'zoxide.zsh fzf.zsh' \
        atload'export LS_COLORS="$(<ls_colors)"; zstyle ":completion:*" list-colors ${(s.:.)LS_COLORS}' \
        zdharma-continuum/null \
        atinit'zicompinit; zicdreplay; _comp_options+=(globdots)' \
        Aloxaf/fzf-tab \
        atload'_zsh_autosuggest_start' \
        zsh-users/zsh-autosuggestions \
        zdharma-continuum/fast-syntax-highlighting

zstyle ':completion:*' menu no
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':fzf-tab:complete:(cd|z|__zoxide_z):*' fzf-preview 'eza -1 --icons always --color=always $realpath'

### Aliases ###

## General ##
alias v="nvim"
alias c="clear"
alias cls="clear"
alias core-ls="ls"
alias ls="eza --icons always -F always"
alias lsa="ls -a"
alias l="ls -lah"
alias ll="ls -lh"
alias la="ls -lAh"
alias lsgi="ls --git-ignore"
alias lsi="ls -I"

alias cd="z"
alias lsusb="system_profiler SPUSBDataType"

## Git ##
alias g="git"
alias ga="git add"
alias gb="git branch"
alias gd="git diff"
alias gf="git fetch"
alias gco="git checkout"
alias gst="git status"
alias glg="git log --decorate --graph --all --stat"
alias gcsm="git commit --gpg-sign --message"
alias gc="gcsm"
alias gusm="git submodule update --recursive --remote --merge"

git_current_branch () {
    REF="$(git symbolic-ref --quiet HEAD)"
    echo "${REF[12,-1]}"
}

gca () {
    ENDPOINT="users/$1"
    USER_DATA="$(gh api $ENDPOINT)"
    NAME="$(echo $USER_DATA | jq -r '.name // .login')"
    LOGIN="$(echo $USER_DATA | jq -r '.login')"
    ID="$(echo $USER_DATA | jq -r '.id')"
    EMAIL="$ID+$LOGIN@users.noreply.github.com"
    echo "Co-authored-by: $NAME <$EMAIL>"
}

ggpush () {
    git push origin $(git_current_branch)
}

ggpull () {
    git pull origin $(git_current_branch)
}

## Rust ##
alias cr="RUST_BACKTRACE=1 cargo run"
alias ct="cargo test"

## Orbit ##
find_platform () {
    if [[ -n $1 ]]; then
        echo "$1"
    elif [[ -n "$(lsusb | rg FT230X)" ]]; then
        echo "alea-v4"
    else
        echo "launchpad"
    fi
}

get_root () {
    git rev-parse --show-toplevel
}

get_mount_root () {
    COMMON="$(git rev-parse --path-format=absolute --git-common-dir)"
    if [[ "${COMMON:t}" == ".git" ]]; then
        get_root
    else
        echo "${COMMON:h}"
    fi
}

is_aleasat () {
    if [[ -n $1 ]] && [[ "${1:t}" == "aleasat-software" ]]; then
        return 0
    fi

    return 1
}

fw_docker_build () {
    GIT_ROOT="$(get_root)"
    MOUNT="$(get_mount_root)"
    REL="${GIT_ROOT#$MOUNT/}"
    WORKDIR="$([[ -n $REL ]] && echo "/usr/local/src/repo/${REL}" || echo '/usr/local/src/repo')"

    docker run --rm -i --platform linux/amd64 \
        -e "HOST_UID=($(id -u))" \
        -e "HOST_GID=($(id -g))" \
        -e GIT_CONFIG_COUNT=1 \
        -e GIT_CONFIG_KEY_0=safe.directory \
        -e "GIT_CONFIG_VALUE_0=*" \
        -v "${mount}:/usr/local/src/repo:z" \
        -v "${mount}:${mount}:z" \
        --workdir "$WORKDIR" \
        alea-obc-fw-build:latest \
        ./tools/docker/docker_user.sh ./alea-fsw/obc-fw/scripts/fw_build.sh $@
}

flash () {
    local target="ext"
    local flash_slot="A"
    local erase_all=0
    local -a opt_target opt_slot opt_erase

    zparseopts -D -E -F -- \
        -target:=opt_target \
        -flash-slot:=opt_slot \
        -erase-all=opt_erase || return 1

    (( ${#opt_target} )) && target="${opt_target[-1]#=}"
    (( ${#opt_slot} ))   && flash_slot="${opt_slot[-1]#=}"
    (( ${#opt_erase} ))  && erase_all=1

    local platform_arg="$1"

    local git_root
    git_root="$(get_root)"
    if ! is_aleasat "$(get_mount_root)"; then
        print -u2 "Cannot run this command from outside of the aleasat-software repository."
        return 1
    fi

    local p
    p="$(find_platform "$platform_arg")"

    local -a target_opts=(startup boot core ext)
    local -a flash_slot_opts=(A B)

    if (( ! ${target_opts[(Ie)$target]} )); then
        print -u2 "Target must be one of [startup, boot, core, ext]."
        return 1
    fi
    if (( ! ${flash_slot_opts[(Ie)$flash_slot]} )); then
        print -u2 "Flash slot must be one of [A, B]."
        return 1
    fi

    print "PLATFORM: $p"
    print "TARGET: $target"
    print "FLASH SLOT: $flash_slot"

    local fw_path="$git_root/alea-fsw/obc-fw"
    local config_path="$fw_path/tools/debug/ccs/$p.ccxml"
    local build_path="$fw_path/build/$p/$target/$flash_slot/ALEA_OBC.elf"

    local erase_selection=1
    (( erase_all )) && erase_selection=0

    dslite --verbose --flash --run \
        "--config=\"$config_path\"" \
        --setting "FlashEraseSelection=$erase_selection" \
        "\"$build_path\""
}

flash_ota_stack () {
    local -a opt_c
    zparseopts -D -E -F -- c=opt_c -comms-over-serial=opt_c || return 1

    local platform_arg="$1"

    local git_root
    git_root="$(get_root)"
    if ! is_aleasat "$(get_mount_root)"; then
        print -u2 "Cannot run this command from outside of the aleasat-software repository."
        return 1
    fi

    local p
    p="$(find_platform "$platform_arg")"

    print "PLATFORM: $p"

    local fw_path="$git_root/alea-fsw/obc-fw"

    # target:slot
    local -a images=(startup:A boot:A boot:B ext:A ext:B)

    local -a extra_args=()
    (( ${#opt_c} )) && extra_args=(-c)

    local image img_target img_slot
    for image in "${images[@]}"; do
        img_target="${image%%:*}"
        img_slot="${image##*:}"
        fw_docker_build "$p" "$img_target" "$img_slot" "${extra_args[@]}" || return 1
    done

    local config_path="$fw_path/tools/debug/ccs/$p.ccxml"

    local -a quoted_elf_paths=()
    for image in "${images[@]}"; do
        img_target="${image%%:*}"
        img_slot="${image##*:}"
        quoted_elf_paths+=("\"$fw_path/build/$p/$img_target/$img_slot/ALEA_OBC.elf\"")
    done

    dslite --verbose --flash --run \
        "--config=\"$config_path\"" \
        --setting FlashEraseSelection=1 \
        "${quoted_elf_paths[@]}"
}

build () {
    local target="ext"
    local flash_slot="A"
    local -a opt_target opt_slot opt_c opt_s

    zparseopts -D -E -F -- \
        -target:=opt_target \
        -flash-slot:=opt_slot \
        c=opt_c -comms-over-serial=opt_c \
        s=opt_s -standalone=opt_s || return 1

    (( ${#opt_target} )) && target="${opt_target[-1]#=}"
    (( ${#opt_slot} ))   && flash_slot="${opt_slot[-1]#=}"

    local comms_over_serial=false standalone=false
    (( ${#opt_c} )) && comms_over_serial=true
    (( ${#opt_s} )) && standalone=true

    local platform_arg="$1"

    local git_root
    git_root="$(get_root)"
    if ! is_aleasat "$(get_mount_root)"; then
        print -u2 "Cannot run this command from outside of the aleasat-software repository."
        return 1
    fi

    local p
    p="$(find_platform "$platform_arg")"

    local -a target_opts=(startup boot core ext)
    local -a flash_slot_opts=(A B)

    if (( ! ${target_opts[(Ie)$target]} )); then
        print -u2 "Target must be one of [startup, boot, core, ext]."
        return 1
    fi
    if (( ! ${flash_slot_opts[(Ie)$flash_slot]} )); then
        print -u2 "Flash slot must be one of [A, B]."
        return 1
    fi

    print "PLATFORM: $p"
    print "TARGET: $target"
    print "FLASH SLOT: $flash_slot"
    print "COMMS OVER SERIAL: $comms_over_serial"
    print "STANDALONE: $standalone"

    local -a extra_args=()
    [[ $comms_over_serial == true ]] && extra_args+=(-c)
    [[ $standalone == true ]] && extra_args+=(-s)

    fw_docker_build "$p" "$target" "$flash_slot" "${extra_args[@]}"
}

export PATH
zprof | pbcopy
