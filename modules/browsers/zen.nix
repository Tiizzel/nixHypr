{ inputs, ... }:

{
  flake.nixosModules.zen = { pkgs, ... }: {
    environment.systemPackages = [
      inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };

  flake.homeModules.zen = { ... }: {
    home.file.".zen/aiodjulf.Default Profile/user.js".text = ''
      user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
    '';
  };
}
