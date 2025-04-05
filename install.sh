#!/bin/bash

REPO_URL="https://github.com/zet-vinay/mac-setup.git"
TARGET_DIR="$HOME/mac-setup"

echo "📦 Cloning setup repo into $TARGET_DIR..."
git clone "$REPO_URL" "$TARGET_DIR"

cd "$TARGET_DIR"

echo "🔐 Making bootstrap.sh executable..."
chmod +x bootstrap.sh

echo "🚀 Running bootstrap.sh..."
./bootstrap.sh