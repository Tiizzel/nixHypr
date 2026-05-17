#!/usr/bin/env bash
# NixHypr Theme Glass

# Set waybar
echo "/nixHypr-glass-center;/nixHypr-glass-center/default" > $HOME/.config/nixHypr/settings/waybar-theme.sh
$HOME/.config/nixHypr/scripts/launch-bar &

# Set nwg-dock-hyprland
echo "glass" > $HOME/.config/nixHypr/settings/dock-theme
$HOME/.config/nwg-dock-hyprland/launch.sh &

# Set swaync
echo '@import "themes/glass/style.css";' > $HOME/.config/swaync/style.css
swaync-client -rs

# Set launcher
echo 'rofi' > $HOME/.config/nixHypr/settings/launcher

# Set walker theme
echo 'glass' > $HOME/.config/nixHypr/settings/walker-theme

# Set Window Border
echo 'source = ~/.config/hypr/conf/windows/default.conf' > $HOME/.config/hypr/conf/window.conf

# Set rofi
echo '* { border-width: 1px; }' > $HOME/.config/nixHypr/settings/rofi-border.rasi

echo ":: Theme set to Glass"