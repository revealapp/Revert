#!/bin/bash -e

if [ -z "hash rbenv 2>/dev/null;" ]; then
  echo "--- 🚫  Stopping. rbenv not found!"
  exit 1
fi

eval "$(rbenv init -)"

if [ -z "$(rbenv versions | grep $(cat .ruby-version))" ]; then
  echo "--- 👩  Installing Ruby..."
  rbenv install
fi

if [ -z "$(gem list --local | grep bundler)" ]; then
  echo "--- 💎  Installing Bundler Gem..."
  gem install bundler
  rbenv rehash
fi

echo "--- 📦  Installing Bundle..."
bundle install --quiet
