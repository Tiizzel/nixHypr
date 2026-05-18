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
      configPath = ".mozilla/firefox";
      profiles.default = {
        isDefault = true;
        settings = {
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        };
      };
    };
  };
}
