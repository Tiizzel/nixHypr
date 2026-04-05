{ ... }:

{
  flake.nixosModules.zsh = { pkgs, ... }: {
    programs.zsh.enable = true;
  };

  flake.homeModules.zsh = { ... }: {
    programs.zsh = {
      enable = true;
    };
  };
}
