{ inputs, config, ... }:

{
  flake.nixosModules.users = { pkgs, hostVars, ... }: {
    users.defaultUserShell = pkgs.zsh;
    users.users.${hostVars.username} = {
      isNormalUser = true;
      description = "Tiizzel";
      extraGroups = [ "networkmanager" "wheel" "video" "audio" "lp" "scanner" "input" "bluetooth" ];
      shell = pkgs.zsh;
    };

    home-manager.users.${hostVars.username} = { pkgs, ... }: {
      imports = [
        config.flake.homeModules.zsh
        config.flake.homeModules.plasma
        config.flake.homeModules.dotfiles
        config.flake.homeModules.firefox
        config.flake.homeModules.zen
      ];
      home.stateVersion = "25.11";
    };
  };
}
