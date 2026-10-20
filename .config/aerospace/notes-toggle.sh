#!/bin/bash
CONFIG="$HOME/.config/aerospace/aerospace.toml"
NOTES_GAP=420
NOTES_URL='raycast://extensions/raycast/raycast-notes/raycast-notes'

# `swift -e` takes ~0.2s to start; a compiled copy answers in ~0.04s. Built on
# first use, so there is nothing to install.
CHECKER="$HOME/.cache/aerospace/notes-visible"

build_checker() {
    mkdir -p "$(dirname "$CHECKER")"
    local dir src
    dir=$(mktemp -d "${TMPDIR:-/tmp}/notes-visible.XXXXXX")
    src="$dir/notes-visible.swift"
    cat > "$src" <<'SWIFT'
import CoreGraphics
let windows = CGWindowListCopyWindowInfo(.optionOnScreenOnly, kCGNullWindowID) as! [[String: Any]]
let raycast = windows.filter {
    ($0["kCGWindowOwnerName"] as? String) == "Raycast" &&
    (($0["kCGWindowAlpha"] as? Double) ?? 0) > 0
}
print(raycast.isEmpty ? "no" : "yes")
SWIFT
    swiftc -O "$src" -o "$CHECKER" 2>/dev/null
    rm -rf "$dir"
}

is_notes_visible() {
    [ -x "$CHECKER" ] || build_checker
    "$CHECKER" 2>/dev/null
}

set_gap() {
    sed -i '' "s/outer\.right = .*/outer.right = $1/" "$CONFIG"
    aerospace reload-config
}

CURRENT_GAP=$(grep 'outer\.right' "$CONFIG" | grep -o '[0-9]*')

if [ "$CURRENT_GAP" = "$NOTES_GAP" ]; then
    # Close: give the space back while checking whether Notes is still up.
    set_gap 15 &
    [ "$(is_notes_visible)" = "yes" ] && open "$NOTES_URL"
    wait
else
    # Open: Raycast first, so notes-sync sees the old gap and leaves it alone,
    # then make room. No delay needed; Notes is floating and ignores the gap.
    open "$NOTES_URL"
    set_gap "$NOTES_GAP"
fi
