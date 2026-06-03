{ ... }:

{
  flake.homeModules.cartridges = { pkgs, ... }: {
    home.packages = with pkgs; [
      cartridges
    ];
  };
}
