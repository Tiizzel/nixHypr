{ ... }:

{
  flake.homeModules.atuin = { pkgs, ... }: {
    programs.atuin = {
      enable = true;
      settings = {
        search_mode = "fuzzy";
      };
    };
  };
}
