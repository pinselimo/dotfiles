{ config, pkgs, ... }:
{
  imports =
    [
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

