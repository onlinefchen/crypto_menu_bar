#!/bin/bash

# Create DMG for CryptoMenuBar
APP_NAME="CryptoMenuBar"
DMG_NAME="CryptoMenuBar-Installer.dmg"
VOLUME_NAME="CryptoMenuBar Installer"

# Remove old DMG if exists
rm -f "$DMG_NAME"

# Create temporary directory for DMG contents
TMP_DIR=$(mktemp -d)
cp -R "${APP_NAME}.app" "$TMP_DIR/"

# Create Applications symlink
ln -s /Applications "$TMP_DIR/Applications"

# Create DMG
hdiutil create -volname "$VOLUME_NAME" \
    -srcfolder "$TMP_DIR" \
    -ov -format UDZO \
    "$DMG_NAME"

# Cleanup
rm -rf "$TMP_DIR"

echo "Created $DMG_NAME successfully."
