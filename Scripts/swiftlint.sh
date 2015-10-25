#!/bin/bash

if hash swiftlint 2>/dev/null; then
  $(which swiftlint)
fi
