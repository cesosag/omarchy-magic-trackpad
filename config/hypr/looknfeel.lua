-- Smooth workspace swipe settle for Mac-like trackpad feel.
-- Omarchy disables workspaces animations by default, so release snapping jumps.
-- style must be "slide", not slidefade. speed is duration: higher = slower.
-- See https://wiki.hypr.land/Configuring/Animations/
-- Docs: https://github.com/cesosag/omarchy-magic-trackpad

hl.curve("apple", { type = "bezier", points = { { 0.32, 0.72 }, { 0, 1 } } })
hl.animation({ leaf = "workspaces", enabled = true, speed = 5.0, bezier = "apple", style = "slide" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 5.0, bezier = "apple", style = "slide" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 5.0, bezier = "apple", style = "slide" })
