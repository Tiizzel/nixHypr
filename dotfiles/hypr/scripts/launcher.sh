#!/usr/bin/env bash

# -----------------------------------------------------
# Launcher Script
# -----------------------------------------------------

if pgrep -x "quickshell" > /dev/null; then
    quickshell ipc -c nixHypr-shell call shell launcher toggle
else
    rofi -show drun
fi
