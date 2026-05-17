{ inputs, config, ... }:

{
  flake.nixosModules.services = { pkgs, ... }: {
    services = {
      upower.enable = true; # noctalia/quickshell battery reporting
      libinput.enable = true; # Input Handling
      fstrim.enable = true; # SSD Optimizer
      gvfs.enable = true; # For Mounting USB & More
      openssh = {
        enable = true; # Enable SSH
        settings = {
          PermitRootLogin = "no"; # Prevent root from SSH login
          PasswordAuthentication = true; # Users can SSH using keyboard and password
          KbdInteractiveAuthentication = true;
        };
        authorizedKeysFiles = [ "%h/.ssh/authorized_keys" config.sops.secrets.sshAuthorizedKey.path ];
        ports = [22];
      };
      gnome.gnome-keyring.enable = true;
    };

    # Enable SSH agent system-wide to manage your SSH keys
    programs.ssh.startAgent = true;
  };
}
