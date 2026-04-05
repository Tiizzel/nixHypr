{ ... }:

{
  flake.nixosModules.images = { pkgs, ... }: {
    environment.systemPackages = [ pkgs.loupe ];
  };
}
