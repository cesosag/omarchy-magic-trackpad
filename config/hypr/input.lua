-- Mac-like Magic Trackpad feel for Omarchy / Hyprland.
-- Keep only your personal input overrides here. Uncommented settings below
-- replace Omarchy's defaults.
--
-- Companion script: ~/.config/omarchy/scripts/apps-grid
-- Docs: https://github.com/cesosag/omarchy-magic-trackpad

-- Natural scroll, two-finger right-click, click-and-hold to select/drag
-- (three-finger drag disabled so workspace swipes do not start text selection).
-- See https://wiki.hypr.land/Configuring/Basics/Variables/#input
hl.config({
  input = {
    touchpad = {
      natural_scroll = true,
      clickfinger_behavior = true,
      -- Slightly slower than Omarchy's default (0.4).
      scroll_factor = 0.25,
      drag_3fg = 0,
    },
  },
})

-- Three-finger horizontal swipe → switch workspaces (Spaces-like).
-- See https://wiki.hypr.land/Configuring/Gestures/
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

-- Thumb + three fingers (4 contacts) ↔ Apps grid (Launchpad-like).
-- Same UI as SUPER + ALT + SPACE / omarchy-shell omarchy.dock apps.
--
-- NOTE: On some touchpads (including the author's Synaptics pad) Hyprland's
-- pinchin / pinchout labels are inverted vs the physical motion. Here,
-- pinchout opens and pinchin closes. If open/close feel swapped on your
-- hardware, exchange the two direction strings below.
local apps_grid = os.getenv("HOME") .. "/.config/omarchy/scripts/apps-grid"

hl.gesture({
  fingers = 4,
  direction = "pinchout", -- physical pinch-in on inverted pads
  action = function()
    hl.exec_cmd(apps_grid .. " open")
  end,
})

hl.gesture({
  fingers = 4,
  direction = "pinchin", -- physical spread on inverted pads
  action = function()
    hl.exec_cmd(apps_grid .. " close")
  end,
})
