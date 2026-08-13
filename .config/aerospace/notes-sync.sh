#!/bin/bash
CONFIG="$HOME/.config/aerospace/aerospace.toml"
NOTES_GAP=420

GAP=$(grep 'outer\.right' "$CONFIG" | grep -o '[0-9]*')
[ "$GAP" != "$NOTES_GAP" ] && exit 0

NOTES_VISIBLE=$(swift -e '
import CoreGraphics
let windows = CGWindowListCopyWindowInfo(.optionOnScreenOnly, kCGNullWindowID) as! [[String: Any]]
let raycast = windows.filter {
    ($0["kCGWindowOwnerName"] as? String) == "Raycast" &&
    (($0["kCGWindowAlpha"] as? Double) ?? 0) > 0
}
print(raycast.isEmpty ? "no" : "yes")
' 2>/dev/null)

[ "$NOTES_VISIBLE" = "yes" ] && exit 0

sed -i '' "s/outer\\.right = $NOTES_GAP/outer.right = 15/" "$CONFIG"
aerospace reload-config
