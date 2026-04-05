{ ... }:

{
  flake.nixosModules.firefox = { pkgs, ... }: {
    programs.firefox = {
      enable = true;
    };
  };

  flake.homeModules.firefox = { ... }: {
    programs.firefox = {
      enable = true;
      profiles.default = {
        isDefault = true;
        settings = {
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        };
      };
    };
  };
}
