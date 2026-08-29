{ ... }:

{
  flake.nixosModules.host-packages = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      # Install system-wide (host) packages here
      # bitwarden-desktop
      brave
      mcp-nixos
      lutris
      nix-search
      qbittorrent
    ];

    nixpkgs.config.permittedInsecurePackages = [
      "electron-39.8.10"
    ];
  };
}
