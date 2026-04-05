{ ... }:

{
  flake.nixosModules.git = { pkgs, ... }: {
    environment.systemPackages = [ pkgs.git ];
  };
}
