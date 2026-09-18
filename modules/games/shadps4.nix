{ ... }:

{
  flake.homeModules.shadps4 = { pkgs, ... }: {
    home.packages = with pkgs; [
      shadps4
      shadps4-qtlauncher
    ];
  };
}
