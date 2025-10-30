#!/usr/bin/env bash
set -euo pipefail

FIRMWARE="$1"

if [[ ! -f "$FIRMWARE" ]]; then
  echo "❌ Firmware file not found: $FIRMWARE"
  exit 1
fi

# Ask for sudo upfront
sudo -v
# Keep-alive: update existing sudo timestamp until script finishes
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

declare -A LABELS=( ["left"]="GLV80LHBOOT" ["right"]="GLV80RHBOOT" )
declare -A MOUNTPOINTS=( ["left"]="/mnt/kb_left" ["right"]="/mnt/kb_right" )

flash_half() {
  local side="$1"
  local label="${LABELS[$side]}"
  local mount_point="${MOUNTPOINTS[$side]}"

  echo ""
  echo "⚙️  Waiting for $side half ($label) to appear in bootloader mode..."

  # Wait until device with correct label appears
  while true; do
    DEV=$(lsblk -o NAME,LABEL,PATH -nr | awk -v lbl="$label" '$2 == lbl {print $3}' || true)
    if [[ -n "$DEV" ]]; then
      echo "✅ Found $side half at $DEV"
      break
    fi
    sleep 1
  done

  sudo mkdir -p "$mount_point"
  echo "📦 Mounting $DEV to $mount_point..."
  sudo mount "$DEV" "$mount_point"

  echo "📤 Copying firmware..."
  sudo cp "$FIRMWARE" "$mount_point"/
  sync

  echo "💾 Unmounting..."
  sudo umount "$mount_point"

  echo "✅ $side half flashed successfully!"
}

flash_half "left"
flash_half "right"

echo ""
echo "🎉 Both halves flashed successfully!"
