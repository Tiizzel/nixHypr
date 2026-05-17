{ inputs, config, ... }:

let
  hostVars = import ../../hosts/nixos/variables.nix;
in
{
  flake.nixosConfigurations.nixos = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs hostVars; };
    modules = [
      { nixpkgs.hostPlatform = "x86_64-linux"; }
      # Host-specific configuration
      ../../hosts/nixos

      # Home-manager as NixOS module
      inputs.home-manager.nixosModules.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          backupFileExtension = "backup";
          extraSpecialArgs = { inherit inputs hostVars; };
        };
      }

      # Core modules
      config.flake.nixosModules.boot
      config.flake.nixosModules.drivers
      config.flake.nixosModules.locale
      config.flake.nixosModules.networking
      config.flake.nixosModules.nix-settings
      config.flake.nixosModules.cachix
      config.flake.nixosModules.users
      config.flake.nixosModules.fonts
      config.flake.nixosModules.nh
      config.flake.nixosModules.services
      config.flake.nixosModules.sops

      # Desktops
      config.flake.nixosModules.plasma
      config.flake.nixosModules.hyprland

      # Hardware
      config.flake.nixosModules.audio
      config.flake.nixosModules.printing
      config.flake.nixosModules.bluetooth
      config.flake.nixosModules.power

      # Shells
      config.flake.nixosModules.zsh

      # Terminals
      config.flake.nixosModules.kitty

      # Editors
      config.flake.nixosModules.antigravity
      config.flake.nixosModules.vim
      config.flake.nixosModules.zed
      config.flake.nixosModules.kate
      config.flake.nixosModules.neovim
      config.flake.nixosModules.gnome-text-editor

      # File managers
      config.flake.nixosModules.thunar
      config.flake.nixosModules.nautilus

      # Browsers
      config.flake.nixosModules.firefox
      config.flake.nixosModules.zen

      # CLI tools
      config.flake.nixosModules.git
      config.flake.nixosModules.wget
      config.flake.nixosModules.ai-tools
      config.flake.nixosModules.btop
      config.flake.nixosModules.fastfetch
      config.flake.nixosModules.yazi
      config.flake.nixosModules.general-tools
      config.flake.nixosModules.python

      # Theming
      config.flake.nixosModules.matugen
      config.flake.nixosModules.gtk
      config.flake.nixosModules.qt
      config.flake.nixosModules.symlinks

      # Media
      config.flake.nixosModules.cava
      config.flake.nixosModules.vlc
      config.flake.nixosModules.images
      config.flake.nixosModules.background
      config.flake.nixosModules.vesktop
      config.flake.nixosModules.spicetify

      # Games
      config.flake.nixosModules.gaming-support
      config.flake.nixosModules.steam

      # Utilities
      config.flake.nixosModules.rofi
      config.flake.nixosModules.wlogout
      config.flake.nixosModules.screenshot
      config.flake.nixosModules.ocr
      config.flake.nixosModules.quickshell
    ];
  };
}
