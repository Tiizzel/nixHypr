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
      config.flake.nixosModules.locale
      config.flake.nixosModules.networking
      config.flake.nixosModules.nix-settings
      config.flake.nixosModules.users
      config.flake.nixosModules.fonts

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
      config.flake.nixosModules.dotfiles

      # Media
      config.flake.nixosModules.cava
      config.flake.nixosModules.vlc
      config.flake.nixosModules.images
      config.flake.nixosModules.background

      # Utilities
      config.flake.nixosModules.rofi
      config.flake.nixosModules.wlogout
      config.flake.nixosModules.screenshot
      config.flake.nixosModules.ocr
      config.flake.nixosModules.quickshell
    ];
  };
}
