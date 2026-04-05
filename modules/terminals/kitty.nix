{ ... }:

{
  flake.nixosModules.kitty = { pkgs, ... }: {
    environment.systemPackages = [ pkgs.kitty ];
  };
}
