{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    ./hardware.nix
  ];

  networking.hostName = "nixos";

  system.stateVersion = "25.11";
}
