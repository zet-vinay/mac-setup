#!/bin/bash
set -e

mkdir -p logs
CHECKPOINT_FILE="$HOME/.mac-setup-checkpoints"
touch "$CHECKPOINT_FILE"

log() {
  echo "[🛠️  $(date +'%T')] $1" | tee -a logs/bootstrap.log
}

run_if_not_done() {
  local step="$1"
  shift
  if grep -q "$step" "$CHECKPOINT_FILE"; then
    log "✅ $step already completed. Skipping..."
  else
    log "🚀 Starting $step..."
    "$@" && echo "$step" >> "$CHECKPOINT_FILE"
    log "✅ $step completed."
  fi
}

# Load core setup module
source modules/01-core.sh

# Run core setup
run_if_not_done "core_setup" core_setup
