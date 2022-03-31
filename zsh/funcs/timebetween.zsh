zmodload zsh/datetime

function timebetween() {
  strftime -rs then_seconds '%Y-%m-%dT%H:%M:%S' "$1"
  difference=$(($EPOCHREALTIME - then_seconds))
  printf %.0f "$difference"
}

function currenttime {
  echo "$(date "+%Y-%m-%dT%H:%M:%S")"
}
