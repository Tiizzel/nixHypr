{ ... }:

{
  flake.nixosModules.sddm = { pkgs, ... }:
    let
      sddm-astronaut-theme = pkgs.stdenv.mkDerivation {
        name = "sddm-astronaut-theme";
        src = ../../dotfiles/sddm;
        installPhase = ''
          mkdir -p $out/share/sddm/themes/sddm-astronaut-theme
          cp -aR * $out/share/sddm/themes/sddm-astronaut-theme
        '';
      };
    in
    {
      services.displayManager.sddm = {
        enable = true;
        wayland.enable = true;
        theme = "sddm-astronaut-theme";
        extraPackages = with pkgs; [
          sddm-astronaut-theme
          kdePackages.qt5compat
          kdePackages.qtdeclarative
          kdePackages.qtsvg
          kdePackages.qtmultimedia
          kdePackages.qtvirtualkeyboard
        ];
      };

      environment.systemPackages = [
        sddm-astronaut-theme
      ];
    };
}
