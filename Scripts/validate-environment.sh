#/bin/bash

function checkPresenceOf () {
  echo " 👮  Checking '$1' is installed... \c"
  if ! hash $1 2>/dev/null; then
    echo "\n 👮  '$1' Not present. Exiting..." >&2 
  else
    echo " 👍 "
  fi
}

checkPresenceOf swiftlint
