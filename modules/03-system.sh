# #!/bin/bash
# log() {
#   echo "[$(date '+%H:%M:%S')] $1"
# }

# # === PHASE 3 — System Settings + Terminal Enhancements ===

# configure_macos_defaults() {
#   log "🛠 Setting macOS system preferences..."

#   # Fast key repeat
#   defaults write NSGlobalDomain KeyRepeat -int 1
#   defaults write NSGlobalDomain InitialKeyRepeat -int 15

#   # Show all filename extensions in Finder
#   defaults write NSGlobalDomain AppleShowAllExtensions -bool true
#   defaults write com.apple.finder AppleShowAllFiles -bool true

#   # Show path bar in Finder
#   defaults write com.apple.finder ShowPathbar -bool true

#   # Expand save/print panels
#   defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
#   defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true

#   # Dock tweaks
#   defaults write com.apple.dock autohide-delay -float 0
#   defaults write com.apple.dock autohide-time-modifier -float 0.3
#   # defaults write com.apple.dock autohide -bool true
#   defaults write com.apple.dock tilesize -int 36

#   killall Dock
#   killall Finder
#   killall Finder &>/dev/null || true
#   killall Dock &>/dev/null || true
#    log "✅ Hardcoded macOS defaults applied."
# }

# install_terminal_stack() {
#   log "💻 Setting up terminal: zsh, Oh My Zsh, Powerlevel10k..."

#   # Install Oh My Zsh if not present
#   if [ ! -d "$HOME/.oh-my-zsh" ]; then
#     log "📦 Installing Oh My Zsh..."
#     RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
#   fi

#   # Powerlevel10k
#   if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
#     log "🎨 Installing Powerlevel10k theme..."
#     git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
#       "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
#   fi

#   # Plugins
#   mkdir -p "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins"
#   for plugin in zsh-autosuggestions zsh-syntax-highlighting; do
#     if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/$plugin" ]; then
#       log "🔌 Installing plugin: $plugin..."
#       git clone https://github.com/zsh-users/$plugin \
#         "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/$plugin"
#     fi
#   done

#   # Fonts
#   log "🔤 Installing Meslo Nerd Font..."
#   brew tap homebrew/cask-fonts
#   brew install --cask font-meslo-lg-nerd-font

#   log "✅ Terminal stack configured."
# }



# install_terminal_tools() {
#   log "🧩 Installing terminal power tools via Homebrew..."

#   brew install fzf bat htop z zsh-autosuggestions zsh-syntax-highlighting zsh-completions

#   # FZF setup
#   "$(brew --prefix)/opt/fzf/install" --key-bindings --completion --no-update-rc

#   # Add Z plugins to .zshrc if not already present
#   grep -q "zsh-autosuggestions" ~/.zshrc || echo "source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc
#   grep -q "zsh-syntax-highlighting" ~/.zshrc || echo "source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc
#   grep -q "zsh-completions" ~/.zshrc || echo "fpath+=('$(brew --prefix)/share/zsh-completions')" >> ~/.zshrc
#   grep -q "z.sh" ~/.zshrc || echo ". $(brew --prefix)/etc/profile.d/z.sh" >> ~/.zshrc

#   # Prettify bat as cat
#   grep -q "alias cat=" ~/.zshrc || echo "alias cat='bat'" >> ~/.zshrc
# }

# install_fonts_if_needed() {
#   log "🔤 Ensuring Meslo Nerd Font is installed..."

#   brew tap homebrew/cask-fonts
#   brew install --cask font-meslo-lg-nerd-font

#   log "✅ Terminal stack configured."
# }


# #!/bin/bash

# # import_system_settings() {
# #   SETTINGS_DIR="$DOTFILES_DIR/mac-setup-backup/system-settings"

# #   if [ ! -d "$SETTINGS_DIR" ]; then
# #     log "📁 No backup system settings found to import. Skipping..."
# #     return
# #   fi

# #   log "♻️ Importing system settings from $SETTINGS_DIR..."

# #   defaults import com.apple.dock "$SETTINGS_DIR/dock.plist"
# #   defaults import com.apple.finder "$SETTINGS_DIR/finder.plist"
# #   defaults import com.apple.systemuiserver "$SETTINGS_DIR/systemuiserver.plist"

# #   killall Dock Finder SystemUIServer
# # }

# import_saved_preferences() {
#   SETTINGS_DIR="$HOME/mac-setup-backup/system-settings"
#   BACKUP_FILE="$SETTINGS_DIR/defaults-full.txt"
#   if [ -f "$BACKUP_FILE" ]; then
#     log "📦 Importing saved macOS preferences..."
#     while IFS= read -r line; do
#       if [[ "$line" == defaults* ]]; then
#         eval "$line"
#       fi
#     done < "$BACKUP_FILE"
#     log "✅ macOS settings restored."
#   else
#     log "⚠️ No settings backup found — skipping."
#   fi
# }

# restore_zshrc() {
#   BACKUP_ZSHRC="$HOME/mac-setup-backup/terminal/.zshrc"
#   if [ -f "$BACKUP_ZSHRC" ]; then
#     log "📥 Restoring backed-up .zshrc config..."
#     cp "$BACKUP_ZSHRC" "$HOME/.zshrc"
#   else
#     log "⚠️ No .zshrc backup found — using Oh My Zsh default."
#   fi
# }

# configure_macos_defaults
# import_saved_preferences
# install_terminal_tools
# install_terminal_stack
# install_fonts_if_needed
# restore_zshrc



# Above is the complete old code for modules/03-system.sh

#!/bin/bash

# === PHASE 3 — System Settings + Terminal Enhancements ===

log() {
  echo "[$(date '+%H:%M:%S')] $1"
}

configure_macos_defaults() {
  log "🛠 Setting macOS system preferences..."

  # Fast key repeat
  defaults write NSGlobalDomain KeyRepeat -int 1
  defaults write NSGlobalDomain InitialKeyRepeat -int 15

  # Show all filename extensions in Finder
  defaults write NSGlobalDomain AppleShowAllExtensions -bool true
  defaults write com.apple.finder AppleShowAllFiles -bool true

  # Show path bar in Finder
  defaults write com.apple.finder ShowPathbar -bool true

  # Expand save/print panels
  defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
  defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true

  # Dock tweaks
  defaults write com.apple.dock autohide-delay -float 0
  defaults write com.apple.dock autohide-time-modifier -float 0.3
  defaults write com.apple.dock tilesize -int 36

  killall Dock Finder SystemUIServer &>/dev/null || true

  log "✅ Hardcoded macOS defaults applied."
}

install_terminal_stack() {
  log "💻 Setting up terminal: zsh, Oh My Zsh, Powerlevel10k..."

  # Install Oh My Zsh if not present
  if [ ! -d "$HOME/.oh-my-zsh" ]; then
    log "📦 Installing Oh My Zsh..."
    RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  fi

  # Powerlevel10k
  if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
    log "🎨 Installing Powerlevel10k theme..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
      "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
  fi

  # Plugins
  mkdir -p "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins"
  for plugin in zsh-autosuggestions zsh-syntax-highlighting; do
    if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/$plugin" ]; then
      log "🔌 Installing plugin: $plugin..."
      git clone https://github.com/zsh-users/$plugin \
        "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/$plugin"
    fi
  done

  # Fonts
  log "🔤 Installing Meslo Nerd Font..."
  brew tap homebrew/cask-fonts
  brew install --cask font-meslo-lg-nerd-font

  log "✅ Terminal stack configured."
}

install_terminal_tools() {
  log "🧩 Installing terminal power tools via Homebrew..."

  brew install fzf bat htop z zsh-autosuggestions zsh-syntax-highlighting zsh-completions eza ripgrep fd tldr tmux

  # FZF setup
  "$(brew --prefix)/opt/fzf/install" --key-bindings --completion --no-update-rc

  # Add plugins to .zshrc if not already present
  grep -q "zsh-autosuggestions" ~/.zshrc || echo "source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc
  grep -q "zsh-syntax-highlighting" ~/.zshrc || echo "source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc
  grep -q "zsh-completions" ~/.zshrc || echo "fpath+=('$(brew --prefix)/share/zsh-completions')" >> ~/.zshrc
  grep -q "z.sh" ~/.zshrc || echo ". $(brew --prefix)/etc/profile.d/z.sh" >> ~/.zshrc
  grep -q "alias cat=" ~/.zshrc || echo "alias cat='bat'" >> ~/.zshrc
}

install_fonts_if_needed() {
  log "🔤 Ensuring Meslo Nerd Font is installed..."
  brew tap homebrew/cask-fonts
  brew install --cask font-meslo-lg-nerd-font
  log "✅ Terminal fonts installed."
}

import_saved_preferences() {
  SETTINGS_DIR="$HOME/mac-setup-backup/system-settings"
  BACKUP_FILE="$SETTINGS_DIR/defaults-full.txt"
  if [ -f "$BACKUP_FILE" ]; then
    log "📦 Importing saved macOS preferences..."
    while IFS= read -r line; do
      if [[ "$line" == defaults* ]]; then
        eval "$line"
      fi
    done < "$BACKUP_FILE"
    echo "Restored on $(date)" >> ~/mac-setup-logs/system_restore.log
    log "✅ macOS settings restored."
  else
    log "⚠️ No settings backup found — skipping."
  fi
}

restore_zshrc() {
  BACKUP_ZSHRC="$HOME/mac-setup-backup/terminal/.zshrc"
  if [ -f "$BACKUP_ZSHRC" ]; then
    log "📥 Restoring backed-up .zshrc config..."
    cp "$BACKUP_ZSHRC" "$HOME/.zshrc"
  else
    log "⚠️ No .zshrc backup found — using Oh My Zsh default."
  fi
}

# === EXECUTION ===

configure_macos_defaults
import_saved_preferences
install_terminal_tools
install_terminal_stack
install_fonts_if_needed
restore_zshrc
