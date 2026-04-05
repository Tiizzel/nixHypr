{ ... }:

{
  flake.nixosModules.vim = { pkgs, ... }: {
    environment.systemPackages = [ pkgs.vim ];
  };
}
