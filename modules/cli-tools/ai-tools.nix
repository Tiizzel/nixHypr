{ inputs, ... }:

{
  flake.nixosModules.ai-tools = { pkgs, ... }:
    {
      environment.systemPackages = [
        pkgs.gemini-cli
        pkgs.claude-code
      ];
    };
}
