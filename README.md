# nixHypr - NixOS & Hyprland Configuration

This is my personal NixOS and Hyprland configuration. It is built using Nix Flakes (`flake-parts`), `import-tree` for automatic module discovery, and symlinks dotfiles out-of-store using Home-Manager so they update immediately without a full system rebuild.

It was originally ported from Stephan Raabe's **ML4W** Hyprland configuration, and I've since rewritten and modularized it to fit NixOS.

---

## 🎨 Theme & Styling
The desktop environment uses a glassmorphic look. Everything (Vesktop, Kitty, Spicetify, Hyprland, etc.) is dynamically themed using **Matugen** based on the current wallpaper.

*   **Top Bar & Widgets:** Driven by **Quickshell** (adapted from **ilyamiro**'s QML configs) with an option to use **Waybar**.
*   **Wallpaper Picker & Sessions:** Native QML popups built into the shell.

---

## 💻 Tech Stack & Specs

| Component | Software | Description |
|---|---|---|
| **OS** | NixOS (Unstable) | Declarative package management |
| **Compositor** | Hyprland (lua) | Wayland tiling window manager |
| **Widgets & Panel** | Quickshell / Waybar | Configurable status bar and shell widgets |
| **Colors / Theme** | Matugen | Dynamic Material You theme generator |
| **Terminal** | Kitty | GPU-accelerated terminal emulator |
| **Shell** | Zsh / Fish | Custom prompts using Oh My Posh |
| **File Manager** | Thunar / Nautilus / Yazi | Graphical and terminal-based file managers |
| **Text Editor** | Neovim / Zed | My primary text editors |
| **Secrets** | sops-nix | For decrypting SSH keys and other secrets securely |
| **Rebuild Helper**| nh | A CLI wrapper for building/cleaning the system |

---

## 🛠️ How to Install (Fresh Install)

I wrote an interactive bash script to handle setting up this configuration on a fresh NixOS install. 

### 1. Install NixOS
Do a standard, clean installation of NixOS on your computer (using the default installer) and boot into it.

### 2. Run the Installer Script
Open a terminal in your new system and run the following command. The script will ask for your preferred username, hostname, git details, clone the repo to your home directory, copy your hardware config over, and rebuild the system:

```bash
curl -sL https://raw.githubusercontent.com/Tiizzel/nixHypr/main/install.sh | sudo bash
```

Alternatively, you can clone the repository manually and run it:
```bash
git clone https://github.com/Tiizzel/nixHypr.git ~/nixHypr
cd ~/nixHypr
sudo ./install.sh
```

---

## 📂 Repository Structure

The project has a dendritic layout for module imports:

```
├── flake.nix                  # Flake entry point (calls import-tree)
├── install.sh                 # Post-boot interactive system bootstrapper
├── hosts/
│   └── nixos/
│       ├── default.nix        # Target host configuration imports
│       ├── hardware.nix       # Your system's generated hardware-configuration.nix
│       └── variables.nix      # Custom variables (username, hostname, timezone, etc.)
├── dotfiles/                  # Raw config files (hypr, kitty, waybar, matugen)
│                              # Symlinked out-of-store so they update instantly
├── modules/                   # Auto-discovered modules
│   ├── core/                  # Core options (users, boot, network, locale, sops)
│   ├── desktops/              # Desktop environment modules (hyprland, plasma)
│   ├── theming/               # GTK, Qt, Matugen, Symlinks setup
│   └── [browsers, cli-tools, editors, file-managers, shells...]
└── secrets/                   # Encrypted secrets managed by sops-nix
```

---

## ⚙️ Customization

### Central Variables
You can configure your settings in [hosts/nixos/variables.nix](file:///home/tiizzel/nixHypr/hosts/nixos/variables.nix) without having to dig through system modules:

```nix
username       = "your-username";
hostName       = "your-hostname";
keyboardLayout = "de";
timezone       = "Europe/Berlin";
barChoice      = "noctalia";      # Set to "noctalia" (Quickshell) or "waybar"
```

### Live Dotfiles Editing
Since dotfiles are symlinked out-of-store, any changes you make to configurations inside `dotfiles/` (like `dotfiles/hypr/autostart.lua` or keybindings) will apply **immediately** when you save the file. No rebuild is needed.

### System-level Rebuilds
For any Nix option additions or system package installs, run:
```bash
sudo nixos-rebuild switch --flake ~/nixHypr#<your-hostname>
```

---

## 🔐 SOPS & Secrets Setup

This setup uses `sops-nix` to decrypt my GitHub SSH key to `~/.ssh/id_ed25519` using the machine's host SSH key.

To use it after a fresh install:
1. Put your SSH/Age keys at `~/.ssh/id_ed25519`.
2. Un-comment `config.flake.nixosModules.sops` in [nixos-configurations.nix](file:///home/tiizzel/nixHypr/modules/flake/nixos-configurations.nix).
3. Re-encrypt or add your new SSH host keys to `.sops.yaml` and update the secret via `sops secrets/secrets.yaml`.
4. Rebuild the system:
   ```bash
   sudo nixos-rebuild switch --flake ~/nixHypr#<your-hostname>
   ```

---

## 🤝 Credits

*   **[ML4W (Stephan Raabe)](https://github.com/mylinuxforwork)** - This configuration was originally ported from his fantastic ML4W Hyprland setup and then adapted into a modular NixOS flake.
*   **[ilyamiro (Ilya Miroshnik)](https://github.com/ilyamiro)** - The Quickshell topbar panel, session menus, application launcher, and workspace overview widgets are adapted from his QML configurations.
*   **[flake-parts](https://github.com/hercules-ci/flake-parts)** & **[import-tree](https://github.com/vic/import-tree)** - Used to easily discover and structure all Nix modules automatically.
