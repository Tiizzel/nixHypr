{ ... }:

{
  flake.homeModules.runelite = { pkgs, ... }: {
    home.packages = with pkgs; [
      runelite
    ];
  };
}
