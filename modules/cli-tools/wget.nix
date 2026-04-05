{ ... }:

{
  flake.nixosModules.wget = { pkgs, ... }: {
    environment.systemPackages = [ pkgs.wget ];
  };
}
