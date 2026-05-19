#!/usr/bin/env bash
source "$HOME/.config/hypr/scripts/caching.sh"
exec python3 "$(dirname "$0")/focus_daemon.py" 
