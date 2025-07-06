#!/bin/bash

set -e

SOURCE_DIR="$(realpath ./helix)"
TARGET_DIR="$HOME/.config/helix"

## Check if target exists
if [ -L "$TARGET_DIR" ]; then
    ## It's a symlink
    CURRENT_TARGET="$(readlink -f "$TARGET_DIR")"
    if [ "$CURRENT_TARGET" = "$SOURCE_DIR" ]; then
        echo "Symlink already exists and points to $SOURCE_DIR. Nothing to do."
        exit 0
    else
        echo "Symlink exists but points to $CURRENT_TARGET. Updating to $SOURCE_DIR."
        rm "$TARGET_DIR"
    fi
elif [ -e "$TARGET_DIR" ]; then
    ## It's a file or directory (not a symlink)
    echo "$TARGET_DIR exists and is not a symlink. Moving to $TARGET_DIR.bak"
    mv "$TARGET_DIR" "$TARGET_DIR.bak"
fi

## Create parent directory if needed
mkdir -p "$(dirname "$TARGET_DIR")"

## Create the symlink
ln -s "$SOURCE_DIR" "$TARGET_DIR"
echo "Symlink created: $TARGET_DIR -> $SOURCE_DIR"
