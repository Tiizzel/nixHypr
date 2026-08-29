{ ... }:

{
  flake.nixosModules.qt = { pkgs, ... }: {
    qt = {
      enable = true;
      platformTheme = "qt5ct";
      style = "kvantum";
    };

    environment.systemPackages = with pkgs; [
      libsForQt5.qt5ct
      qt5.qtwayland
      kdePackages.qt6ct
      kdePackages.qtwayland
      kdePackages.qtsvg
      kdePackages.qtmultimedia
      kdePackages.qtvirtualkeyboard
      libsForQt5.qtstyleplugin-kvantum
      kdePackages.qtstyleplugin-kvantum
    ];
  };
}
