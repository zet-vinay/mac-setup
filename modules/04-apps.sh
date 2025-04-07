#!/bin/bash

# === PHASE 4 — GUI Applications (Dev, Browsing, Productivity) ===

install_gui_apps() {
  log "🖥 Installing essential GUI applications via Homebrew Cask..."

  brew install --cask \
    visual-studio-code \
    android-studio \
    iterm2 \
    warp \
    google-chrome \
    arc \
    brave-browser \
    alt-tab \
    rectangle \
    cursor \
    raycast \
    notion \
    discord \
    postman \
    iphone-mirroring \
    image-playground

  log "✅ GUI apps installed."
}

restore_app_settings() {
  SETTINGS_DIR="$HOME/mac-setup-backup/app-settings"

  if [ ! -d "$SETTINGS_DIR" ]; then
    log "📁 No app settings found to restore. Skipping..."
    return
  fi

  log "♻️ Attempting to restore app preferences... (placeholder logic)"
  # Future expansion: cp preferences, load plist, etc.
}

# Run Phase 4
install_gui_apps
restore_app_settings
