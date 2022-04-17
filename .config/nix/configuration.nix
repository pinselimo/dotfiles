#Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./overlays.nix
      ./nix.nix
      ./fonts.nix
      ./users.nix
      ./system.nix

      ./programs.nix
      ./services.nix
      ./environment.nix
      ./neovim.nix

      ./hardware-configuration.nix
    ];
}

