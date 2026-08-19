#!/bin/bash
# Called on startup and whenever displays change.
# Waits for AeroSpace to be ready, then places workspaces on the right monitors.

for i in $(seq 1 15); do
    aerospace list-monitors &>/dev/null && break
    sleep 1
done

MONITORS=$(aerospace list-monitors 2>/dev/null) || exit 0

# Small extra delay so AeroSpace has settled after the display change
sleep 0.5

if echo "$MONITORS" | grep -q "DELL"; then
    for ws in B N T S C; do
        aerospace move-workspace-to-monitor --workspace "$ws" DELL 2>/dev/null || true
    done
fi

if echo "$MONITORS" | grep -q "Sidecar"; then
    aerospace move-workspace-to-monitor --workspace Z Sidecar 2>/dev/null || true
else
    aerospace move-workspace-to-monitor --workspace Z built-in 2>/dev/null || true
fi

aerospace move-workspace-to-monitor --workspace F built-in 2>/dev/null || true
