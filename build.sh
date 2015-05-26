#/usr/bin/env bash

set -e # Stop script at first error

# Binaries

XCRUN=$(which xcrun)
XCPRETTY=$(which xcpretty)
RM=$(which rm)

# Project / Folders

DERIVED_DATA_FOLDER=./DerivedData
PROJECT_FILE=./Revert.xcodeproj
SCHEME=Revert

# Script

echo 'Cleaning Devived Data Folder...'

$RM -rf $DERIVED_DATA_FOLDER

echo 'Building Project...'

BUILD_CMD="$XCRUN xcodebuild -project $PROJECT_FILE -scheme $SCHEME -sdk iphonesimulator clean build -derivedDataPath $DERIVED_DATA_FOLDER"

if [ -x $XCPRETTY ]; then
  $BUILD_CMD | $XCPRETTY -c && exit ${PIPESTATUS[0]}
else
  $BUILD_CMD
fi
