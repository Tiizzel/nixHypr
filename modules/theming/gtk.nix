{ ... }:

{
  flake.nixosModules.gtk = { pkgs, ... }: {
    programs.dconf.enable = true;

    environment.systemPackages = with pkgs; [
      lxappearance
      nwg-look
      kdePackages.breeze-gtk
      gnome-themes-extra
      adw-gtk3
      bibata-cursors
    ];
  };
}
