{ ... }:

{
  flake.nixosModules.cava = { pkgs, ... }: {
    environment.systemPackages = [ pkgs.cava ];
  };
}
