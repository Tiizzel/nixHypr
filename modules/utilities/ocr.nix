{ ... }:

{
  flake.nixosModules.ocr = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      tesseract
    ];
  };
}
