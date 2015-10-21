#/usr/bin/env bash

# Project / Folders
DERIVED_DATA_FOLDER=DerivedData
PROJECT_FILE=Revert.xcodeproj
SCHEME=Revert

# Script

echo 'Cleaning Devived Data Folder...'

rm -rf "$DERIVED_DATA_FOLDER"
mkdir "$DERIVED_DATA_FOLDER"

BUILD_CMD="xcrun xcodebuild -project $PROJECT_FILE -scheme $SCHEME -sdk iphonesimulator clean build -derivedDataPath $DERIVED_DATA_FOLDER"

if hash xcpretty 2>/dev/null; then
  $BUILD_CMD | tee "$DERIVED_DATA_FOLDER/build.log" | xcpretty -c && exit ${PIPESTATUS[0]}
else
  $BUILD_CMD
fi
