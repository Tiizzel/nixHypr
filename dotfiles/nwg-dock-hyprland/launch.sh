#!/usr/bin/env bash
#    ___           __
#   / _ \___  ____/ /__
#  / // / _ \/ __/  '_/
# /____/\___/\__/_/\_\
#

STATE_DIR="$HOME/.local/state/quickshell/dock"
mkdir -p "$STATE_DIR"

DOCK_THEME="modern"
if [ -f "$STATE_DIR/theme" ]; then
    DOCK_THEME=$(cat "$STATE_DIR/theme")
fi
echo ":: Using Dock Theme $DOCK_THEME"
echo ":: Dock Autohide $DOCK_AUTOHIDE"
if [ ! -f "$STATE_DIR/disabled" ]; then
    killall nwg-dock-hyprland
    sleep 0.5
    if [ -f "$STATE_DIR/autohide" ]; then
        nwg-dock-hyprland -d -i 32 -w 5 -mb 10 -x -s themes/$DOCK_THEME/style.css -c "$HOME/.config/hypr/scripts/launcher.sh"
    else
        nwg-dock-hyprland -i 32 -w 5 -mb 10 -x -s themes/$DOCK_THEME/style.css -c "$HOME/.config/hypr/scripts/launcher.sh"
    fi
else
    killall nwg-dock-hyprland
    echo ":: Dock disabled"
fi