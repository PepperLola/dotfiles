alias gp="git push -u origin $(git rev-parse --abbrev-ref HEAD)"
alias gpl="git pull"
alias ga="git add ."
alias gc="git commit -am $1"
alias gd="git diff"

# git restore unity files I don't want to push
alias gru="git restore *.csproj engine.sln UserSettings/EditorUserSettings.asset"
