{ config, pkgs, lib, inputs, hostVars, ... }:

{
  imports = [
    ./hardware.nix
  ];

  networking.hostName = hostVars.hostName;

  system.stateVersion = "25.11";
}
