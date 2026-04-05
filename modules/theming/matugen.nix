{ inputs, ... }:

{
  flake.nixosModules.matugen = { pkgs, ... }: {
    environment.systemPackages = [
      inputs.matugen.packages.${pkgs.stdenv.hostPlatform.system}.default
      pkgs.imagemagick
    ];
  };
}
