{ ... }:

{
  flake.nixosModules.steam = { pkgs, lib, hostVars, ... }: let
    steamEnable = hostVars.steamEnable or (hostVars.gamingSupportEnable or false);
  in
  lib.mkIf steamEnable {
    programs = {
      steam = {
        enable = true;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = false;
        gamescopeSession.enable = true;
        extraCompatPackages = [ pkgs.proton-ge-bin ];
      };

      gamescope = {
        enable = true;
        capSysNice = false; # TODO: re-enable once nixpkgs fixes bubblewrap setuid regression (#523200)
        args = [
          "--rt"
          "--expose-wayland"
        ];
      };
    };
  };
}
