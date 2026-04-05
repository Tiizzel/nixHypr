{ ... }:

{
  flake.nixosModules.plasma = { ... }: {
    services.xserver.enable = true;
    services.displayManager.sddm.enable = true;
    services.desktopManager.plasma6.enable = true;

    services.xserver.xkb = {
      layout = "de";
      variant = "";
    };

    console.keyMap = "de";
  };

  flake.homeModules.plasma = { ... }: {
    # KDE Plasma home-manager config (themes, shortcuts, etc.)
  };
}
