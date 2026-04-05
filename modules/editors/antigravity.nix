{ ... }:

{
  flake.nixosModules.antigravity = { pkgs, ... }: {
    environment.systemPackages = [ pkgs.antigravity ];
  };
}
