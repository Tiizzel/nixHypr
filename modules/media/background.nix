{ ... }:

{
  flake.nixosModules.background = { pkgs, ... }: {
    environment.systemPackages = [ pkgs.awww ];
  };
}
