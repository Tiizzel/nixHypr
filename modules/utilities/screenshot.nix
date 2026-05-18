{ pkgs, ... }:

{
  flake.nixosModules.screenshot = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      grim
      satty
      wl-clipboard
      gpu-screen-recorder
      pulseaudio # for pactl
      zbar       # for zbarimg (QR scans)
      python3    # python3 standard library scanner
    ];
  };
}
