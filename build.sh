#/usr/bin/env bash

# Binaries

XCRUN=$(which xcrun)
XCPRETTY=$(which xcpretty)
MKDIR=$(which mkdir)
RM=$(which rm)

# Project / Folders

DERIVED_DATA_FOLDER=DerivedData
PROJECT_FILE=Revert.xcodeproj
SCHEME=Revert

# Script

echo 'Cleaning Devived Data Folder...'

$RM -rf "$DERIVED_DATA_FOLDER"
$MKDIR "$DERIVED_DATA_FOLDER"

BUILD_CMD="$XCRUN xcodebuild -project $PROJECT_FILE -scheme $SCHEME -sdk iphonesimulator clean build -derivedDataPath $DERIVED_DATA_FOLDER"

if [ -x $XCPRETTY ]; then
  $BUILD_CMD | tee "$DERIVED_DATA_FOLDER/build.log" | $XCPRETTY -c && exit ${PIPESTATUS[0]}
else
  $BUILD_CMD
fi
