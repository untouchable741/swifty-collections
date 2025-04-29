#!/bin/bash

set -e

# Config
SCHEME="SwiftyCollections"
BUILD_DIR="./build"

echo "🔄 Cleaning previous build artifacts..."
rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR"

########################
# 1. Archive for iOS
########################
echo "📱 Archiving for iOS device..."
xcodebuild archive \
  -scheme "$SCHEME" \
  -configuration Release \
  -destination "generic/platform=iOS" \
  -archivePath "$BUILD_DIR/${SCHEME}-iOS.xcarchive" \
  SKIP_INSTALL=NO \
  BUILD_LIBRARY_FOR_DISTRIBUTION=YES

########################
# 2. Archive for iOS Simulator
########################
echo "🖥️ Archiving for iOS Simulator..."
xcodebuild archive \
  -scheme "$SCHEME" \
  -configuration Release \
  -destination "generic/platform=iOS Simulator" \
  -archivePath "$BUILD_DIR/${SCHEME}-Simulator.xcarchive" \
  SKIP_INSTALL=NO \
  BUILD_LIBRARY_FOR_DISTRIBUTION=YES

########################
# 3. Create .a from .o files
########################
echo "📦 Creating .a static libraries from .o files..."

# iOS device .a
DEVICE_OBJECTS=$(find "$BUILD_DIR/${SCHEME}-iOS.xcarchive" -name '*.o')
libtool -static -o "$BUILD_DIR/${SCHEME}-iOS.a" $DEVICE_OBJECTS

# Simulator .a
SIM_OBJECTS=$(find "$BUILD_DIR/${SCHEME}-Simulator.xcarchive" -name '*.o')
libtool -static -o "$BUILD_DIR/${SCHEME}-Simulator.a" $SIM_OBJECTS

########################
# 4. Create xcframework
########################
echo "🧱 Creating .xcframework..."

xcodebuild -create-xcframework \
  -library "$BUILD_DIR/${SCHEME}-iOS.a" \
  -library "$BUILD_DIR/${SCHEME}-Simulator.a" \
  -output "$BUILD_DIR/${SCHEME}.xcframework"

echo "✅ Done! XCFramework is ready at:"
echo "$BUILD_DIR/${SCHEME}.xcframework"