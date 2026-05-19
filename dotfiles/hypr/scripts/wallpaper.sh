#!/usr/bin/env bash

# Source global caching/environment
SCRIPTS_DIR="$(dirname "$(realpath "$0")")"
source "$SCRIPTS_DIR/caching.sh"

# Default variables
IMAGE_PATH=""
EFFECT=""
NOTIFICATIONS=false
SKIP=false
CACHE_FOLDER="$QS_CACHE_DIR/wallpaper"
CACHE_FILE="$CACHE_FOLDER/current_wallpaper"
DEFAULT_WALLPAPER="$HOME/Pictures/Wallpapers/default.jpg"
BLURRED_WALLPAPER="$CACHE_FOLDER/blurred_wallpaper.png"
SQUARE_WALLPAPER="$CACHE_FOLDER/square_wallpaper.png"
RASI_FILE="$CACHE_FOLDER/current_wallpaper.rasi"

# Settings (using modern Quickshell state directory)
STATE_FOLDER="$QS_STATE_DIR/wallpaper"
mkdir -p "$STATE_FOLDER" "$CACHE_FOLDER"

SETTINGS_BLUR="$STATE_FOLDER/blur"
SETTINGS_WALLPAPER_FOLDER="$STATE_FOLDER/folder"
SETTINGS_WALLPAPER_EFFECT="$STATE_FOLDER/effect"
SETTINGS_TRANSITION_EFFECT="$STATE_FOLDER/transition"

# Read Settings with safe fallbacks
BLUR=$(cat "$SETTINGS_BLUR" 2>/dev/null || echo "50x30")
WALLPAPER_FOLDER=$(cat "$SETTINGS_WALLPAPER_FOLDER" 2>/dev/null || echo "$HOME/Pictures/Wallpapers")
EFFECT=$(cat "$SETTINGS_WALLPAPER_EFFECT" 2>/dev/null || echo "off")
TRANSITION=$(cat "$SETTINGS_TRANSITION_EFFECT" 2>/dev/null || echo "simple")

# Colors for UI
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# --- UI Functions (Redirected to stderr) ---
info() { echo -e "${GREEN}[INFO]${NC} $1" >&2; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1" >&2; }
error() { echo -e "${RED}[ERROR]${NC} $1" >&2; }

show_help() {
    echo "Usage: wallpaper.sh PATH_TO_IMAGE [OPTIONS]"
    echo "  DEFAULT:               $DEFAULT_WALLPAPER"
    echo ""
    echo "Core Parameters:"
    echo "  PATH_TO_IMAGE          Path to the image file to set as wallpaper."
    echo ""
    echo "Optional Parameters:"
    echo "  --effect NAME          Apply a specific wallpaper effect."
    echo "  --random FOLDER        Select a random image from FOLDER."
    echo "  --notifications false  Disable desktop notifications."
    echo "  --help                 Show this help message and exit."
    echo "  --skip                 Will skip setting the wallpaper with awww."
    echo ""
}

send_notification() {
    local title="$1"
    local message="$2"
    if [ "$NOTIFICATIONS" = true ]; then
        notify_user --a "wallpaper.sh" --i "preferences-desktop-wallpaper-symbolic" --s "$title" --m "$message"
    fi
}

# ==========================================
# Parameter Parsing
# ==========================================

if [[ $# -eq 0 ]]; then
    show_help
    exit 1
fi

while [[ $# -gt 0 ]]; do
    case "$1" in
        --skip)
            SKIP=true
            shift 1
            ;;
        --effect)
            EFFECT="$2"
            shift 2
            ;;
        --random)
            if [[ -n "$2" && "$2" != -* ]]; then
                RANDOM_FOLDER="$2"
                shift 2
            else
                RANDOM_FOLDER="$WALLPAPER_FOLDER"
                shift 1
            fi
            eval RANDOM_FOLDER="$RANDOM_FOLDER"
            RANDOM_FOLDER=$(realpath "$RANDOM_FOLDER" 2>/dev/null)

            if [[ -d "$RANDOM_FOLDER" ]]; then
                IMAGE_PATH=$(find "$RANDOM_FOLDER" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) | shuf -n 1)
                
                if [[ -z "$IMAGE_PATH" ]]; then
                    error "No valid images found in -> $RANDOM_FOLDER"
                    exit 1
                fi
                info "Random wallpaper selected: $IMAGE_PATH"
            else
                error "Directory does not exist -> $RANDOM_FOLDER"
                exit 1
            fi
            ;;
        --notifications)
            if [[ "$2" == "false" ]]; then
                NOTIFICATIONS=false
            fi
            shift 2
            ;;
        --help)
            show_help
            exit 0
            ;;
        -*)
            echo "Error: Unknown option $1"
            show_help
            exit 1
            ;;
        *)
            if [[ -z "$IMAGE_PATH" ]]; then
                IMAGE_PATH="$1"
            else
                echo "Error: Multiple image paths provided or unknown argument -> $1"
                exit 1
            fi
            shift
            ;;
    esac
done

# ==========================================
# Validation
# ==========================================

if [[ -z "$IMAGE_PATH" ]]; then
    info "Setting wallpaper with default image -> $DEFAULT_WALLPAPER"
    IMAGE_PATH="$DEFAULT_WALLPAPER"
fi

# Expand path safely
eval IMAGE_PATH="$IMAGE_PATH"
IMAGE_PATH=$(realpath "$IMAGE_PATH" 2>/dev/null)

if [[ ! -f "$IMAGE_PATH" ]]; then
    error "Image file does not exist at -> $IMAGE_PATH"
    exit 1
fi

# ==========================================
# Core Logic
# ==========================================

# Ensure awww-daemon is running
if ! pgrep -x "awww-daemon" > /dev/null; then
    mkdir -p "$HOME/.cache/awww"
    info "Starting awww-daemon..."
    awww-daemon &
    sleep 1 
fi

# Write image path to cache file
echo "$IMAGE_PATH" > "$CACHE_FILE"
info "Cache file written with $IMAGE_PATH"

# Set the Wallpaper
if [ "$SKIP" = true ]; then
    info "Setting wallpaper skipped"
else
    info "Setting wallpaper: $IMAGE_PATH"
    info "Using wallpaper effect $TRANSITION"
    awww img "$IMAGE_PATH" --transition-type "$TRANSITION"
fi

# Detect Theme (Light/Dark GTK settings)
THEME_PREF=1
SETTINGS_FILE="$HOME/.config/gtk-3.0/settings.ini"
if [ -f "$SETTINGS_FILE" ]; then
    THEME_PREF=$(grep -E '^gtk-application-prefer-dark-theme=' "$SETTINGS_FILE" | awk -F'=' '{print $2}')
    THEME_PREF=${THEME_PREF:-1}
fi

# Execute matugen
MATUGEN_MODE="dark"
if [ "$THEME_PREF" -eq 0 ]; then
    MATUGEN_MODE="light"
fi

if [ -f "$HOME/.cargo/bin/matugen" ]; then
    "$HOME/.cargo/bin/matugen" image "$IMAGE_PATH" --source-color-index 0 -m "$MATUGEN_MODE"
else
    matugen image "$IMAGE_PATH" --source-color-index 0 -m "$MATUGEN_MODE"
fi
info "Matugen updated"

# Update Quickshell theme
qs -c nixHypr-shell ipc call main forceReload
info "Quickshell Theme updated"

# Update Pywalfox
if type pywalfox >/dev/null 2>&1; then
    pywalfox update
    info "pywalfox updated"
fi

# Update SwayNC if installed
if type swaync-client >/dev/null 2>&1; then
    sleep 0.1
    swaync-client -rs
    info "SwayNC refreshed"
fi

# Create blurred image
magick "$IMAGE_PATH" -resize 75% "$BLURRED_WALLPAPER"
info "$(basename "$IMAGE_PATH") resized to 75% -> $(basename "$BLURRED_WALLPAPER")"
if [ ! "$BLUR" == "0x0" ]; then
    magick "$BLURRED_WALLPAPER" -blur "$BLUR" "$BLURRED_WALLPAPER"
    info "$(basename "$BLURRED_WALLPAPER") blurred with $BLUR"
fi

# Create square image
magick "$IMAGE_PATH" -gravity Center -extent 1:1 "$SQUARE_WALLPAPER"
info "$(basename "$SQUARE_WALLPAPER") created"

# Create rasi file
echo "* { current-image: url(\"$BLURRED_WALLPAPER\", height); }" > "$RASI_FILE"
info "$(basename "$RASI_FILE") written with $(basename "$BLURRED_WALLPAPER")"

# Notification
send_notification "Wallpaper Update Completed" "Successfully set and processed $(basename "$IMAGE_PATH")"
info "Wallpaper Updated: Successfully set $(basename "$IMAGE_PATH")"
exit 0
