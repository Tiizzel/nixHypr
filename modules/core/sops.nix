{ inputs, config, ... }:

{
  flake.nixosModules.sops = { pkgs, hostVars, ... }: {
    imports = [
      inputs.sops-nix.nixosModules.sops
    ];

    # Install CLI tools for managing secrets
    environment.systemPackages = [
      pkgs.sops
      pkgs.age
    ];

    sops = {
      defaultSopsFile = ../../secrets/secrets.yaml;
      age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      secrets.sshAuthorizedKey = { neededForUsers = true; };
      secrets.githubSshKey = {
        path = "/home/${hostVars.username}/.ssh/id_ed25519";
        owner = hostVars.username;
        mode = "0600";
      };
    };
  };
}
