# 🌌 nixHypr

A premium, highly modular, personal **NixOS & Hyprland** configuration built using modern Nix Flakes (`flake-parts`), dendritic module auto-discovery (`import-tree`), and out-of-store dotfile symlinks for hot-reloading configurations.

Originally ported from the exceptional **ML4W (My Linux for Work)** Hyprland environment, then completely rewritten and modernized to be 100% declarative, modular, and dynamic.

---

## 🎨 Preview & Styling

The environment features a gorgeous glassmorphic theme designed to wow at first glance. All interface elements, system panels, wallpapers, and application themes (like Vesktop, Kitty, Spicetify, and Zed) are dynamically themed on the fly using **Matugen** (Material You color generation).

| Panel Choices | System View | Matugen Colors |
|:---:|:---:|:---:|
| **Quickshell (Noctalia)** | Sleek Glassmorphism | Automated Material Palette |

---

## 🚀 Tech Stack & Specifications

| Component | Technology | Description |
|---|---|---|
| **Operating System** | [NixOS](https://nixos.org/) | Declarative, reproducible Linux distribution |
| **Window Manager** | [Hyprland](https://hyprland.org/) | Dynamic tiling Wayland compositor with smooth animations |
| **User Panels & Shell** | [Quickshell](https://github.com/outfoxxed/quickshell) | QML-based, blazing-fast native panel and widget suite |
| **Alternative Panel** | [Waybar](https://github.com/Alexays/Waybar) | Customizable GTK-based status bar |
| **Dynamic Themes** | [Matugen](https://github.com/InioX/matugen) | Automated Material You color theme generation |
| **Terminal** | [Kitty](https://sw.kovidgoyal.net/kitty/) | GPU-accelerated terminal emulator |
| **Shell Interpreter** | [Zsh](https://www.zsh.org/) / [Fish](https://fishshell.com/) | Interactive shells customized with [Oh My Posh](https://ohmyposh.dev/) |
| **File Managers** | [Thunar](https://docs.xfce.org/xfce/thunar/start) / [Yazi](https://github.com/sxyazi/yazi) | Modern GUI and terminal-based file managers |
| **Text Editor** | Neovim / Zed | Highly productive modern editors |
| **Secret Management**| [sops-nix](https://github.com/Mic92/sops-nix) | Decrypted Age/SSH-based secrets (SSH keys, tokens) |
| **Package Helper** | [nh](https://github.com/viperML/nh) | Clean, premium Nix helper for building and cleaning |

---

## 🛠️ Bootstrapping & Installation

We have built a fully dynamic, interactive installer script to make installing this configuration on a fresh system incredibly simple.

### 1. Fresh NixOS Installation
Install a standard NixOS installation onto your computer (using the graphical NixOS Calamares installer ISO). Boot into your fresh system.

### 2. Run the Bootstrap Script
Open a terminal in your booted system and run the installer script. It will ask for your custom details, clone the repository, replace configurations dynamically, copy your active hardware details, and apply the config!

```bash
# Execute the nixHypr bootstrapper directly:
curl -sL https://raw.githubusercontent.com/Tiizzel/nixHypr/main/install.sh | sudo bash
```

Alternatively, you can clone your repository first and execute the local script:
```bash
git clone https://github.com/Tiizzel/nixHypr.git ~/nixHypr
cd ~/nixHypr
sudo ./install.sh
```

---

## 📂 Repository Architecture

This configuration utilizes a modular **Dendritic Pattern** for auto-discovery of settings:

```
├── flake.nix                  # Flake entry point (uses import-tree)
├── install.sh                 # Post-boot interactive system bootstrapper
├── hosts/
│   └── nixos/
│       ├── default.nix        # Host entrypoint
│       ├── hardware.nix       # Baseline hardware configuration (auto-replaced on install)
│       └── variables.nix      # Host customization (username, hostname, timezone)
├── dotfiles/                  # Raw config files (hypr, kitty, matugen, waybar)
│                              # Symlinked out-of-store to allow live, instant reloads
├── modules/                   # Auto-discovered modular configuration blocks
│   ├── core/                  # Core modules (users, boot, network, locale, sops)
│   ├── desktops/              # Desktop environments (hyprland, plasma)
│   ├── theming/               # GTK, Qt, Matugen, Symlinks setup
│   └── [browsers, cli-tools, editors, file-managers, shells...]
└── secrets/                   # Encrypted yaml secrets managed by SOPS
```

---

## ⚙️ Customization & Tweaking

### Custom Variables
All host-level parameters are central and customizable in [hosts/nixos/variables.nix](file:///home/tiizzel/nixHypr/hosts/nixos/variables.nix). Adjust these to match your new system parameters:

```nix
username       = "your-username";
hostName       = "your-hostname";
keyboardLayout = "de";
timezone       = "Europe/Berlin";
barChoice      = "noctalia";      # Choose "noctalia" for QML or "waybar"
```

### Out-of-Store Dotfile Symlinks
Because your configuration utilizes out-of-store symlinks (`config.lib.file.mkOutOfStoreSymlink`), any modifications made inside the cloned directory's `dotfiles/` folder (such as Hyprland keybinds, autostart, or CSS rules) **take effect immediately** without requiring a system rebuild!

### Rebuilding Manually
If you make system-level changes (such as adding Nix packages or system options):
```bash
sudo nixos-rebuild switch --flake ~/nixHypr#<your-hostname>
```

---

## 🔐 Secrets & SOPS Setup

The configuration utilizes `sops-nix` to securely decrypt private files (like your GitHub SSH key) at `/home/<username>/.ssh/id_ed25519` using the system's host key.

To activate your encrypted secrets after your first boot:
1. Provision your SSH keys or age keys at `~/.ssh/id_ed25519`.
2. Un-comment `config.flake.nixosModules.sops` in [nixos-configurations.nix](file:///home/tiizzel/nixHypr/modules/flake/nixos-configurations.nix).
3. Re-encrypt or add your new system's SSH keys to `.sops.yaml` and run `sops secrets/secrets.yaml` to update the secret encryption.
4. Run a system rebuild:
   ```bash
   sudo nixos-rebuild switch --flake ~/nixHypr#<your-hostname>
   ```

---

## 🤝 Credits & Shoutouts

* **[ML4W (Stephan Raabe)](https://github.com/mylinuxforwork)** - The original inspiration. Ported from their brilliant, highly polished Hyprland structure, and adapted to run natively as a declarative NixOS flake.
* **[ilyamiro (Ilya Miroshnik)](https://github.com/ilyamiro)** - The outstanding, glassmorphic QML topbar, native session menus, QML application launchers, and workspace widgets are heavily inspired and adapted from their magnificent QuickShell configurations.
* **[flake-parts](https://github.com/hercules-ci/flake-parts)** & **[import-tree](https://github.com/vic/import-tree)** - For enabling a clean, modular structure with automatic module discovery.

---

<p align="center">
  <i>Declutter, Declarative, Dynamic. Powered by NixOS ❄️</i>
</p>
