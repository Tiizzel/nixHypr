{ ... }:

{
  flake.nixosModules.nautilus = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      nautilus
      udiskie
      gnome-disk-utility
      ntfs3g
      libmtp
      file-roller
    ];

    services.gvfs.enable = true;
    services.udisks2.enable = true;
    services.tumbler.enable = true;
  };
}
