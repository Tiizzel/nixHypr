{ ... }:

{
  flake.nixosModules.nh = { pkgs, hostVars, ... }: {
    programs.nh = {
      enable = true;
      clean = {
        enable = true;
        extraArgs = "--keep-since 7d --keep 5";
      };
      flake = "/home/${hostVars.username}/nixHypr";
    };

    environment.systemPackages = with pkgs; [
      nix-output-monitor
      nvd
    ];
  };
}
