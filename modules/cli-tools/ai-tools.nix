{ inputs, ... }:

{
  flake.nixosModules.ai-tools = { pkgs, ... }:
    {
      environment.systemPackages = [
        pkgs.antigravity-cli
        pkgs.claude-code
      ];
    };
}
