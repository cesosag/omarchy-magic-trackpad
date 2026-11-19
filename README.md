# Omarchy Magic Trackpad

Mac-like trackpad behavior for [Omarchy](https://omarchy.org/) (Hyprland): natural scrolling, clickfinger right-click, three-finger workspace swipes, and a Launchpad-style Apps grid on a four-finger pinch.

These are **user config** files under `~/.config/`. They survive `omarchy update` and never touch `/usr/share/omarchy/`.

## What you get

| Gesture / setting | Behavior | macOS analogue |
| --- | --- | --- |
| Natural scrolling | Content follows your fingers | Natural scroll |
| Two-finger click | Right-click | Secondary click |
| Click and hold, then drag | Text selection / window drag | Click-drag |
| Three-finger swipe left/right | Switch Hyprland workspaces | Switch Spaces |
| Pinch with thumb + three fingers | Open the Apps grid | Open Launchpad |
| Spread with thumb + three fingers | Close the Apps grid | Close Launchpad |

**Not enabled:** three-finger drag (`drag_3fg`). On Omarchy it emulates a held click, so workspace swipes were starting text selection. Selection stays a real click-and-hold drag.

The Apps grid is the same UI as **Super + Alt + Space** (`omarchy-shell omarchy.dock apps`).

## Files

```
config/hypr/input.lua     →  ~/.config/hypr/input.lua
scripts/apps-grid         →  ~/.config/omarchy/scripts/apps-grid
install.sh                →  copies both and reloads Hyprland
```

### `input.lua`

Hyprland input overrides:

- `natural_scroll`, `clickfinger_behavior`, `drag_3fg = 0`
- `hl.gesture` for three-finger workspace swipes
- `hl.gesture` for four-finger pinch open / close, calling `apps-grid`

### `apps-grid`

Small helper around dock IPC. `omarchy-shell omarchy.dock apps` only **toggles**, so the script checks whether the `omarchy-dock-apps` layer is present, then opens or closes intentionally:

```bash
~/.config/omarchy/scripts/apps-grid open
~/.config/omarchy/scripts/apps-grid close
~/.config/omarchy/scripts/apps-grid toggle
```

## Install

On an Omarchy machine:

```bash
git clone git@github.com:cesosag/omarchy-magic-trackpad.git
cd omarchy-magic-trackpad
./install.sh
```

`install.sh` backs up any existing `~/.config/hypr/input.lua`, installs both files, and runs `hyprctl reload`.

### Manual install

```bash
mkdir -p ~/.config/omarchy/scripts
install -m 755 scripts/apps-grid ~/.config/omarchy/scripts/apps-grid
# Merge or replace ~/.config/hypr/input.lua with config/hypr/input.lua
hyprctl reload
hyprctl configerrors
```

If you already customize `input.lua`, copy only the `hl.config` touchpad block and the `hl.gesture` calls from this repo’s file into yours. Keep the `apps-grid` path pointing at `~/.config/omarchy/scripts/apps-grid`.

## Pinch direction note

On some touchpads (Synaptics / Windows Precision included), Hyprland’s `pinchin` and `pinchout` labels are **inverted** relative to the physical motion. This repo is tuned so that:

- **physical pinch-in** opens Apps (`direction = "pinchout"` in config)
- **physical spread** closes Apps (`direction = "pinchin"` in config)

If open/close feel backwards on your hardware, swap those two `direction` strings in `~/.config/hypr/input.lua` and reload:

```bash
hyprctl reload
```

If a four-finger pinch does nothing, your pad may only report 2- or 3-finger pinch events — lower `fingers = 4` accordingly and reload.

## Requirements

- Omarchy with Hyprland gesture support (tested on Hyprland 0.56)
- Running `omarchy-shell` (for the Apps grid)
- `hyprctl` on `PATH`

## License

MIT
