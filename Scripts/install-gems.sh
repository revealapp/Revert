#!/bin/bash -e

if !bundle 2>/dev/null; then
  echo "\n 👮  'bundle' Not present. Exiting..." >&2 
fi

echo "📦  Installing Gems..."

bundle install --quiet

if [ $? -eq 0 ]; then
  echo "--- 👍  Gems Installed Successfully"
else
  echo "🚫  Gems Install Failed. Exiting. 😔 " >&2
fi
