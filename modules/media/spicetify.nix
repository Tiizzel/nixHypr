{ inputs, ... }:

{
  flake.nixosModules.spicetify = { pkgs, ... }: {
    # System-level settings if any
  };

  flake.homeModules.spicetify = { config, pkgs, ... }: {
    imports = [ inputs.spicetify-nix.homeManagerModules.default ];
    programs.spicetify = {
      enable = true;
      theme = {
        name = "Matugen";
        src = ../../dotfiles/spicetify/Matugen;
      };
    };
  };
}
