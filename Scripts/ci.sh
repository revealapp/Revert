#!/usr/bin/env bash

set -eu
set -o pipefail 

export NSUnbufferedIO=YES

xcodebuild -configuration Debug -scheme Revert -destination "platform=iOS Simulator,OS=14.0,name=iPhone 11" ENABLE_TESTABILITY=YES build
xcodebuild -configuration Debug -scheme Revert-tvOS -destination "platform=tvOS Simulator,OS=14.0,name=Apple TV" ENABLE_TESTABILITY=YES build
