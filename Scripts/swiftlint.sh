#!/usr/bin/env bash

# Only execute swiftlint if available
if [ ! -z "$(command -v swiftlint)" ]; then
  swiftlint
fi
