#/bin/bash

function installBrewBinary () {
  echo " 👮  Checking '$1' is installed... \c"
  if ! hash $1 2>/dev/null; then
    echo " 👮  Installing '$1'..."
    brew install $1
  else
    echo " 👍 "
  fi
}

installBrewBinary swiftlint
