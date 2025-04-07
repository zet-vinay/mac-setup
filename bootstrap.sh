#!/bin/bash

CHECKPOINT_FILE=".mac-setup-checkpoints"
LOG_FILE="logs/bootstrap.log"
MODULE_DIR="modules"

# Create logs dir if missing
mkdir -p logs

# Create checkpoint file if missing
if [ ! -f "$CHECKPOINT_FILE" ]; then
  echo "📝 Creating checkpoint file at $CHECKPOINT_FILE"
  touch "$CHECKPOINT_FILE"
fi

log() {
  echo "$1" | tee -a "$LOG_FILE"
}

run_if_not_done() {
  local checkpoint="$1"
  local func="$2"

  if grep -q "$checkpoint" "$CHECKPOINT_FILE"; then
    log "⏩ Skipping '$checkpoint' — already completed."
  else
    log "🚀 Running $func..."
    $func
    if [ $? -eq 0 ]; then
      echo "$checkpoint" >> "$CHECKPOINT_FILE"
      log "✅ Completed $checkpoint"
    else
      log "❌ $func failed. Exiting..."
      exit 1
    fi
  fi
}

log "🧠 Starting Mac setup automation..."

# === Phase 1: Core Tools & Environment ===
source "$MODULE_DIR/01-core.sh"
run_if_not_done "homebrew_installed" install_homebrew
run_if_not_done "warp_installed" install_warp
run_if_not_done "ohmyzsh_installed" setup_ohmyzsh
run_if_not_done "zsh_plugins_installed" install_zsh_plugins
run_if_not_done "directory_structure_created" create_directory_structure
run_if_not_done "vscode_installed" install_vscode
run_if_not_done "vscode_extensions_installed" install_vscode_extensions
run_if_not_done "git_ssh_configured" setup_git_ssh

log "📦 Phase 1 complete. Dev tools & shell ready."

# === Phase 2: SDKs for Flutter + Mobile Dev ===
source "$MODULE_DIR/02-sdk.sh"
run_if_not_done "flutter_installed" install_flutter
run_if_not_done "android_studio_installed" install_android_studio
run_if_not_done "android_sdk_installed" install_android_sdk
run_if_not_done "android_licenses_accepted" accept_android_licenses
run_if_not_done "xcode_installed" install_xcode
run_if_not_done "xcode_licenses_accepted" accept_xcode_license
run_if_not_done "flutter_doctor_ran" run_flutter_doctor

log "📦 Phase 2 complete. SDKs installed & verified."

# === Phase 3: System Settings + Terminal Enhancements ===
source "$MODULE_DIR/03-system.sh"
run_if_not_done "macos_defaults_configured" configure_macos_defaults
run_if_not_done "imported_saved_preferences" import_saved_preferences
run_if_not_done "terminal_tools_installed" install_terminal_tools
run_if_not_done "terminal_stack_configured" install_terminal_stack
run_if_not_done "meslo_font_installed" install_fonts_if_needed
run_if_not_done "zshrc_restored" restore_zshrc

log "📦 Phase 3 complete. macOS system + terminal configured."

log "✅ All setup phases completed successfully. Go build some magic. 🚀"


# Phase 4: GUI Applications
source "$MODULE_DIR/04-apps.sh"
run_if_not_done "gui_apps_installed" install_gui_apps
run_if_not_done "gui_app_settings_restored" restore_app_settings

log "🏁 Phase 4 completed. GUI apps and preferences are now installed."
log "🚀 Continue to Phase 5: Cloud services, Node.js, GitHub CLI, and extras..."