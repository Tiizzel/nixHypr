{ ... }:

{
  flake.nixosModules.boot = { pkgs, lib, hostVars, ... }:
    let
      grub-mojave-theme = pkgs.stdenv.mkDerivation {
        name = "grub-mojave-theme";
        src = ../../dotfiles/grub/themes/Elegant-mojave-float-right-dark;
        installPhase = ''
          mkdir -p $out
          cp -aR * $out
        '';
      };
    in {
      boot.loader.systemd-boot.enable = hostVars.bootloader == "systemd-boot";
      boot.loader.grub = {
        enable = hostVars.bootloader == "grub";
        devices = [ "nodev" ];
        efiSupport = true;
        useOSProber = true;
        gfxmodeEfi = hostVars.grubResolution;
        gfxmodeBios = hostVars.grubResolution;
        theme = lib.mkIf (hostVars.grubTheme == "mojave") grub-mojave-theme;
      };
      boot.loader.efi.canTouchEfiVariables = true;
      boot.kernelPackages = pkgs.linuxPackages_zen;
    };
}
