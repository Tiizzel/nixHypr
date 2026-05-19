#!/usr/bin/env bash

# Source and initialize quickshell dynamic caching
source "$(dirname "${BASH_SOURCE[0]}")/caching.sh"
qs_ensure_cache "lock"

# Avoid starting multiple instances
if pgrep -f "quickshell -p ~/.config/quickshell/nixHypr-shell/Lock.qml" >/dev/null; then
    exit 0
fi

quickshell -p ~/.config/quickshell/nixHypr-shell/Lock.qml
