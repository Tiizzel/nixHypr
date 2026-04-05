{ ... }:

{
  flake.nixosModules.power = { ... }: {
    services.power-profiles-daemon.enable = true;
  };
}
