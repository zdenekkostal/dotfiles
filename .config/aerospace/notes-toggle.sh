#!/bin/bash
CONFIG="$HOME/.config/aerospace/aerospace.toml"
NOTES_GAP=420

is_notes_visible() {
    swift -e '
import CoreGraphics
let windows = CGWindowListCopyWindowInfo(.optionOnScreenOnly, kCGNullWindowID) as! [[String: Any]]
let raycast = windows.filter {
    ($0["kCGWindowOwnerName"] as? String) == "Raycast" &&
    (($0["kCGWindowAlpha"] as? Double) ?? 0) > 0
}
print(raycast.isEmpty ? "no" : "yes")
' 2>/dev/null
}

CURRENT_GAP=$(grep 'outer\.right' "$CONFIG" | grep -o '[0-9]*')

if [ "$CURRENT_GAP" = "$NOTES_GAP" ]; then
    sed -i '' 's/outer\.right = .*/outer.right = 15/' "$CONFIG"
    aerospace reload-config
    [ "$(is_notes_visible)" = "yes" ] && open 'raycast://extensions/raycast/raycast-notes/raycast-notes'
else
    sed -i '' "s/outer\.right = .*/outer.right = $NOTES_GAP/" "$CONFIG"
    aerospace reload-config
    sleep 0.3
    open 'raycast://extensions/raycast/raycast-notes/raycast-notes'
fi
