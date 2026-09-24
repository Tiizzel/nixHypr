#!/bin/bash
# Watch for wallpaper changes and run matugen automatically
WALLPAPER="/home/tiizzel/mangoTango/modules/mangowm_desktop/dotfiles/wallpaper/wallpaper.jpg"

while inotifywait -e close_write "$WALLPAPER"; do
    matugen image "$WALLPAPER" --source-color-index 0
done
