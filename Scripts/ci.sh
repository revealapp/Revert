#!/usr/bin/env bash

# Load Testing Dependencies"
source "./Scripts/install-gems.sh"

# Build Revert
bundle exec fastlane build
