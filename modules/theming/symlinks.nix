{ ... }:

{
  flake.nixosModules.symlinks = { ... }: {
    # System-level symlinks configuration
  };

  flake.homeModules.symlinks = { config, hostVars, ... }:
    let
      d = "/home/${hostVars.username}/nixHypr/dotfiles";
    in {
      home.file = {
        ".bashrc".source = config.lib.file.mkOutOfStoreSymlink "${d}/.bashrc";
        ".gtkrc-2.0".source = config.lib.file.mkOutOfStoreSymlink "${d}/.gtkrc-2.0";
        ".Xresources".source = config.lib.file.mkOutOfStoreSymlink "${d}/.Xresources";
        "Pictures/Wallpapers".source = config.lib.file.mkOutOfStoreSymlink "${d}/Wallpapers";

        # Firefox userChrome/userContent
        ".mozilla/firefox/default/chrome".source = config.lib.file.mkOutOfStoreSymlink "${d}/firefox/chrome";

        # Zen Browser userChrome/userContent
        ".zen/17tvzomm.Default Profile/chrome".source = config.lib.file.mkOutOfStoreSymlink "${d}/zen/chrome";
      };

      xdg.configFile = {
        "nixHypr-bar-choice".text = hostVars.barChoice;
        "bashrc".source = config.lib.file.mkOutOfStoreSymlink "${d}/bashrc";
        "btop".source = config.lib.file.mkOutOfStoreSymlink "${d}/btop";
        "chromium-flags.conf".source = config.lib.file.mkOutOfStoreSymlink "${d}/chromium-flags.conf";
        "edge-flags.conf".source = config.lib.file.mkOutOfStoreSymlink "${d}/edge-flags.conf";
        "fastfetch".source = config.lib.file.mkOutOfStoreSymlink "${d}/fastfetch";
        "fish".source = config.lib.file.mkOutOfStoreSymlink "${d}/fish";
        "gtk-3.0".source = config.lib.file.mkOutOfStoreSymlink "${d}/gtk-3.0";
        "gtk-4.0".source = config.lib.file.mkOutOfStoreSymlink "${d}/gtk-4.0";
        "hypr".source = config.lib.file.mkOutOfStoreSymlink "${d}/hypr";
        "kitty".source = config.lib.file.mkOutOfStoreSymlink "${d}/kitty";
        "matugen".source = config.lib.file.mkOutOfStoreSymlink "${d}/matugen";
        "nixHypr".source = config.lib.file.mkOutOfStoreSymlink "${d}/nixHypr";
        "nwg-dock-hyprland".source = config.lib.file.mkOutOfStoreSymlink "${d}/nwg-dock-hyprland";
        "ohmyposh".source = config.lib.file.mkOutOfStoreSymlink "${d}/ohmyposh";
        "qt6ct".source = config.lib.file.mkOutOfStoreSymlink "${d}/qt6ct";
        "quickshell".source = config.lib.file.mkOutOfStoreSymlink "${d}/quickshell";
        "rofi".source = config.lib.file.mkOutOfStoreSymlink "${d}/rofi";
        "sidepad".source = config.lib.file.mkOutOfStoreSymlink "${d}/sidepad";
        "swaync".source = config.lib.file.mkOutOfStoreSymlink "${d}/swaync";
        "vim".source = config.lib.file.mkOutOfStoreSymlink "${d}/vim";
        "walker".source = config.lib.file.mkOutOfStoreSymlink "${d}/walker";
        "waybar".source = config.lib.file.mkOutOfStoreSymlink "${d}/waybar";
        "waypaper".source = config.lib.file.mkOutOfStoreSymlink "${d}/waypaper";
        "wlogout".source = config.lib.file.mkOutOfStoreSymlink "${d}/wlogout";
        "xsettingsd".source = config.lib.file.mkOutOfStoreSymlink "${d}/xsettingsd";
        "zshrc".source = config.lib.file.mkOutOfStoreSymlink "${d}/zshrc";
        "zed/themes".source = config.lib.file.mkOutOfStoreSymlink "${d}/zed/themes";
        "Antigravity/User/settings.json".source = config.lib.file.mkOutOfStoreSymlink "${d}/antigravity/settings.json";
      };
    };
}
