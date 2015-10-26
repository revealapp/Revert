#!/bin/bash -e

source ./Scripts/install-gems.sh

bundle exec fastlane build
