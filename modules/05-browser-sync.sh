#!/bin/bash

# === PHASE 5 — Browser Bookmarks & Profile Restoration ===

restore_safari_bookmarks() {
  log "🍏 Restoring Safari bookmarks..."
  local src="${BACKUP_DIR}/bookmarks/Safari-Bookmarks.plist"
  local dest="${HOME}/Library/Safari/Bookmarks.plist"

  if [ -f "$src" ]; then
    cp "$src" "$dest"
    log "✅ Safari bookmarks restored."
    killall Safari &>/dev/null || true
  else
    log "⚠️ No Safari bookmarks found to restore. Skipping."
  fi
}

restore_brave_bookmarks() {
  log "🦁 Restoring Brave bookmarks..."
  local src="${BACKUP_DIR}/bookmarks/Brave-Bookmarks.json"
  local dest="${HOME}/Library/Application Support/BraveSoftware/Brave-Browser/Default/Bookmarks"

  if [ -f "$src" ]; then
    cp "$src" "$dest"
    log "✅ Brave bookmarks restored."
    killall "Brave Browser" &>/dev/null || true
  else
    log "⚠️ No Brave bookmarks found to restore. Skipping."
  fi
}

restore_arc_profile() {
  log "🌀 Attempting Arc profile restore (experimental)..."
  local src="${BACKUP_DIR}/bookmarks/Arc-Profile"
  local dest="${HOME}/Library/Application Support/Arc/User Data"

  if [ -d "$src" ]; then
    cp -R "$src" "$dest"
    log "✅ Arc profile copied (no guarantee it'll work, Daddy)."
    killall Arc &>/dev/null || true
  else
    log "⚠️ No Arc profile found to restore. Skipping."
  fi
}

# Ensure BACKUP_DIR is set
BACKUP_DIR="$HOME/mac-setup-backup"

restore_safari_bookmarks
restore_brave_bookmarks
restore_arc_profile
