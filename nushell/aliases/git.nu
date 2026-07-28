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

# git commit sign message
export alias gcsm = git commit --gpg-sign --message
export alias gc = gcsm

# git update submodules
export alias gusm = git submodule update --recursive --remote --merge

# git edit merge conflicts
export def gemc [] {
    let conflicting_files = git status | rg "both modified: +(\\S+)$" -r "$1" | split row "\n" | each {str trim}
    # TODO: do something with these files
}

# git coauthor
export def gca [user: string] {
    let entry = (gh api $"users/($user)" | from json)
    let name = ($entry.name? | default $entry.login)
    let email = $"($entry.id)+($entry.login)@users.noreply.github.com"
    return $"Co-authored-by: ($name) <($email)>"
}

# git clean worktrees
export def gcwt [] {
    let paths = (
        git worktree list --porcelain
        | lines
        | where $it =~ '^worktree '
        | parse "worktree {path}"
        | get path
        | path parse
        | where $it.stem !~ '^\.'
    )

    $paths | each { |p|
        let full_path = ($p | path join)

        let is_merged = do {
            cd $full_path

            try {
                let pr_state = (gh pr view --json state | from json | get state)
                $pr_state == "MERGED"
            } catch {
                false
            }
        }

        if $is_merged {
            print $"(ansi yellow_bold)Found merged worktree:(ansi reset) ($p.stem) at ($full_path)"
            let response = (input "Remove this worktree? [y/N]: ")

            if ($response | str downcase | str trim) == "y" {
                try {
                    print $"Attempting standard removal of ($p.stem)..."
                    git worktree remove $full_path
                    print $"(ansi green)Successfully removed ($p.stem).(ansi reset)"
                } catch {
                    print $"(ansi red_bold)Standard removal failed.(ansi reset) Worktree may contain submodules or uncommitted changes."
                    let force_response = (input "Force removal of this worktree with '-f'? [y/N]: ")

                    if ($force_response | str downcase | str trim) == "y" {
                        try {
                            git worktree remove -f $full_path
                            print $"(ansi green)Successfully force-removed ($p.stem).(ansi reset)"
                        } catch { |err|
                            print $"(ansi red_bold)Error: Force removal also failed.(ansi reset) ($err.msg)"
                        }
                    } else {
                        print "Skipping force removal."
                    }
                }
            } else {
                print "Skipped"
            }
        }
    }
}
