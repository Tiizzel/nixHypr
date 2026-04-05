{ inputs, config, ... }:

{
  flake.nixosModules.users = { pkgs, ... }: {
    users.users.tiizzel = {
      isNormalUser = true;
      description = "Tiizzel";
      extraGroups = [ "networkmanager" "wheel" "video" "audio" "lp" "scanner" "input" "bluetooth" ];
    };

    home-manager.users.tiizzel = { pkgs, ... }: {
      imports = [
        config.flake.homeModules.zsh
        config.flake.homeModules.plasma
        config.flake.homeModules.dotfiles
      ];
      home.stateVersion = "25.11";
    };
  };
}
