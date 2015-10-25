#!/bin/bash -e

./Scripts/install-gems.sh

bundle exec fastlane build
