{ ... }:

{
  flake.nixosModules.networking = { pkgs, ... }: {
    networking.networkmanager.enable = true;
    environment.systemPackages = [
      pkgs.networkmanagerapplet
      pkgs.localsend
    ];
  };
}
