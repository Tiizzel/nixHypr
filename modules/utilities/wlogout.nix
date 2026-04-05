{ ... }:

{
  flake.nixosModules.wlogout = { pkgs, ... }: {
    environment.systemPackages = [ pkgs.wlogout ];
  };
}
