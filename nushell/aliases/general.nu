export alias v = nvim

export alias c = clear
export alias cls = clear
export alias ls = eza --icons always -F always
export alias lsa = ls -a
export alias l = ls -lah
export alias ll = ls -lh
export alias la = ls -lAh
export alias lsgi = ls --git-ignore
export alias lsi = ls -I

export alias cd = z

export def ramdp [] {
    cd ~/Library/LaunchAgents
    launchctl unload com.github.pepperlola.amdp.plist
    launchctl load com.github.pepperlola.amdp.plist
}
