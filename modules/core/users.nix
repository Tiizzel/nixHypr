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
        config.flake.homeModules.symlinks
        config.flake.homeModules.firefox
        config.flake.homeModules.zen
        config.flake.homeModules.helium
        config.flake.homeModules.vesktop
        config.flake.homeModules.spicetify
        config.flake.homeModules.tclient
        config.flake.homeModules.runelite
        config.flake.homeModules.retroarch
        config.flake.homeModules.heroic
        config.flake.homeModules.cartridges
        config.flake.homeModules.atuin
        config.flake.homeModules.bat
        config.flake.homeModules.fzf
        config.flake.homeModules.git
        config.flake.homeModules.lazygit
        config.flake.homeModules.pay-respects
        config.flake.homeModules.zoxide
        config.flake.homeModules.home-packages
      ];
      home.stateVersion = "25.11";
    };
  };
}
