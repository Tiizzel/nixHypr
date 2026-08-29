{ ... }:

{
  flake.nixosModules.nordvpn = { pkgs, ... }: {
    environment.systemPackages = [ pkgs.nordvpn ];
    services.nordvpn.enable = true;
  };
}
