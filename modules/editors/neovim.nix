{ ... }:

{
  flake.nixosModules.neovim = { pkgs, ... }: {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
    };

    environment.systemPackages = with pkgs; [
      nodejs
      ripgrep
      fd
    ];
  };
}
