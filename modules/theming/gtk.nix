{ ... }:

{
  flake.nixosModules.gtk = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      lxappearance
      nwg-look
      kdePackages.breeze-gtk
      gnome-themes-extra
      adw-gtk3
    ];
  };
}
