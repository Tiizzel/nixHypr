{ ... }:

{
  flake.homeModules.home-packages = { pkgs, ... }: {
    home.packages = with pkgs; [
      # Install user-specific (home) packages here
      gimp
    ];
  };
}
