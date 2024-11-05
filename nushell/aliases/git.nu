def git_current_branch [] {
    let ref = git symbolic-ref --quiet HEAD
    $ref | str substring 11..
}
export alias g = git
export alias ga = git add
export alias gb = git branch
export alias gd = git diff
export alias gf = git fetch
export alias gco = git checkout
export alias gst = git status
export alias glg = git log --decorate --graph --all --stat

export def ggpush [] {
    let branch = git_current_branch
    git push origin $branch
}

export def ggpull [] {
    let branch = git_current_branch
    git pull origin $branch
}

export alias gcsm = git commit --gpg-sign --message
export alias gc = gcsm

export alias gusm = git sugmodule update --recursive --remote --merge

export def gemc [] {
    # TODO: git edit merge conflict
}
