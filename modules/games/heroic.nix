{ ... }:

{
  flake.homeModules.heroic = { pkgs, ... }: {
    home.packages = with pkgs; [
      heroic
    ];
  };
}
