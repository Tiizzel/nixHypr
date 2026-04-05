{ ... }:

{
  flake.nixosModules.general-tools = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      curl
      rsync
      unzip
      gnutar
      file-roller
      jq
      flatpak
      inotify-tools
      htop
      xclip
      fzf
      cargo
      eza
      libnotify
      imagemagick
      xdg-user-dirs
      figlet
    ];

    services.flatpak.enable = true;
  };
}
