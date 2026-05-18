#!/usr/bin/env bash

# ==============================================================================
# nixHypr - Post-Boot NixOS & Hyprland Installer
# ==============================================================================
# A premium, fully dynamic, interactive installer for bootstrapping the nixHypr 
# configuration on a freshly installed and booted NixOS system.
# ==============================================================================

set -euo pipefail

# ANSI color codes for premium terminal design
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

# Helper printing functions
info() { echo -e "${BLUE}[INFO]${NC} $1"; }
success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; }
question() { echo -ne "${CYAN}[?]${NC} $1"; }

# ------------------------------------------------------------------------------
# 1. Sanity & Environmental Checks
# ------------------------------------------------------------------------------
clear
echo -e "${PURPLE}"
echo "    _   _            _   _                 "
echo "   | \ | |          | | | |                "
echo "   |  \| | ___  __ _| |_| |_   _ _ __  _ __"
echo "   | . \` |/ _ \/ _\` |  _  | | | | '__|| '__|"
echo "   | |\  |  __/ (_| | | | | |_| | |   | |   "
echo "   |_| \_|\___|\__, | |_| |_|\__, |_|   |_|   "
echo "                __/ |         __/ |        "
echo "               |___/         |___/         "
echo -e "${NC}"
echo -e "${WHITE}  --- nixHypr Post-Install Configuration Bootstrapper ---${NC}"
echo ""

# Check if script is run as root (via sudo)
if [ "$EUID" -ne 0 ]; then
    error "This installer needs root privileges to rebuild the system configuration."
    info "Please run: 'sudo ./install.sh'"
    exit 1
fi

# Detect logged in user (who called sudo)
REAL_USER="${SUDO_USER:-$(logname 2>/dev/null || echo "tiizzel")}"
USER_HOME="/home/$REAL_USER"

if [ "$REAL_USER" = "root" ]; then
    warning "It appears you are logged in directly as root."
    question "Enter the target non-root username to install this configuration for [tiizzel]: "
    read -r REAL_USER
    REAL_USER=${REAL_USER:-"tiizzel"}
    USER_HOME="/home/$REAL_USER"
fi

# Check if target user's home folder exists
if [ ! -d "$USER_HOME" ]; then
    error "Target user home directory '$USER_HOME' does not exist."
    exit 1
fi

# Check if `/etc/nixos/hardware-configuration.nix` exists
if [ ! -f "/etc/nixos/hardware-configuration.nix" ]; then
    error "No hardware-configuration.nix found at /etc/nixos/"
    info "This script must be run on a booted NixOS system where NixOS was already installed."
    exit 1
fi

# ------------------------------------------------------------------------------
# 2. Gather User Inputs
# ------------------------------------------------------------------------------
info "Please customize the configuration parameters for your system."

# GitHub Repository
question "GitHub Repository URL to clone [https://github.com/Tiizzel/nixHypr.git]: "
read -r REPO_URL
REPO_URL=${REPO_URL:-"https://github.com/Tiizzel/nixHypr.git"}

# Hostname
question "Target Hostname [nixos]: "
read -r HOSTNAME
HOSTNAME=${HOSTNAME:-"nixos"}

# Git Username
question "Git Username [$REAL_USER]: "
read -r GIT_NAME
GIT_NAME=${GIT_NAME:-"$REAL_USER"}

# Git Email
question "Git Email [tiizztwitch@gmail.com]: "
read -r GIT_EMAIL
GIT_EMAIL=${GIT_EMAIL:-"tiizztwitch@gmail.com"}

# Keyboard Layout
question "Keyboard Layout [de]: "
read -r KB_LAYOUT
KB_LAYOUT=${KB_LAYOUT:-"de"}

# Timezone
question "Timezone [Europe/Berlin]: "
read -r TZ
TZ=${TZ:-"Europe/Berlin"}

# SOPS Secret Toggling
question "Disable SOPS secrets decryption during initial rebuild? (y/n) [y]: "
read -r DISABLE_SOPS
DISABLE_SOPS=${DISABLE_SOPS:-"y"}

echo ""
info "Confirming installation parameters:"
echo -e "  - ${WHITE}Repo URL:${NC}       $REPO_URL"
echo -e "  - ${WHITE}Target User:${NC}    $REAL_USER"
echo -e "  - ${WHITE}Hostname:${NC}       $HOSTNAME"
echo -e "  - ${WHITE}Git Name:${NC}       $GIT_NAME"
echo -e "  - ${WHITE}Git Email:${NC}      $GIT_EMAIL"
echo -e "  - ${WHITE}Keyboard:${NC}       $KB_LAYOUT"
echo -e "  - ${WHITE}Timezone:${NC}       $TZ"
echo -e "  - ${WHITE}Disable SOPS:${NC}   $DISABLE_SOPS"
echo ""

question "Do you want to proceed with cloning and configuring? (y/n) [y]: "
read -r PROCEED
PROCEED=${PROCEED:-"y"}
if [[ ! "$PROCEED" =~ ^[Yy]$ ]]; then
    warning "Installation aborted."
    exit 0
fi

# ------------------------------------------------------------------------------
# 3. Clone the configuration to target user's home
# ------------------------------------------------------------------------------
TARGET_DIR="$USER_HOME/nixHypr"

if [ -d "$TARGET_DIR" ]; then
    warning "Directory $TARGET_DIR already exists."
    question "Do you want to delete it and re-clone? (y/n) [n]: "
    read -r DELETE_DIR
    DELETE_DIR=${DELETE_DIR:-"n"}
    if [[ "$DELETE_DIR" =~ ^[Yy]$ ]]; then
        info "Deleting existing directory..."
        rm -rf "$TARGET_DIR"
    else
        error "Target directory already exists. Installation halted to avoid overwriting your work."
        exit 1
    fi
fi

info "Cloning configuration into $TARGET_DIR..."
# Run git clone as the real user to avoid permission/ownership issues in their home folder
sudo -u "$REAL_USER" git clone "$REPO_URL" "$TARGET_DIR"

# ------------------------------------------------------------------------------
# 4. Copy Hardware Config
# ------------------------------------------------------------------------------
info "Copying system hardware configuration..."
cp /etc/nixos/hardware-configuration.nix "$TARGET_DIR/hosts/nixos/hardware.nix"

# ------------------------------------------------------------------------------
# 5. Dynamically Replace Configuration Variables
# ------------------------------------------------------------------------------
info "Injecting custom configuration variables..."

VARS_FILE="$TARGET_DIR/hosts/nixos/variables.nix"
CONFIG_FILE="$TARGET_DIR/modules/flake/nixos-configurations.nix"

if [ -f "$VARS_FILE" ]; then
    # Perform clean, dynamic regex replacements
    sed -i "s|username    = \".*\";|username    = \"$REAL_USER\";|" "$VARS_FILE"
    sed -i "s|hostName    = \".*\";|hostName    = \"$HOSTNAME\";|" "$VARS_FILE"
    sed -i "s|gitUsername = \".*\";|gitUsername = \"$GIT_NAME\";|" "$VARS_FILE"
    sed -i "s|gitEmail    = \".*\";|gitEmail    = \"$GIT_EMAIL\";|" "$VARS_FILE"
    sed -i "s|keyboardLayout  = \".*\";|keyboardLayout  = \"$KB_LAYOUT\";|" "$VARS_FILE"
    sed -i "s|timezone        = \".*\";|timezone        = \"$TZ\";|" "$VARS_FILE"
    success "Successfully customized hosts/nixos/variables.nix."
else
    error "variables.nix not found in hosts/nixos/. Variables update skipped!"
fi

# Disable SOPS if requested
if [[ "$DISABLE_SOPS" =~ ^[Yy]$ ]]; then
    if [ -f "$CONFIG_FILE" ]; then
        sed -i "s|config.flake.nixosModules.sops|# config.flake.nixosModules.sops|" "$CONFIG_FILE"
        success "Temporarily bypassed SOPS secrets for first system rebuild."
    else
        error "nixos-configurations.nix not found. Bypassing SOPS failed!"
    fi
fi

# Ensure correct file permissions/ownership in home directory
chown -R "$REAL_USER:users" "$TARGET_DIR"

# ------------------------------------------------------------------------------
# 6. Rebuild and Switch to the Configuration
# ------------------------------------------------------------------------------
echo ""
success "Setup preparation complete!"
info "You are ready to switch the system to the new nixHypr configuration."
warning "Make sure you are connected to the internet before continuing."
echo ""

question "Rebuild system and switch configurations? (y/n) [y]: "
read -r START_REBUILD
START_REBUILD=${START_REBUILD:-"y"}

if [[ ! "$START_REBUILD" =~ ^[Yy]$ ]]; then
    warning "Setup halted. You can manually rebuild the configuration at any time by running:"
    echo "  cd $TARGET_DIR"
    echo "  sudo nixos-rebuild switch --flake .#$HOSTNAME"
    exit 0
fi

info "Switching system configuration via nixos-rebuild..."
cd "$TARGET_DIR"
nixos-rebuild switch --flake ".#$HOSTNAME"

# ------------------------------------------------------------------------------
# 7. Finalize
# ------------------------------------------------------------------------------
echo ""
echo -e "${GREEN}=========================================================================${NC}"
echo -e "                      ${WHITE}BOOTSTRAPPING COMPLETE!${NC}"
echo -e "${GREEN}=========================================================================${NC}"
echo ""
success "System configuration applied successfully!"
info "Please reboot your system to load the full graphical user session and Hyprland!"
echo "  reboot"
echo ""
warning "Post-Reboot Secret Configuration Steps (if using SOPS):"
echo -e "  1. Setup your new SSH keys or age keys at ${WHITE}~/.ssh/id_ed25519${NC}."
echo -e "  2. Un-comment ${WHITE}config.flake.nixosModules.sops${NC} in modules/flake/nixos-configurations.nix."
echo -e "  3. Re-encrypt/update secrets to match your new key."
echo -e "  4. Apply the update: ${WHITE}sudo nixos-rebuild switch --flake ~/nixHypr#$HOSTNAME${NC}"
echo ""
