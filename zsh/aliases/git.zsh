alias gp="git push -u origin $(git rev-parse --abbrev-ref HEAD)"
alias gpl="git pull"
alias ga="git add $1"
alias gad="ga ."
alias gc="git commit -am $1"
alias gd="git diff"
alias gst="git status"
alias gr="git restore $1"
alias grs="gr --staged $1"
alias grd="gr ."
alias grds="grd ."

# git restore unity files I don't want to push
alias gru="git restore *.csproj engine.sln UserSettings/EditorUserSettings.asset"
