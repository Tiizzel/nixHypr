{ ... }:

{
  flake.nixosModules.yazi = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      yazi
      ffmpegthumbnailer
    ];
  };
}
