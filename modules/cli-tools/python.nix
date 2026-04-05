{ ... }:

{
  flake.nixosModules.python = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      python3
      python3Packages.pip
      python3Packages.pygobject3
      python3Packages.screeninfo
      pywalfox-native
    ];
  };
}
