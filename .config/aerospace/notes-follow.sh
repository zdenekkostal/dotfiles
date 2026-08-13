#!/bin/bash
pgrep -x "Notes" > /dev/null 2>&1 || exit 0

CURRENT_WS=$(aerospace list-workspaces --focused)
NOTES_LINE=$(aerospace list-windows --all --format '%{window-id}|%{workspace}|%{app-bundle-id}' | grep 'com.apple.Notes')

[ -z "$NOTES_LINE" ] && exit 0

NOTES_ID=$(echo "$NOTES_LINE" | cut -d'|' -f1)
NOTES_WS=$(echo "$NOTES_LINE" | cut -d'|' -f2)

[ "$NOTES_WS" = "$CURRENT_WS" ] && exit 0

aerospace move-node-to-workspace --window-id "$NOTES_ID" "$CURRENT_WS"
