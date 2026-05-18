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
last_monitor_backup="$QS_CACHE_DIR/gamemode_last_monitor.conf"
gamemode_monitor="$HOME/.config/hypr/conf/monitors/gamemode.conf"

# Notifications
APP_NAME="System"
NOTIFICATION_ICON="joystick"


if [ -f "$gamemode_state" ]; then
  if [ -f "$last_monitor_backup" ]; then
    cat "$last_monitor_backup" > $HOME/.config/hypr/conf/monitor.conf
    rm "$last_monitor_backup"
  fi
  hyprctl reload
  rm "$gamemode_state"
  notify_user --a "${APP_NAME}" \
            --i "${NOTIFICATION_ICON}" \
            --s "Gamemode deactivated" \
            --m "Animations and blur are now enabled."
else
  if [ -f "$gamemode_monitor" ]; then
    cat $HOME/.config/hypr/conf/monitor.conf > "$last_monitor_backup"
    echo "source = $gamemode_monitor" > $HOME/.config/hypr/conf/monitor.conf
  fi
  hyprctl --batch "\
    keyword animations:enabled 0;\
    keyword decoration:shadow:enabled 0;\
    keyword decoration:blur:enabled 0;\
    keyword general:gaps_in 0;\
    keyword general:gaps_out 0;\
    keyword general:border_size 1;\
    keyword decoration:active_opacity 1;\
    keyword decoration:inactive_opacity 1;\
    keyword decoration:fullscreen_opacity 1;\
    keyword decoration:rounding 0"
  touch "$gamemode_state"
  notify_user --a "${APP_NAME}" \
          --i "${NOTIFICATION_ICON}" \
          --s "Gamemode activated" \
          --m "Animations and blur are now disabled."
fi