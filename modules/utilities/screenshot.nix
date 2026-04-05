{ ... }:

{
  flake.nixosModules.screenshot = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      grim
      slurp
      swappy
    ];
  };
}
