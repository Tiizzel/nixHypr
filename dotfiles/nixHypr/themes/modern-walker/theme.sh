#!/usr/bin/env bash
# NixHypr Theme Modern

# Set waybar
echo "/nixHypr-modern;/nixHypr-modern/default" > $HOME/.config/nixHypr/settings/waybar-theme.sh
$HOME/.config/nixHypr/scripts/launch-bar &

# Set nwg-dock-hyprland
echo "modern" > $HOME/.config/nixHypr/settings/dock-theme
$HOME/.config/nwg-dock-hyprland/launch.sh &

# Set swaync
echo '@import "themes/modern/style.css";' > $HOME/.config/swaync/style.css
swaync-client -rs

# Set launcher
echo 'walker' > $HOME/.config/nixHypr/settings/launcher

# Set walker theme
echo 'modern' > $HOME/.config/nixHypr/settings/walker-theme

# Set Window Border
echo 'source = ~/.config/hypr/conf/windows/border-2.conf' > $HOME/.config/hypr/conf/window.conf

# Set rofi
echo '* { border-width: 2px; }' > $HOME/.config/nixHypr/settings/rofi-border.rasi

echo ":: Theme set to Modern"