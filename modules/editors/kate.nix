{ ... }:

{
  flake.nixosModules.kate = { pkgs, ... }: {
    environment.systemPackages = [ pkgs.kdePackages.kate ];
  };
}
