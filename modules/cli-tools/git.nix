{ ... }:

{
  flake.nixosModules.git = { pkgs, ... }: {
    environment.systemPackages = [ pkgs.git ];
  };

  flake.homeModules.git = { pkgs, hostVars, ... }: {
    programs.git = {
      enable = true;
      
      settings = {
        user = {
          name = hostVars.gitUsername;
          email = hostVars.gitEmail;
        };

        push.default = "simple";
        credential.helper = "cache --timeout=7200";
        init.defaultBranch = "main";
        log.decorate = "full";
        log.date = "iso";
        merge.conflictStyle = "diff3";

        alias = {
          br = "branch --sort=-committerdate";
          co = "checkout";
          df = "diff";
          com = "commit -a";
          gs = "stash";
          gp = "pull";
          lg = "log --graph --pretty=format:'%Cred%h%Creset - %C(yellow)%d%Creset %s %C(green)(%cr)%C(bold blue) <%an>%Creset' --abbrev-commit";
          st = "status";
        };
      };
    };
  };
}
