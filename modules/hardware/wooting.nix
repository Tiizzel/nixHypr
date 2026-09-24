{ ... }:

{
  flake.nixosModules.wooting = { pkgs, ... }: {
    hardware.wooting.enable = true;

    environment.systemPackages = with pkgs; [
      wootility
    ];
  };
}
