{ ... }:

{
  flake.nixosModules.nordvpn = { pkgs, ... }: {
    environment.systemPackages = [ pkgs.nordvpn ];

    systemd.services.nordvpnd = {
      description = "NordVPN daemon";
      wants = [ "network-online.target" ];
      after = [ "network-online.target" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        ExecStart = "${pkgs.nordvpn}/bin/nordvpnd";
        NonBlocking = true;
        KillMode = "process";
        Restart = "on-failure";
        RestartSec = 5;
      };
    };
  };
}
