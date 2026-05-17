#!/usr/bin/env bash

# Helper functions to get current state
get_sink() { pactl get-default-sink; }
get_vol() { pamixer --get-volume; }
get_mute() { pamixer --get-mute; }

# 1. Initialize state
last_sink=$(get_sink)
last_vol=$(get_vol)
last_mute=$(get_mute)

# 2. Loop through events
pactl subscribe | grep --line-buffered "Event 'change' on sink" | while read -r line; do
    
    current_sink=$(get_sink)
    current_vol=$(get_vol)
    current_mute=$(get_mute)

    # CHECK 1: Did the Output Device change?
    if [[ "$current_sink" != "$last_sink" ]]; then
        last_sink="$current_sink"
        last_vol="$current_vol"
        last_mute="$current_mute"
        continue
    fi

    # CHECK 2: Did the Volume/Mute actually change on the SAME device?
    if [[ "$current_vol" != "$last_vol" ]] || [[ "$current_mute" != "$last_mute" ]]; then
        # Trigger OSD (if swayosd is installed)
        if command -v swayosd-client >/dev/null 2>&1; then
            swayosd-client --output-volume 0
        fi

        # Update tracking
        last_vol="$current_vol"
        last_mute="$current_mute"
    fi
done
