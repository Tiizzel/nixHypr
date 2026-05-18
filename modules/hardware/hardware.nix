{ ... }:

{
  flake.nixosModules.hardware = { pkgs, ... }: {
    hardware = {
      sane = {
        enable = true;
        extraBackends = [ pkgs.sane-airscan ];
        disabledDefaultBackends = [ "escl" ];
      };
      logitech.wireless.enable = false;
      logitech.wireless.enableGraphical = false;
      enableRedistributableFirmware = true;
      keyboard.qmk.enable = true;
    };
  };
}
