{ inputs, ... }:

{
  flake.nixosModules.helium = { pkgs, ... }: {
    environment.systemPackages = [
      inputs.helium.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };

  flake.homeModules.helium = { ... }: { };
}
