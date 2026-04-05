{ lib, ... }:

{
  options.flake.homeModules = lib.mkOption {
    type = lib.types.attrsOf lib.types.deferredModule;
    default = { };
    description = "Home-manager modules exported by this flake";
  };
}
