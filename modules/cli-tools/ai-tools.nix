{ inputs, ... }:

{
  flake.nixosModules.ai-tools = { pkgs, ... }:
    let
      stablePkgs = import inputs.nixpkgs-stable {
        system = pkgs.stdenv.hostPlatform.system;
        config.allowUnfree = true;
      };
    in
    {
      environment.systemPackages = [
        pkgs.gemini-cli
        stablePkgs.claude-code
      ];
    };
}
