#!/bin/bash

# === PHASE 2 — FLUTTER, ANDROID STUDIO, XCODE ===

install_flutter() {
  log "📦 Installing Flutter SDK..."
  FLUTTER_DIR="$HOME/development/flutter"
  mkdir -p "$HOME/development"

  if [ ! -d "$FLUTTER_DIR" ]; then
    git clone https://github.com/flutter/flutter.git -b stable "$FLUTTER_DIR"
    echo 'export PATH="$HOME/development/flutter/bin:$PATH"' >> "$HOME/.zshrc"
    source "$HOME/.zshrc"
  else
    log "📂 Flutter SDK already exists at $FLUTTER_DIR"
  fi
}

install_android_studio() {
  log "📦 Installing Android Studio via Homebrew..."
  brew install --cask android-studio
}

install_android_sdk() {
  log "📦 Installing Android SDK & command-line tools..."
  brew install --cask android-sdk

  ANDROID_SDK_ROOT="$HOME/Library/Android/sdk"
  export ANDROID_SDK_ROOT
  export PATH="$ANDROID_SDK_ROOT/platform-tools:$PATH"
  echo 'export ANDROID_SDK_ROOT="$HOME/Library/Android/sdk"' >> "$HOME/.zshrc"
  echo 'export PATH="$ANDROID_SDK_ROOT/platform-tools:$PATH"' >> "$HOME/.zshrc"

  yes | "$ANDROID_SDK_ROOT/tools/bin/sdkmanager" --licenses || true
}

accept_android_licenses() {
  log "📜 Accepting Android SDK licenses..."
  yes | flutter doctor --android-licenses || true
}

install_xcode() {
  log "📦 Installing Xcode Command Line Tools..."
  xcode-select --install 2>/dev/null || log "✅ Xcode tools already installed"
}

accept_xcode_license() {
  log "📜 Accepting Xcode license..."
  sudo xcodebuild -license accept
}

run_flutter_doctor() {
  log "🧪 Running flutter doctor..."
  flutter doctor -v
}
