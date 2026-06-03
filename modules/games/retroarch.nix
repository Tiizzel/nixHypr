{ ... }:

{
  flake.homeModules.retroarch = { pkgs, ... }: {
    home.packages = with pkgs; [
      retroarch-full
    ];
  };
}
