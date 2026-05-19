{ ... }:

{
  flake.nixosModules.vesktop = { pkgs, ... }: {
    environment.systemPackages = [ pkgs.vesktop ];
  };

  flake.homeModules.vesktop = { ... }: { };
}
