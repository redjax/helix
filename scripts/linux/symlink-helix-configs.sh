#!/bin/bash

set -e

CONFIG_NAME="${1:-default}"
SOURCE_DIR="$(realpath "configs/$CONFIG_NAME")"
TARGET_DIR="$HOME/.config/helix"

## Check that user's config choice exists
if [ ! -d "$SOURCE_DIR" ]; then
  echo "Config directory '$SOURCE_DIR' does not exist."
  exit 1
fi

## Check for existing link/directory
if [ -L "$TARGET_DIR" ]; then
  CURRENT_TARGET="$(readlink -f "$TARGET_DIR")"
  if [ "$CURRENT_TARGET" = "$SOURCE_DIR" ]; then
    echo "Symlink already exists and points to $SOURCE_DIR. Nothing to do."
    exit 0
  else
    echo "Symlink exists but points to $CURRENT_TARGET. Updating to $SOURCE_DIR."
    rm "$TARGET_DIR"
  fi
elif [ -e "$TARGET_DIR" ]; then
  echo "$TARGET_DIR exists and is not a symlink. Moving to $TARGET_DIR.bak"
  mv "$TARGET_DIR" "$TARGET_DIR.bak"
fi

## Create symlink
mkdir -p "$(dirname "$TARGET_DIR")"
ln -s "$SOURCE_DIR" "$TARGET_DIR"

if [[ $? -ne 0 ]]; then
  echo "Failed to create symlink."
  exit $?
else
  echo "Symlink created: $SOURCE_DIR -> $TARGET_DIR"
  exit 0
fi
