{ ... }:

{
  flake.nixosModules.vesktop = { pkgs, ... }: {
    environment.systemPackages = [ pkgs.vesktop ];
  };

  flake.homeModules.vesktop = { config, hostVars, ... }: {
    xdg.configFile."vesktop/themes/matugen.css".source = config.lib.file.mkOutOfStoreSymlink "/home/${hostVars.username}/nixHypr/dotfiles/vesktop/matugen.css";
  };
}
