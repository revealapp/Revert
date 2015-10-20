#!/bin/bash


./Scripts/fetch-dependencies.sh

SWIFTLINT=$(which swiftlint)

$SWIFTLINT
