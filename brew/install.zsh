if ! command -v brew &> /dev/null; then
  if [[ `uname` == "Darwin" ]]; then
    echo "$PC[$SC*$PC] Homebrew not found, installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
fi
