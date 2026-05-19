{ ... }:

{
  flake.nixosModules.host-packages = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      # Install system-wide (host) packages here
      bitwarden-desktop
      brave
      qbittorrent
    ];
  };
}
