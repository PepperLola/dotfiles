alias gcsm="git commit --gpg-sign --message"
alias gc="gcsm"

# git restore unity files I don't want to push
alias gru="git restore *.csproj engine.sln UserSettings/EditorUserSettings.asset"
function gemc() {
  files="$(git status | rg -o 'both modified: *(.*)$' -or '$1')" && qflist=$(xargs -I{} rg --with-filename --line-number --no-heading "<{4,}" "{}" <<< "$files" | awk -F: '{ printf "{\"filename\": \"%s\", \"lnum\": \"%s\"},", $1, $2, $3 }' | sed -E 's/.$//g' | awk '{ print "call setqflist([" $0 "])" }') && nvim -c "$qflist" -c "copen" "$files"
}
