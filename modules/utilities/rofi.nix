{ ... }:

{
  flake.nixosModules.rofi = { pkgs, ... }: {
    environment.systemPackages = [ pkgs.rofi ];
  };
}
