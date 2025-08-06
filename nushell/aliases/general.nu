export alias v = nvim

export alias c = clear
export alias cls = clear
export alias core-ls = ls
export alias ls = eza --icons always -F always
export alias lsa = ls -a
export alias l = ls -lah
export alias ll = ls -lh
export alias la = ls -lAh
export alias lsgi = ls --git-ignore
export alias lsi = ls -I

export alias cd = z

export alias lsusb = system_profiler SPUSBDataType

export def ramdp [] {
    cd ~/Library/LaunchAgents
    launchctl unload com.github.pepperlola.amdp.plist
    launchctl load com.github.pepperlola.amdp.plist
}

export def gen_bytes [
    count: number
    path: path
    --no-null (-n)
] {
    1..($count * 2) | each {|it| $it mod 256 } | where {|x| $x != 0} | take $count | into binary -c | bytes collect | save -f --raw $path
}

export def nvrg [search: string] {
    let matches = ["[", (rg --json $"($search)" | jq -rc 'select(.type == "match") | "\(.data.path.text) \(.data.line_number)"' | awk '{ printf "{\"filename\": \"%s\", \"lnum\": \"%s\"},", $1, $2 }'), "]"] | str join | from json
    let files = ($matches | get filename)
    nvim -c $"call setqflist\(($matches | to json -r)\)" -c "copen" $"($files | str join)"
}

export def nvtodo [] {
    nvrg "TODO"
}

export def nvgc [] {
    nvrg <<<<
}
