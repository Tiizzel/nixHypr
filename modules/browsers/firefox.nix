{ ... }:

{
  flake.nixosModules.firefox = { pkgs, ... }: {
    programs.firefox = {
      enable = true;
      #nativeMessagingHosts.packages = [ pkgs.pywalfox-native ];
    };
  };
}
