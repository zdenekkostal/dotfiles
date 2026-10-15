#!/bin/bash
# Usage: send.sh <workspace>
# Move the focused window to <workspace> and follow it. If it was floating only
# because it was presented on P, tile it again. Apps on the "never tile" list stay floating.
WS="$1"
CONFIG="$HOME/.config/aerospace/aerospace.toml"

read -r ID FROM LAYOUT BUNDLE < <(aerospace list-windows --focused --format '%{window-id} %{workspace} %{window-layout} %{app-bundle-id}')
[ -z "$ID" ] && exit 1

aerospace move-node-to-workspace "$WS"
aerospace workspace "$WS"

if [ "$LAYOUT" = "floating" ] && [ "$FROM" = "P" ]; then
    if ! grep -B1 "run = 'layout floating'" "$CONFIG" | grep -q "= $BUNDLE\b"; then
        aerospace layout --window-id "$ID" tiling
    fi
fi

# Same finishing touch as the old bindings (no-ops for windows that stay floating).
aerospace flatten-workspace-tree 2>/dev/null
aerospace layout tiles horizontal 2>/dev/null
exit 0
