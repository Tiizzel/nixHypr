{ ... }:

{
  flake.homeModules.pay-respects = { pkgs, ... }: {
    programs.pay-respects = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
    };
  };
}
