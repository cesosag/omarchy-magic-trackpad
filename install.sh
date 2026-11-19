#!/usr/bin/env bash
# Install Mac-like trackpad gestures into an Omarchy user config.
set -euo pipefail

root="$(cd "$(dirname "$0")" && pwd)"
hypr_input_src="$root/config/hypr/input.lua"
script_src="$root/scripts/apps-grid"

hypr_input_dst="${XDG_CONFIG_HOME:-$HOME/.config}/hypr/input.lua"
script_dst="${XDG_CONFIG_HOME:-$HOME/.config}/omarchy/scripts/apps-grid"

mkdir -p "$(dirname "$hypr_input_dst")" "$(dirname "$script_dst")"

if [[ -f "$hypr_input_dst" ]]; then
  backup="$hypr_input_dst.bak.$(date +%s)"
  cp -a "$hypr_input_dst" "$backup"
  echo "Backed up existing input.lua → $backup"
fi

install -m 644 "$hypr_input_src" "$hypr_input_dst"
install -m 755 "$script_src" "$script_dst"
echo "Installed:"
echo "  $hypr_input_dst"
echo "  $script_dst"

if command -v hyprctl >/dev/null 2>&1; then
  hyprctl reload >/dev/null
  if errors="$(hyprctl configerrors 2>/dev/null)" && [[ -n "${errors// }" ]]; then
    echo "Hyprland reported config errors:" >&2
    echo "$errors" >&2
    exit 1
  fi
  echo "Hyprland reloaded."
else
  echo "hyprctl not found; reload Hyprland after login."
fi

echo
echo "Try: natural two-finger scroll, three-finger workspace swipe,"
echo "     four-finger pinch to open Apps, spread to close."
echo "If pinch open/close feel swapped, edit the pinchin/pinchout lines in:"
echo "  $hypr_input_dst"
