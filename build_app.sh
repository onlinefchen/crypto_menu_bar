#!/bin/bash

# Build the project
swift build -c release

# Create App Bundle Structure
APP_NAME="CryptoMenuBar.app"
mkdir -p "$APP_NAME/Contents/MacOS"
mkdir -p "$APP_NAME/Contents/Resources"

# Copy Binary
cp .build/release/CryptoMenuBar "$APP_NAME/Contents/MacOS/"

# Copy Info.plist
cp Info.plist "$APP_NAME/Contents/"

echo "Built $APP_NAME successfully."
