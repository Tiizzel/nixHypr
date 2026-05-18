{ ... }:

{
  flake.homeModules.tclient = { pkgs, config, lib, ... }: {
    home.packages = with pkgs; [
      taterclient-ddnet
    ];

    # Desktop entry so it shows up in your App Launcher
    xdg.desktopEntries.tclient = {
      name = "TaterClient";
      genericName = "Teeworlds / DDNet Client";
      exec = "systemd-cat -t tclient TaterClient-DDNet";
      icon = "ddnet";
      categories = [ "Game" ];
      terminal = false;
    };

    # Writable symlink for DDNet configuration
    home.file.".local/share/ddnet".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/ddnet-data";
  };
}
