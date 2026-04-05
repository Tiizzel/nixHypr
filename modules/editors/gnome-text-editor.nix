{ ... }:

{
  flake.nixosModules.gnome-text-editor = { pkgs, ... }: {
    environment.systemPackages = [ pkgs.gnome-text-editor ];
  };
}
