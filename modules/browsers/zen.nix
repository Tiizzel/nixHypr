{ inputs, ... }:

{
  flake.nixosModules.zen = { pkgs, ... }: {
    environment.systemPackages = [
      inputs.zen-browser.packages.${pkgs.system}.default
    ];
  };

  flake.homeModules.zen = { ... }: {
    home.file.".zen/17tvzomm.Default Profile/user.js".text = ''
      user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
    '';
  };
}
