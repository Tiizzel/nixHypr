#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Quickshell Manager Script (Reference Version)
# -----------------------------------------------------------------------------
# Adjusting to local structure
SHELL_QML_PATH="$HOME/.config/quickshell/nixHypr-shell/shell.qml"

# -----------------------------------------------------------------------------
ACTION="$1"
TARGET="$2"
SUBTARGET="$3"

if [[ "$ACTION" =~ ^[0-9]+$ ]]; then
    # Send IPC command directly to Main.qml asynchronously
    (quickshell ipc -c nixHypr-shell call main handleCommand "close" "" "" >/dev/null 2>&1) &

    if [[ "$TARGET" == "move" ]]; then
        CMD="hl.dsp.window.move({ workspace = $ACTION })"
    else
        CMD="hl.dsp.focus({ workspace = $ACTION })"
    fi
    
    hyprctl dispatch "$CMD" >/dev/null 2>&1
    exit 0
fi

# -----------------------------------------------------------------------------
source "$(dirname "${BASH_SOURCE[0]}")/caching.sh"

qs_ensure_cache "workspaces"
qs_ensure_cache "network"
qs_ensure_cache "wallpaper"

BT_PID_FILE="$QS_RUN_DIR/bt_scan_pid"
BT_SCAN_LOG="$QS_LOG_DIR/bt_scan.log"
SRC_DIR="${WALLPAPER_DIR:-$HOME/Pictures/Wallpapers}"
THUMB_DIR="$QS_CACHE_WALLPAPER/thumbs"
PREP_LOCK="$QS_RUN_DIR/wallpaper_prep.lock"

export MAGICK_THREAD_LIMIT=1

QS_NETWORK_CACHE="$QS_CACHE_NETWORK"
mkdir -p "$QS_NETWORK_CACHE" "$THUMB_DIR"

NETWORK_MODE_FILE="$QS_NETWORK_CACHE/mode"
MANIFEST="$THUMB_DIR/.manifest"

# -----------------------------------------------------------------------------
if ! pgrep -f "quickshell.*nixHypr-shell" >/dev/null; then
    quickshell -c nixHypr-shell >/dev/null 2>&1 &
    disown
fi

build_manifest() {
    find "$THUMB_DIR" -maxdepth 1 -type f ! -name '.source_dir' ! -name '.manifest' \
        -printf "%f\n" | sort > "$MANIFEST"
}

handle_wallpaper_prep() {
    mkdir -p "$THUMB_DIR"

    (
        if [ -f "$PREP_LOCK" ]; then
            if kill -0 "$(cat "$PREP_LOCK")" 2>/dev/null; then
                exit 0
            fi
        fi
        echo $BASHPID > "$PREP_LOCK"

        export THUMB_DIR SRC_DIR MANIFEST MAGICK_THREAD_LIMIT=1

        THUMB_SOURCE_FILE="$THUMB_DIR/.source_dir"
        if [ -f "$THUMB_SOURCE_FILE" ]; then
            read -r CACHED_SRC < "$THUMB_SOURCE_FILE"
            if [ "$CACHED_SRC" != "$SRC_DIR" ]; then
                find "$THUMB_DIR" -maxdepth 1 -type f \
                    ! -name '.source_dir' ! -name '.manifest' -delete
                echo "$SRC_DIR" > "$THUMB_SOURCE_FILE"
                > "$MANIFEST"
            fi
        else
            echo "$SRC_DIR" > "$THUMB_SOURCE_FILE"
            > "$MANIFEST"
        fi

        [ ! -f "$MANIFEST" ] && build_manifest

        SRC_LIST=$(mktemp)
        find -L "$SRC_DIR" -maxdepth 1 -type f \
            \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \
               -o -iname "*.gif" -o -iname "*.mp4" -o -iname "*.mkv" \
               -o -iname "*.mov" -o -iname "*.webm" \) \
            -printf "%f\n" | sort > "$SRC_LIST"

        comm -23 <(sed 's/^000_//' "$MANIFEST" | sort) "$SRC_LIST" | while read -r orphan; do
            rm -f "$THUMB_DIR/$orphan" "$THUMB_DIR/000_$orphan"
            sed -i "/^${orphan}$/d;/^000_${orphan}$/d" "$MANIFEST"
        done

        while IFS= read -r filename; do
            img="$SRC_DIR/$filename"
            [ -f "$img" ] || continue

            extension="${filename##*.}"

            if [[ "${extension,,}" == "webp" ]]; then
                new_img="${img%.*}.jpg"
                magick "$img" "$new_img" && rm -f "$img"
                img="$new_img"
                filename="$(basename "$img")"
                extension="jpg"
            fi

            if [[ "${extension,,}" =~ ^(mp4|mkv|mov|webm)$ ]]; then
                thumb="$THUMB_DIR/000_$filename"
                [ -f "$THUMB_DIR/$filename" ] && rm -f "$THUMB_DIR/$filename"
                if [ ! -f "$thumb" ]; then
                    ffmpeg -y -ss 00:00:05 -i "$img" -vframes 1 \
                        -threads 1 -f image2 -q:v 2 "$thumb" >/dev/null 2>&1
                    echo "000_$filename" >> "$MANIFEST"
                fi
            else
                thumb="$THUMB_DIR/$filename"
                if [ ! -f "$thumb" ]; then
                    magick "$img" -resize x420 -quality 70 "$thumb"
                    echo "$filename" >> "$MANIFEST"
                fi
            fi
        done < <(comm -23 "$SRC_LIST" <(sed 's/^000_//' "$MANIFEST" | sort))

        rm -f "$SRC_LIST" "$PREP_LOCK"
    ) </dev/null >/dev/null 2>&1 &
}

handle_network_prep() {
    echo "" > "$BT_SCAN_LOG"
    { echo "scan on"; sleep infinity; } | stdbuf -oL bluetoothctl > "$BT_SCAN_LOG" 2>&1 &
    echo $! > "$BT_PID_FILE"
    (nmcli device wifi rescan) >/dev/null 2>&1 &
}

if [[ "$ACTION" == "close" ]]; then
    quickshell ipc -c nixHypr-shell call main handleCommand "close" "" "" >/dev/null 2>&1
    if [[ "$TARGET" == "network" || "$TARGET" == "all" || -z "$TARGET" ]]; then
        if [ -f "$BT_PID_FILE" ]; then
            kill $(cat "$BT_PID_FILE") 2>/dev/null
            rm -f "$BT_PID_FILE"
        fi
        (bluetoothctl scan off > /dev/null 2>&1) &
    fi
    exit 0
fi

if [[ "$ACTION" == "open" || "$ACTION" == "toggle" ]]; then
    if [[ "$TARGET" == "network" ]]; then
        handle_network_prep
        [[ -n "$SUBTARGET" ]] && echo "$SUBTARGET" > "$NETWORK_MODE_FILE"
        quickshell ipc -c nixHypr-shell call main handleCommand "$ACTION" "$TARGET" "$SUBTARGET" >/dev/null 2>&1
        exit 0
    fi

    if [[ "$TARGET" == "wallpaper" ]]; then
        handle_wallpaper_prep
        CURRENT_SRC=""
        if pgrep -a "mpvpaper" > /dev/null; then
            CURRENT_SRC=$(pgrep -a mpvpaper | grep -o "$SRC_DIR/[^' ]*" | head -n1)
        elif command -v swww >/dev/null; then
            CURRENT_SRC=$(swww query 2>/dev/null | grep -o "$SRC_DIR/[^ ]*" | head -n1)
        fi

        TARGET_THUMB=""
        if [ -n "$CURRENT_SRC" ]; then
            BASE=$(basename "$CURRENT_SRC")
            EXT="${BASE##*.}"
            [[ "${EXT,,}" =~ ^(mp4|mkv|mov|webm)$ ]] && TARGET_THUMB="000_$BASE" || TARGET_THUMB="$BASE"
        fi

        quickshell ipc -c nixHypr-shell call main handleCommand "$ACTION" "$TARGET" "$TARGET_THUMB" >/dev/null 2>&1
    else
        quickshell ipc -c nixHypr-shell call main handleCommand "$ACTION" "$TARGET" "$SUBTARGET" >/dev/null 2>&1
    fi
    exit 0
fi
