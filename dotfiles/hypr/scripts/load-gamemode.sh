#!/usr/bin/env bash
#                                      __   
#   ___ ____ ___ _  ___ __ _  ___  ___/ /__ 
#  / _ `/ _ `/  ' \/ -_)  ' \/ _ \/ _  / -_)
#  \_, /\_,_/_/_/_/\__/_/_/_/\___/\_,_/\__/ 
# /___/                                     
# 

# Source global caching/environment
SCRIPTS_DIR="$(dirname "$(realpath "$0")")"
source "$SCRIPTS_DIR/caching.sh"

gamemode_state="$QS_STATE_DIR/gamemode-enabled"

_loadGameMode() {
    hyprctl --batch "\
        keyword animations:enabled 0;\
        keyword decoration:shadow:enabled 0;\
        keyword decoration:blur:enabled 0;\
        keyword general:gaps_in 0;\
        keyword general:gaps_out 0;\
        keyword general:border_size 1;\
        keyword decoration:rounding 0"
}

if [ -f "$gamemode_state" ]; then
    _loadGameMode
    notify_user --a "System" \
        --i "joystick" \
        --s "Gamemode activated" \
        --m "Animations and blur are now disabled."
fi